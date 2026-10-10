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
import ipaddress
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

        if line.startswith(("|", "@@|")):
            # Adblock rule: "||d^", "|d^" (exact start), optionally ending in "|" and/or "$modifiers".
            exception = line.startswith("@@")
            body = line[2:] if exception else line
            body = body[2:] if body.startswith("||") else body[1:]
            if "^" not in body:
                continue
            domain, _, rest = body.partition("^")
            rest = rest.lstrip("|")
            if rest and not rest.startswith("$"):
                continue  # path or pattern after the domain: not a DNS block
            modifiers = rest[1:].split(",") if rest else [""]
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


def fetch(source):
    """Return a source's text: a repo file ("path") or a download ("url")."""
    if "path" in source:
        return (ROOT / source["path"]).read_text(encoding="utf-8")
    req = urllib.request.Request(source["url"], headers={"User-Agent": USER_AGENT})
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


def approx(n):
    if n >= 1000:
        return "~%sk" % format(round(n / 1000, 1 if n < 10000 else None), "g")
    return str(n)


def replace_block(text, name, body):
    start, end = "<!-- %s:START -->" % name, "<!-- %s:END -->" % name
    pattern = re.compile(re.escape(start) + ".*?" + re.escape(end), re.S)
    return pattern.sub(lambda _: "%s\n%s\n%s" % (start, body, end), text)


def update_readme(lists, sources):
    """Regenerate the Lists and Sources tables in README.md from the config."""
    path = ROOT / "README.md"
    if not path.exists():
        return
    raw = REPO_URL.replace("github.com", "raw.githubusercontent.com") + "/master/"
    rows = ["| List | What it blocks | Domains | Download |", "|---|---|---|---|"]
    for name, meta in lists.items():
        rows.append("| `%s` | %s | %s | [Adblock](%sadblock/%s.txt) · [Plain](%s%s.txt) · [Hosts](%shosts/%s.txt) |" % (
            name, meta["description"], approx(existing_count(ROOT / ("%s.txt" % name))),
            raw, name, raw, name, raw, name))

    used = {}
    for name, meta in lists.items():
        for sid in meta["sources"]:
            used.setdefault(sid, []).append("`%s`" % name)
    srows = ["| Source | Used in | License |", "|---|---|---|"]
    for sid, src in sources.items():
        if sid in used:
            srows.append("| [%s](%s) | %s | %s |" % (src["name"], src["home"], ", ".join(used[sid]), src["license"]))

    text = path.read_text(encoding="utf-8")
    text = replace_block(text, "LISTS", "\n".join(rows))
    text = replace_block(text, "SOURCES", "\n".join(srows))
    write_if_changed(path, text)


def adguard_ip_rules(prefixes):
    """Turn CIDR prefixes into AdGuard Home rules.

    AdGuard Home checks every A/AAAA address in a DNS answer against its rules as a
    string, so "|169.136.79." blocks any answer inside 169.136.79.0/24. Prefixes are
    expanded to whole octets (IPv4) or whole 16-bit groups (IPv6) to match exactly.
    """
    rules = set()
    for p in prefixes:
        net = ipaddress.ip_network(p, strict=False)
        if net.version == 4:
            size = 8 * max(1, -(-net.prefixlen // 8))  # round up to a whole octet
            for sub in (net.subnets(new_prefix=size) if size > net.prefixlen else [net]):
                octets = str(sub.network_address).split(".")[: size // 8]
                rules.add("|%s." % ".".join(octets) if size < 32 else "|%s^" % ".".join(octets))
        else:
            if net.prefixlen > 48 or net.prefixlen % 16:
                continue  # only whole leading groups can be matched safely as text
            groups = net.network_address.exploded.split(":")[: net.prefixlen // 16]
            if any(int(g, 16) == 0 for g in groups):
                continue  # zero groups may be shortened to "::" in answers
            rules.add("|%s:" % ":".join(format(int(g, 16), "x") for g in groups))
    # Drop rules already covered by a shorter one.
    return sorted(r for r in rules if not any(o != r and r.startswith(o) for o in rules))


def build_ip_lists(built):
    """Write ips/<name>.txt (+ -ipv4/-ipv6) from the prefixes a company's own network announces."""
    path = ROOT / "ips.json"
    if not path.exists():
        return []
    problems = []
    for name, meta in json.loads(path.read_text()).items():
        prefixes = set()
        try:
            for asn in meta["asns"]:
                data = json.loads(fetch({"url": "https://stat.ripe.net/data/announced-prefixes/data.json?resource=AS%d" % asn}))
                prefixes |= {p["prefix"] for p in data["data"]["prefixes"]}
        except Exception as e:  # noqa: BLE001
            problems.append("ips/%s: skipped, prefix lookup failed: %s" % (name, e))
            continue
        out = ROOT / "ips" / ("%s.txt" % name)
        previous = existing_count(out)
        if not prefixes or (previous and len(prefixes) < previous * (1 - MAX_SHRINK)):
            problems.append("ips/%s: skipped, shrank from %d to %d prefixes" % (name, previous, len(prefixes)))
            continue
        v4 = sorted((p for p in prefixes if ":" not in p), key=lambda p: [int(x) for x in re.split(r"[./]", p)])
        v6 = sorted(p for p in prefixes if ":" in p)
        head = lambda fmt, n: "".join("# %s\n" % l for l in [
            "Title: %s" % meta["title"], "Description: %s" % meta["description"], "Format: %s" % fmt,
            "Homepage: %s" % REPO_URL, "Last modified: %s" % built, "Entries: %d" % n,
            "Source: prefixes announced by AS%s (RIPEstat)" % ", AS".join(map(str, meta["asns"]))]) + "\n"
        write_if_changed(out, head("CIDR, IPv4 + IPv6 (router/firewall)", len(v4) + len(v6)) + "\n".join(v4 + v6) + "\n")
        write_if_changed(ROOT / "ips" / ("%s-ipv4.txt" % name), head("CIDR, IPv4 only", len(v4)) + "\n".join(v4) + "\n")
        write_if_changed(ROOT / "ips" / ("%s-ipv6.txt" % name), head("CIDR, IPv6 only", len(v6)) + "\n".join(v6) + "\n")
        rules = adguard_ip_rules(prefixes)
        write_if_changed(ROOT / "ips" / ("%s-adguard.txt" % name),
                         "[Adblock Plus]\n" + head("AdGuard Home rules: block DNS answers pointing into these IP ranges", len(rules)).replace("# ", "! ")
                         + "".join(r + "\n" for r in rules))
        print("  wrote ips/%-21s %8d IPv4 / %8d IPv6" % (name, len(v4), len(v6)))
    return problems


def main():
    lists = json.loads((ROOT / "lists.json").read_text())
    sources = json.loads((ROOT / "sources.json").read_text())
    allow = read_local(ROOT / "allowlist.txt")
    protected = read_local(ROOT / "protected.txt")
    built = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%d %H:%M UTC")

    needed = sorted({s for l in lists.values() for s in l["sources"]})
    unknown = [s for s in needed if s not in sources]
    if unknown:
        sys.exit("Unknown source ids in lists.json: %s" % ", ".join(unknown))

    results, failed = {}, {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:
        futures = {pool.submit(fetch, sources[s]): s for s in needed}
        for fut in concurrent.futures.as_completed(futures):
            sid = futures[fut]
            try:
                text = fut.result()
                src = sources[sid]
                # "services": take the rules of these AdGuard Home "Blocked services" entries.
                if src.get("services"):
                    text = "\n".join(r for svc in json.loads(text)["blocked_services"]
                                     if svc["id"] in src["services"] for r in svc["rules"])
                blocked, exceptions = parse(text)
                # Optional "include" regexes keep only matching entries; "exclude" regexes drop
                # entries that would break things.
                includes = [re.compile(p) for p in src.get("include", [])]
                if includes:
                    blocked = {d for d in blocked if any(p.search(d) for p in includes)}
                    exceptions = {d for d in exceptions if any(p.search(d) for p in includes)}
                excludes = [re.compile(p) for p in src.get("exclude", [])]
                if excludes:
                    blocked = {d for d in blocked if not any(p.search(d) for p in excludes)}
                # "exceptions": the whole source is an allowlist for the lists that use it.
                if src.get("exceptions"):
                    exceptions, blocked = exceptions | blocked, set()
                # "tlds": bare top-level domains (e.g. "zip"), only expressible as adblock rules.
                tlds = set()
                if src.get("tlds"):
                    tlds = {l.strip().lower() for l in text.splitlines()
                            if re.fullmatch(r"[a-z][a-z0-9-]{1,62}", l.strip().lower())}
                results[sid] = (blocked, exceptions, tlds)
                print("  ok   %-28s %8d domains %s" % (sid, len(blocked) or len(exceptions),
                                                     "(%d TLDs)" % len(tlds) if tlds else ""))
            except Exception as e:  # noqa: BLE001 - report and keep going
                failed[sid] = str(e)
                print("  FAIL %-28s %s" % (sid, e))

    problems = []
    for name, meta in lists.items():
        missing = [s for s in meta["sources"] if s in failed]
        if missing:
            problems.append("%s: skipped, source(s) failed: %s" % (name, ", ".join(missing)))
            continue
        domains, tlds, list_allow, upstream_allow = set(), set(), set(), set()
        for sid in meta["sources"]:
            blocked, exceptions, src_tlds = results[sid]
            domains |= blocked - exceptions
            tlds |= src_tlds
            if sources[sid].get("exceptions"):
                list_allow |= exceptions
            else:
                upstream_allow |= exceptions
        domains |= read_local(ROOT / "custom" / ("%s.txt" % name))
        # Essential sites are never blocked unless this list is meant to block them.
        guard = protected - set(meta.get("may_block", []))
        removed = sorted(domains & guard)
        if removed:
            print("  note %-27s removed protected: %s" % (name, ", ".join(removed)))
        domains -= allow | list_allow | guard
        list_allow |= allow | guard

        out = ROOT / ("%s.txt" % name)
        previous = existing_count(out)
        if previous and len(domains) < previous * (1 - MAX_SHRINK):
            problems.append("%s: skipped, shrank from %d to %d entries" % (name, previous, len(domains)))
            continue

        meta = dict(meta, built=built, source_info=[sources[s] for s in meta["sources"]])
        plain = sorted(domains)
        # Domains under a blocked TLD are already covered by its "||tld^" rule.
        wild = sorted(collapse({d for d in domains if d.rsplit(".", 1)[-1] not in tlds})) + \
            sorted(tlds)
        # Allowlisted subdomains of a blocked parent (or TLD) need an explicit exception.
        blocked_all = domains | tlds if tlds else domains
        # Upstream "@@" exceptions (e.g. AdGuard keeps pagead.l.doubleclick.net working) are kept
        # unless another source blocks that exact domain.
        wild_allow = sorted(a for a in list_allow | (upstream_allow - domains) if any(
            ".".join(a.split(".")[i:]) in blocked_all for i in range(1, a.count(".") + 1)))

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

    problems += build_ip_lists(built)
    update_readme(lists, sources)
    for p in problems:
        print("WARNING: " + p)
    if problems:
        sys.exit(1)


if __name__ == "__main__":
    (ROOT / "adblock").mkdir(exist_ok=True)
    (ROOT / "hosts").mkdir(exist_ok=True)
    (ROOT / "ips").mkdir(exist_ok=True)
    main()
