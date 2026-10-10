#!/bin/bash
# Pi-Hole-Block-Lists for Linux: block the lists you choose on this computer, without Pi-hole
# or AdGuard Home, by adding them to the system hosts file (/etc/hosts).
#
#   sudo bash linux.sh                         pick lists from a menu
#   sudo bash linux.sh --lists ads-and-tracking,security
#   sudo bash linux.sh --update                re-download the lists you picked last time
#   sudo bash linux.sh --remove                remove all blocking and the daily update
#   sudo bash linux.sh --auto-update on|off    turn the daily update on or off
#
# Other options: --yes (don't ask questions), --hosts-file PATH (use another file, for testing).
# Your original hosts file is backed up once to /etc/hosts.block-lists-backup.
set -euo pipefail

REPO_RAW="${BLOCK_LISTS_REPO:-https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master}"
HOSTS_FILE="/etc/hosts"
INSTALL_DIR="/usr/local/share/block-lists"
CRON="/etc/cron.daily/block-lists"
UNIT="/etc/systemd/system/block-lists"
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
  command -v sudo >/dev/null || { echo "Please run this as root." >&2; exit 1; }
  exec sudo /bin/bash "$0" "${ORIG_ARGS[@]+"${ORIG_ARGS[@]}"}"
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

download() {
  if command -v curl >/dev/null; then curl -fsSL --retry 3 "$1" -o "$2"
  else wget -q -O "$2" "$1"; fi
}

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
  resolvectl flush-caches 2>/dev/null || systemd-resolve --flush-caches 2>/dev/null || true
  nscd -i hosts 2>/dev/null || true
}

auto_update_installed() { [ -f "$CRON" ] || [ -f "$UNIT.timer" ]; }

set_auto_update() {
  [ "$TESTING" = 1 ] && { echo "(testing: daily update not changed)"; return; }
  if [ "$1" = on ]; then
    mkdir -p "$INSTALL_DIR"
    if [ -f "$0" ]; then cp "$0" "$INSTALL_DIR/linux.sh"; else download "$REPO_RAW/install/linux.sh" "$INSTALL_DIR/linux.sh"; fi
    if [ -d /etc/cron.daily ]; then
      printf '#!/bin/sh\n/bin/bash %s/linux.sh --update --yes >> /var/log/block-lists.log 2>&1\n' "$INSTALL_DIR" > "$CRON"
      chmod 755 "$CRON"
      echo "Daily update is ON (cron.daily, log: /var/log/block-lists.log)."
    else
      printf '[Unit]\nDescription=Update block lists\n[Service]\nType=oneshot\nExecStart=/bin/bash %s/linux.sh --update --yes\n' "$INSTALL_DIR" > "$UNIT.service"
      printf '[Unit]\nDescription=Update block lists daily\n[Timer]\nOnCalendar=*-*-* 04:30\nPersistent=true\n[Install]\nWantedBy=timers.target\n' > "$UNIT.timer"
      systemctl daemon-reload && systemctl enable --now block-lists.timer
      echo "Daily update is ON (systemd timer block-lists.timer)."
    fi
  else
    rm -f "$CRON"
    if [ -f "$UNIT.timer" ]; then systemctl disable --now block-lists.timer 2>/dev/null || true; rm -f "$UNIT.timer" "$UNIT.service"; systemctl daemon-reload 2>/dev/null || true; fi
    rm -rf "$INSTALL_DIR"
    echo "Daily update is OFF."
  fi
}

if [ "$MODE" = remove ]; then
  strip_block > "$TMP/hosts"; cat "$TMP/hosts" > "$HOSTS_FILE"
  rm -f "$CONF"; flush_dns
  [ "$TESTING" = 1 ] || { auto_update_installed && set_auto_update off; }
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
  echo "# Remove with: sudo bash linux.sh --remove"
  awk '{print "0.0.0.0 " $0}' "$TMP/domains"
  echo "$END"
} > "$TMP/hosts"
cat "$TMP/hosts" > "$HOSTS_FILE"
printf 'LISTS=%s\n' "$LISTS" > "$CONF"
flush_dns
echo "Done: $TOTAL domains blocked ($LISTS)."

if [ -n "$AUTO" ]; then set_auto_update "$AUTO"
elif [ "$MODE" = install ] && ! auto_update_installed && [ "$TESTING" = 0 ] && ask "Update these lists automatically every day?" y; then
  set_auto_update on
fi
echo "Tip: restart your browser so it forgets cached addresses."
