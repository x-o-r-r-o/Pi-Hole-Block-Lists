#!/bin/bash
# Pi-Hole-Block-Lists for Ubiquiti EdgeRouter (EdgeOS 2.x): block the lists you choose for every
# device on your network, using the router's own DNS forwarder (dnsmasq). Run it on the router over SSH.
#
#   sudo bash edgerouter.sh                         pick lists from a menu
#   sudo bash edgerouter.sh --lists ads-and-tracking,security
#   sudo bash edgerouter.sh --update                re-download your lists (also runs daily by itself)
#   sudo bash edgerouter.sh --remove                remove all blocking and the daily update
#
# Other options: --yes (don't ask questions), --dir PATH (testing: write the files there and leave the
# router configuration alone). Everything is kept under /config, so it survives reboots and firmware upgrades.
set -euo pipefail

REPO_RAW="${BLOCK_LISTS_REPO:-https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master}"
DIR="/config/block-lists"
SCRIPT_COPY="/config/scripts/block-lists.sh"
TASK="block-lists"
RECOMMENDED="ads-and-tracking,security"
CFG="/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper"

LISTS="" MODE="install" YES=0 TESTING=0
ORIG_ARGS=("$@")
while [ $# -gt 0 ]; do
  case "$1" in
    --lists) LISTS="${2:-}"; shift ;;
    --update) MODE="update" ;;
    --remove) MODE="remove" ;;
    --dir) DIR="${2:-}"; TESTING=1; shift ;;
    --yes|-y) YES=1 ;;
    -h|--help) sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $1 (see --help)" >&2; exit 1 ;;
  esac
  shift
done
HOSTS="$DIR/blocklist.hosts"
CONF="$DIR/block-lists.conf"

if [ "$TESTING" = 0 ] && [ "$(id -u)" -ne 0 ]; then
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

configure() {  # configure set|delete: point dnsmasq at our hosts file and schedule the daily update
  [ "$TESTING" = 1 ] && { echo "(testing: router configuration not changed)"; return; }
  [ -x "$CFG" ] || { echo "This doesn't look like an EdgeRouter (no $CFG)." >&2; exit 1; }
  "$CFG" begin
  if [ "$1" = set ]; then
    "$CFG" set service dns forwarding options "addn-hosts=$HOSTS"
    "$CFG" set system task-scheduler task "$TASK" executable path "$SCRIPT_COPY"
    "$CFG" set system task-scheduler task "$TASK" executable arguments "--update --yes"
    "$CFG" set system task-scheduler task "$TASK" interval 1d
  else
    "$CFG" delete service dns forwarding options "addn-hosts=$HOSTS" || true
    "$CFG" delete system task-scheduler task "$TASK" || true
  fi
  "$CFG" commit
  "$CFG" save
  "$CFG" end
}

reload_dns() {  # dnsmasq re-reads addn-hosts files on SIGHUP
  [ "$TESTING" = 1 ] && return
  pkill -HUP dnsmasq 2>/dev/null || true
}

if [ "$MODE" = remove ]; then
  configure delete
  rm -rf "$DIR"; [ "$TESTING" = 1 ] || rm -f "$SCRIPT_COPY"
  reload_dns
  echo "Blocking removed from the router."
  exit 0
fi

if [ "$TESTING" = 0 ] && ! grep -q 'forwarding' /config/config.boot 2>/dev/null; then
  echo "The router's DNS forwarding service isn't set up, so devices don't use it for DNS." >&2
  echo "Run the 'Basic Setup' wizard, or see the EdgeRouter section of the README, then run this again." >&2
  exit 1
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

# dnsmasq needs roughly 200 bytes of memory per name; warn if that's over half of what's free.
NEED_KB=$((TOTAL / 5))
FREE_KB=$(awk '/^MemAvailable:/{print $2}' /proc/meminfo 2>/dev/null || echo 0)
if [ "$MODE" != update ] && [ "${FREE_KB:-0}" -gt 0 ] && [ "$NEED_KB" -gt $((FREE_KB / 2)) ]; then
  ask "$TOTAL domains need about $((NEED_KB / 1024)) MB, but only $((FREE_KB / 1024)) MB is free. Continue anyway?" n \
    || { echo "Cancelled. Pick fewer or smaller lists."; exit 1; }
fi

mkdir -p "$DIR"
{
  echo "# Pi-Hole-Block-Lists | Lists: $LISTS | Updated: $(date -u '+%Y-%m-%d %H:%M UTC') | $TOTAL domains"
  awk '{print "0.0.0.0 " $0}' "$TMP/domains"
} > "$TMP/hosts"
mv "$TMP/hosts" "$HOSTS"; chmod 644 "$HOSTS"
printf 'LISTS=%s\n' "$LISTS" > "$CONF"

if [ "$MODE" = install ]; then
  if [ "$TESTING" = 0 ]; then
    mkdir -p "$(dirname "$SCRIPT_COPY")"
    if [ -f "$0" ]; then cp "$0" "$SCRIPT_COPY"; else download "$REPO_RAW/install/edgerouter.sh" "$SCRIPT_COPY"; fi
    chmod 755 "$SCRIPT_COPY"
  fi
  configure set
fi
reload_dns
echo "Done: $TOTAL domains blocked ($LISTS). The lists update every day."
