#!/bin/bash
# Pi-Hole-Block-Lists for macOS: block the lists you choose on this Mac, without Pi-hole
# or AdGuard Home, by adding them to the system hosts file (/etc/hosts).
#
#   sudo bash macos.sh                         pick lists from a menu
#   sudo bash macos.sh --lists ads-and-tracking,security
#   sudo bash macos.sh --update                re-download the lists you picked last time
#   sudo bash macos.sh --remove                remove all blocking and the daily update
#   sudo bash macos.sh --auto-update on|off    turn the daily update on or off
#
# Other options: --yes (don't ask questions), --hosts-file PATH (use another file, for testing).
# Your original hosts file is backed up once to /etc/hosts.block-lists-backup.
set -euo pipefail

REPO_RAW="${BLOCK_LISTS_REPO:-https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master}"
HOSTS_FILE="/etc/hosts"
INSTALL_DIR="/usr/local/share/block-lists"
PLIST="/Library/LaunchDaemons/com.x-o-r-r-o.block-lists.plist"
BEGIN="# >>> Pi-Hole-Block-Lists >>>"
END="# <<< Pi-Hole-Block-Lists <<<"
RECOMMENDED="ads-and-tracking,security"
WARN_ENTRIES=1000000

LISTS="" MODE="install" AUTO="" YES=0 TESTING=0
ORIG_ARGS=("$@")
while [ $# -gt 0 ]; do
  case "$1" in
    --lists) LISTS="${2:-}"; shift ;;
    --update) MODE="update" ;;
    --remove) MODE="remove" ;;
    --auto-update) AUTO="${2:-}"; shift ;;
    --hosts-file) HOSTS_FILE="${2:-}"; TESTING=1; shift ;;
    --yes|-y) YES=1 ;;
    -h|--help) sed -n '2,14p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $1 (see --help)" >&2; exit 1 ;;
  esac
  shift
done
CONF="$(dirname "$HOSTS_FILE")/block-lists.conf"

if [ "$TESTING" = 0 ] && [ "$(id -u)" -ne 0 ]; then
  echo "Administrator rights are needed to change $HOSTS_FILE. You may be asked for your password."
  exec sudo /bin/bash "$0" "${ORIG_ARGS[@]+"${ORIG_ARGS[@]}"}"
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

download() { curl -fsSL --retry 3 "$1" -o "$2"; }

ask() {  # ask "question" default(y/n) -> 0 for yes
  if [ "$YES" = 1 ] || [ ! -t 0 ]; then [ "$2" = y ]; return; fi
  local hint="[y/N]"; [ "$2" = y ] && hint="[Y/n]"
  printf "%s %s " "$1" "$hint"; read -r reply
  case "${reply:-$2}" in [Yy]*) return 0 ;; *) return 1 ;; esac
}

strip_block() {  # print the hosts file without our block
  awk -v b="$BEGIN" -v e="$END" 'index($0,b)==1{skip=1;next} skip&&index($0,e)==1{skip=0;next} !skip' "$HOSTS_FILE"
}

flush_dns() {
  [ "$TESTING" = 1 ] && return
  dscacheutil -flushcache 2>/dev/null || true
  killall -HUP mDNSResponder 2>/dev/null || true
}

set_auto_update() {
  [ "$TESTING" = 1 ] && { echo "(testing: daily update not changed)"; return; }
  if [ "$1" = on ]; then
    mkdir -p "$INSTALL_DIR"
    if [ -f "$0" ]; then cp "$0" "$INSTALL_DIR/macos.sh"; else download "$REPO_RAW/install/macos.sh" "$INSTALL_DIR/macos.sh"; fi
    cat > "$PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>Label</key><string>com.x-o-r-r-o.block-lists</string>
  <key>ProgramArguments</key><array>
    <string>/bin/bash</string><string>$INSTALL_DIR/macos.sh</string><string>--update</string><string>--yes</string>
  </array>
  <key>StartCalendarInterval</key><dict><key>Hour</key><integer>4</integer><key>Minute</key><integer>30</integer></dict>
  <key>StandardOutPath</key><string>/var/log/block-lists.log</string>
  <key>StandardErrorPath</key><string>/var/log/block-lists.log</string>
</dict></plist>
PLIST
    launchctl bootout system "$PLIST" 2>/dev/null || true
    launchctl bootstrap system "$PLIST"
    echo "Daily update is ON (04:30, log: /var/log/block-lists.log)."
  else
    launchctl bootout system "$PLIST" 2>/dev/null || true
    rm -f "$PLIST"; rm -rf "$INSTALL_DIR"
    echo "Daily update is OFF."
  fi
}

if [ "$MODE" = remove ]; then
  strip_block > "$TMP/hosts"; cat "$TMP/hosts" > "$HOSTS_FILE"
  rm -f "$CONF"; flush_dns
  [ "$TESTING" = 1 ] || { [ -f "$PLIST" ] && set_auto_update off; }
  echo "Blocking removed. Your other hosts entries are untouched."
  exit 0
fi

if [ -n "$AUTO" ] && [ "$MODE" = install ] && [ -z "$LISTS" ]; then
  set_auto_update "$AUTO"; exit 0
fi

echo "Downloading the list catalogue..."
download "$REPO_RAW/install/catalog.tsv" "$TMP/catalog.tsv"
NAMES=(); TITLES=(); COUNTS=(); DESCS=()
while IFS="$(printf '\t')" read -r name title count desc; do
  [ "$name" = name ] && continue
  NAMES+=("$name"); TITLES+=("$title"); COUNTS+=("$count"); DESCS+=("$desc")
done < "$TMP/catalog.tsv"

if [ "$MODE" = update ]; then
  [ -f "$CONF" ] || { echo "Nothing to update: no lists installed yet. Run without --update first." >&2; exit 1; }
  LISTS="$(sed -n 's/^LISTS=//p' "$CONF")"
elif [ -z "$LISTS" ]; then
  echo
  echo "Available lists (domains in brackets):"
  i=0
  while [ $i -lt ${#NAMES[@]} ]; do
    printf "%3d) %s [%s] - %s\n" $((i + 1)) "${TITLES[$i]}" "${COUNTS[$i]}" "${NAMES[$i]}"
    printf "      %s\n" "$(printf '%s' "${DESCS[$i]}" | cut -c1-110)"
    i=$((i + 1))
  done
  echo
  echo "Type the numbers of the lists you want, separated by spaces (e.g. 1 9 14),"
  printf "or press Enter for the recommended set (Ads & Tracking + Security): "
  read -r picks
  if [ -z "$picks" ]; then LISTS="$RECOMMENDED"; else
    for n in $(echo "$picks" | tr ',' ' '); do
      case "$n" in ''|*[!0-9]*) echo "Ignoring '$n' (not a number)"; continue ;; esac
      if [ "$n" -ge 1 ] && [ "$n" -le ${#NAMES[@]} ]; then LISTS="${LISTS:+$LISTS,}${NAMES[$((n - 1))]}"
      else echo "Ignoring $n (no such list)"; fi
    done
  fi
fi
[ -n "$LISTS" ] || { echo "No lists selected." >&2; exit 1; }

: > "$TMP/domains"; GOOD=""
for name in $(echo "$LISTS" | tr ',' ' '); do
  if ! printf '%s\n' "${NAMES[@]}" | grep -qx "$name"; then echo "Unknown list: $name (skipped)"; continue; fi
  GOOD="${GOOD:+$GOOD,}$name"
  echo "Downloading $name..."
  download "$REPO_RAW/hosts/$name.txt" "$TMP/$name.txt"
  awk '$1=="0.0.0.0" && NF>=2 {print $2}' "$TMP/$name.txt" >> "$TMP/domains"
done
sort -u "$TMP/domains" -o "$TMP/domains"
TOTAL=$(wc -l < "$TMP/domains" | tr -d ' ')
[ "$TOTAL" -gt 0 ] || { echo "The selected lists are empty; nothing changed." >&2; exit 1; }
LISTS="$GOOD"
if [ "$TOTAL" -gt "$WARN_ENTRIES" ] && [ "$MODE" != update ]; then
  ask "That's $TOTAL domains, which can slow down name lookups. Continue?" n || { echo "Cancelled."; exit 1; }
fi

[ -f "$HOSTS_FILE.block-lists-backup" ] || cp "$HOSTS_FILE" "$HOSTS_FILE.block-lists-backup"
{
  strip_block
  echo "$BEGIN"
  echo "# Lists: $LISTS | Updated: $(date -u '+%Y-%m-%d %H:%M UTC') | $TOTAL domains"
  echo "# Remove with: sudo bash macos.sh --remove"
  awk '{print "0.0.0.0 " $0}' "$TMP/domains"
  echo "$END"
} > "$TMP/hosts"
cat "$TMP/hosts" > "$HOSTS_FILE"
printf 'LISTS=%s\n' "$LISTS" > "$CONF"
flush_dns
echo "Done: $TOTAL domains blocked ($LISTS)."

if [ -n "$AUTO" ]; then set_auto_update "$AUTO"
elif [ "$MODE" = install ] && [ ! -f "$PLIST" ] && [ "$TESTING" = 0 ] && ask "Update these lists automatically every day?" y; then
  set_auto_update on
fi
echo "Tip: restart your browser so it forgets cached addresses."
