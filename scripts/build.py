#!/usr/bin/env python3
"""Build the block lists from upstream sources.

Reads lists.json + sources.json, downloads every source, merges and dedupes the
domains, applies custom/<list>.txt additions and allowlist.txt removals, then writes:

  <list>.txt          plain domains      (Pi-hole v5/v6, AdGuard Home)
  adblock/<list>.txt  ||domain^ rules     (AdGuard Home, Pi-hole v6; also blocks subdomains)
  hosts/<list>.txt    0.0.0.0 domain     (hosts-file tools, AdGuard Home)

Only the Python standard library is used. Usage: python3 scripts/build.py
"""
import concurrent.futures
import datetime
import json
import re
import sys
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
REPO_URL = "https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists"
USER_AGENT = "Pi-Hole-Block-Lists-builder (+%s)" % REPO_URL

# A list may shrink this much between builds before we refuse to overwrite it,
# so a broken upstream can't silently empty a list people rely on.
MAX_SHRINK = 0.5

DOMAIN_RE = re.compile(r"^(?=.{1,253}$)(?!-)[a-z0-9_-]{1,63}(?:\.(?!-)[a-z0-9_-]{1,63})+$")
IP_RE = re.compile(r"^\d{1,3}(?:\.\d{1,3}){3}$")
HOSTS_IPS = {"0.0.0.0", "127.0.0.1", "::", "::1", "0", "::0"}
IGNORED = {
    "localhost", "localhost.localdomain", "local", "broadcasthost",
    "ip6-localhost", "ip6-loopback", "ip6-localnet", "ip6-mcastprefix",
    "ip6-allnodes", "ip6-allrouters", "ip6-allhosts", "0.0.0.0",
}
# Adblock modifiers that still mean "block this whole domain" at the DNS level.
SAFE_MODIFIERS = {"", "important", "third-party", "3p", "all", "document", "doc"}


def clean(domain):
    d = domain.strip().strip(".").lower()
    if d.startswith("*."):
        d = d[2:]
    if d in IGNORED or IP_RE.match(d) or not DOMAIN_RE.match(d):
        return None
    return d


def parse(text):
    """Parse hosts, plain-domain or adblock text. Returns (blocked, exceptions)."""
    blocked, exceptions = set(), set()
    for raw in text.splitlines():
        line = raw.strip()
        if not line or line[0] in "#![":
            continue
        line = line.split(" #", 1)[0].split("\t#", 1)[0].strip()
        if line.startswith("*."):
            line = line[2:]

        if line.startswith("||") or line.startswith("@@||"):
            exception = line.startswith("@@")
            body = line[4:] if exception else line[2:]
            if "^" not in body:
                continue
            domain, _, rest = body.partition("^")
            modifiers = rest.lstrip("$").split(",") if rest else [""]
            if any(m.strip().lstrip("~") not in SAFE_MODIFIERS for m in modifiers):
                continue  # app-, path- or site-specific rule: not a DNS block
            d = clean(domain)
            if d:
                (exceptions if exception else blocked).add(d)
            continue
        if any(c in line for c in "/$#@^|*=:") and not line.split()[0] in HOSTS_IPS:
            continue  # cosmetic or URL rule

        parts = line.split()
        if len(parts) >= 2 and parts[0] in HOSTS_IPS:
            candidates = parts[1:]
        elif len(parts) == 1:
            candidates = parts
        else:
            continue
        for c in candidates:
            d = clean(c)
            if d:
                blocked.add(d)
    return blocked, exceptions


def fetch(url):
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=120) as resp:
        return resp.read().decode("utf-8", errors="replace")


def read_local(path):
    if not path.exists():
        return set()
    return parse(path.read_text(encoding="utf-8"))[0]


def collapse(domains):
    """Drop subdomains whose parent is listed (adblock rules already cover them)."""
    kept = set()
    for d in sorted(domains, key=lambda x: x.count(".")):
        labels = d.split(".")
        if not any(".".join(labels[i:]) in kept for i in range(1, len(labels) - 1)):
            kept.add(d)
    return kept


def existing_count(path):
    if not path.exists():
        return 0
    return sum(1 for l in path.open(encoding="utf-8") if l.strip() and not l.startswith(("#", "!")))


def write_if_changed(path, content):
    """Write unless only the "Last modified" header line would change."""
    def strip(text):
        return [l for l in text.splitlines() if "Last modified:" not in l]
    if path.exists() and strip(path.read_text(encoding="utf-8")) == strip(content):
        return
    path.write_text(content, encoding="utf-8")


def header(comment, meta, count, fmt):
    lines = [
        "Title: %s" % meta["title"],
        "Description: %s" % meta["description"],
        "Format: %s" % fmt,
        "Homepage: %s" % REPO_URL,
        "Last modified: %s" % meta["built"],
        "Entries: %d" % count,
        "",
        "Built from these sources (see their licenses):",
    ] + ["  - %s: %s" % (s["name"], s["home"]) for s in meta["source_info"]]
    return "".join("%s %s\n" % (comment, l) if l else "%s\n" % comment for l in lines) + "\n"


def main():
    lists = json.loads((ROOT / "lists.json").read_text())
    sources = json.loads((ROOT / "sources.json").read_text())
    allow = read_local(ROOT / "allowlist.txt")
    built = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%d %H:%M UTC")

    needed = sorted({s for l in lists.values() for s in l["sources"]})
    unknown = [s for s in needed if s not in sources]
    if unknown:
        sys.exit("Unknown source ids in lists.json: %s" % ", ".join(unknown))

    results, failed = {}, {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:
        futures = {pool.submit(fetch, sources[s]["url"]): s for s in needed}
        for fut in concurrent.futures.as_completed(futures):
            sid = futures[fut]
            try:
                results[sid] = parse(fut.result())
                print("  ok   %-28s %8d domains" % (sid, len(results[sid][0])))
            except Exception as e:  # noqa: BLE001 - report and keep going
                failed[sid] = str(e)
                print("  FAIL %-28s %s" % (sid, e))

    problems = []
    for name, meta in lists.items():
        missing = [s for s in meta["sources"] if s in failed]
        if missing:
            problems.append("%s: skipped, source(s) failed: %s" % (name, ", ".join(missing)))
            continue
        domains = set()
        for sid in meta["sources"]:
            blocked, exceptions = results[sid]
            domains |= blocked - exceptions
        domains |= read_local(ROOT / "custom" / ("%s.txt" % name))
        domains -= allow

        out = ROOT / ("%s.txt" % name)
        previous = existing_count(out)
        if previous and len(domains) < previous * (1 - MAX_SHRINK):
            problems.append("%s: skipped, shrank from %d to %d entries" % (name, previous, len(domains)))
            continue

        meta = dict(meta, built=built, source_info=[sources[s] for s in meta["sources"]])
        plain = sorted(domains)
        wild = sorted(collapse(domains))
        # Allowlisted subdomains of a blocked parent need an explicit exception.
        wild_allow = sorted(a for a in allow if any(
            ".".join(a.split(".")[i:]) in domains for i in range(1, a.count(".") + 1)))

        write_if_changed(out, header("#", meta, len(plain), "plain domains (Pi-hole, AdGuard Home)")
                         + "\n".join(plain) + "\n")
        write_if_changed(ROOT / "hosts" / out.name,
                         header("#", meta, len(plain), "hosts file (0.0.0.0 domain)")
                         + "".join("0.0.0.0 %s\n" % d for d in plain))
        write_if_changed(ROOT / "adblock" / out.name,
                         "[Adblock Plus]\n"
                         + header("!", meta, len(wild), "adblock ||domain^ (AdGuard Home, Pi-hole v6; blocks subdomains too)")
                         + "".join("@@||%s^\n" % a for a in wild_allow)
                         + "".join("||%s^\n" % d for d in wild))
        print("  wrote %-26s %8d plain / %8d adblock" % (name, len(plain), len(wild)))

    for p in problems:
        print("WARNING: " + p)
    if problems:
        sys.exit(1)


if __name__ == "__main__":
    (ROOT / "adblock").mkdir(exist_ok=True)
    (ROOT / "hosts").mkdir(exist_ok=True)
    main()
