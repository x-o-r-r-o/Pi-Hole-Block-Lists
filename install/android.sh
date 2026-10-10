#!/bin/bash
# Pi-Hole-Block-Lists for Android (run in the Termux app): block the lists you choose on this
# phone, without Pi-hole or AdGuard Home.
#  - Rooted phone: writes the lists into the hosts file (with Magisk, turn on "Systemless hosts").
#  - Normal phone: apps can't change the hosts file, so this shows (and copies) the list links
#    to add in the free AdAway app, which blocks them without root.
#
#   bash android.sh                         pick lists from a menu
#   bash android.sh --lists ads-and-tracking,security
#   bash android.sh --update                (rooted) re-download the lists you picked last time
#   bash android.sh --remove                (rooted) remove all blocking
#
# Other options: --yes, --links (only show the AdAway links), --hosts-file PATH (testing).
set -euo pipefail

REPO_RAW="${BLOCK_LISTS_REPO:-https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master}"
HOSTS_FILE="/system/etc/hosts"
BEGIN="# >>> Pi-Hole-Block-Lists >>>"
END="# <<< Pi-Hole-Block-Lists <<<"
RECOMMENDED="ads-and-tracking,security"
WARN_ENTRIES=1000000

LISTS="" MODE="install" YES=0 TESTING=0 LINKS=0
ORIG_ARGS=("$@")
while [ $# -gt 0 ]; do
  case "$1" in
    --lists) LISTS="${2:-}"; shift ;;
    --update) MODE="update" ;;
    --remove) MODE="remove" ;;
    --links) LINKS=1 ;;
    --hosts-file) HOSTS_FILE="${2:-}"; TESTING=1; shift ;;
    --yes|-y) YES=1 ;;
    -h|--help) sed -n '2,15p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $1 (see --help)" >&2; exit 1 ;;
  esac
  shift
done
CONF="${HOME:-.}/.block-lists.conf"
[ "$TESTING" = 1 ] && CONF="$(dirname "$HOSTS_FILE")/block-lists.conf"

# Rooted? Then we can write the hosts file through "su". Otherwise fall back to AdAway links.
ROOT=0
if [ "$TESTING" = 1 ]; then ROOT=1
elif [ "$LINKS" = 0 ] && command -v su >/dev/null 2>&1 && su -c true >/dev/null 2>&1; then ROOT=1; fi
as_root() { if [ "$TESTING" = 1 ]; then sh -c "$1"; else su -c "$1"; fi; }

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
  as_root "cat '$HOSTS_FILE'" | awk -v b="$BEGIN" -v e="$END" 'index($0,b)==1{skip=1;next} skip&&index($0,e)==1{skip=0;next} !skip'
}

write_hosts() {  # replace the hosts file with $1, keeping its permissions
  as_root "cat '$1' > '$HOSTS_FILE' && chmod 644 '$HOSTS_FILE'" || {
    echo "Could not write $HOSTS_FILE. With Magisk, turn on Settings > Systemless hosts and reboot." >&2; exit 1; }
}

if [ "$MODE" = remove ]; then
  [ "$ROOT" = 1 ] || { echo "Without root nothing was changed on this phone: remove the lists in the AdAway app instead."; exit 0; }
  strip_block > "$TMP/hosts"; write_hosts "$TMP/hosts"
  rm -f "$CONF"
  echo "Blocking removed. Turn airplane mode on and off so apps forget cached addresses."
  exit 0
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

if [ "$ROOT" = 0 ]; then
  URLS=""
  for name in $(echo "$LISTS" | tr ',' ' '); do
    printf '%s\n' "${NAMES[@]}" | grep -qx "$name" || { echo "Unknown list: $name (skipped)"; continue; }
    URLS="$URLS$REPO_RAW/hosts/$name.txt
"
  done
  echo
  echo "This phone isn't rooted, so the hosts file can't be changed. Use the free AdAway app instead:"
  echo "  1. Install AdAway from https://adaway.org (or F-Droid) and open it."
  echo "  2. Choose 'VPN-based ad blocking' (no root needed)."
  echo "  3. Go to Hosts sources > + and add each link below (one per source)."
  echo "  4. Tap the refresh/update button. AdAway keeps them updated automatically."
  echo
  printf '%s' "$URLS"
  if command -v termux-clipboard-set >/dev/null 2>&1; then
    printf '%s' "$URLS" | termux-clipboard-set && echo "(Links copied to the clipboard.)"
  fi
  exit 0
fi

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

BACKUP="${HOME:-.}/hosts.block-lists-backup"; [ "$TESTING" = 1 ] && BACKUP="$HOSTS_FILE.block-lists-backup"
[ -f "$BACKUP" ] || as_root "cat '$HOSTS_FILE'" > "$BACKUP"
{
  strip_block
  echo "$BEGIN"
  echo "# Lists: $LISTS | Updated: $(date -u '+%Y-%m-%d %H:%M UTC') | $TOTAL domains"
  echo "# Remove with: bash android.sh --remove (in Termux)"
  awk '{print "0.0.0.0 " $0}' "$TMP/domains"
  echo "$END"
} > "$TMP/hosts"
write_hosts "$TMP/hosts"
printf 'LISTS=%s\n' "$LISTS" > "$CONF"
echo "Done: $TOTAL domains blocked ($LISTS)."
echo "Turn airplane mode on and off so apps forget cached addresses. Re-run with --update to refresh."

