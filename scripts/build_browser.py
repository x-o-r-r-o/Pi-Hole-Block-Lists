#!/usr/bin/env python3
"""Build browser filter lists that block YouTube ads.

DNS blockers can't remove YouTube ads (the ads come from the same servers as the
videos), but browser ad blockers can: they edit YouTube's player data and hide ad
elements. This script collects the YouTube rules from uBlock Origin's and AdGuard's
own filter lists (both GPL-3.0) and writes:

  browser/youtube-ads-ublock.txt   uBlock Origin / Brave syntax
  browser/youtube-ads-adguard.txt  AdGuard syntax (browser extension and apps)

Rules inside "!#if" conditions keep their conditions. Usage: python3 scripts/build_browser.py
"""
import datetime
import re
import sys
import urllib.request
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from build import REPO_URL, USER_AGENT, existing_count, write_if_changed  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
UBO = "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/%s"
YEAR = datetime.date.today().year
SOURCES = {
    "ublock": [UBO % f for f in ["filters.txt", "filters-general.txt", "filters-mobile.txt", "quick-fixes.txt",
                                 "unbreak.txt", "privacy.txt"]
               + ["filters-%d.txt" % y for y in range(2020, YEAR + 2)]],
    "adguard": ["https://filters.adtidy.org/extension/chromium/filters/2.txt",    # AdGuard Base
                "https://filters.adtidy.org/extension/chromium/filters/11.txt",   # AdGuard Mobile Ads
                "https://filters.adtidy.org/extension/chromium/filters/3.txt"],   # AdGuard Tracking Protection
}
YT = re.compile(r"(?:^|[,|.~=/*])(?:(?:www|m|music|tv)\.)?(youtube\.(?:com|\*)|youtubekids\.com|youtube-nocookie\.com"
                r"|youtu\.be|googlevideo\.com|youtubei\.googleapis\.com|ytimg\.com)(?:$|[,^/$|:])")
COSMETIC = re.compile(r"#@?[?$%]?#|#@?\$\?#|\$@?\$")
MAX_SHRINK = 0.5


def fetch(url):
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    try:
        with urllib.request.urlopen(req, timeout=120) as resp:
            return resp.read().decode("utf-8", errors="replace")
    except urllib.error.HTTPError as e:
        if e.code == 404:  # e.g. next year's uBO file doesn't exist yet
            return ""
        raise


def is_youtube_rule(line):
    m = COSMETIC.search(line)
    if m:  # cosmetic / scriptlet rule: "domains##..."; keep if it targets a YouTube domain
        domains = [d.strip() for d in line[: m.start()].split(",") if d.strip()]
        return any(not d.startswith("~") and YT.search("," + d + ",") for d in domains)
    # Network rule: the pattern itself, or a $domain= option, mentions a YouTube domain.
    pattern, _, options = line.partition("$")
    if YT.search(pattern):
        return True
    dom = re.search(r"(?:^|,)(?:domain|from)=([^,]+)", options)
    return bool(dom and any(not d.startswith("~") and YT.search("," + d + ",") for d in dom.group(1).split("|")))


def extract(text):
    """Return YouTube rules, each wrapped in the "!#if" conditions it appeared under."""
    out, stack = [], []
    for raw in text.splitlines():
        line = raw.strip()
        if line.startswith("!#if "):
            stack.append(line[5:].strip())
        elif line.startswith("!#else"):
            if stack:
                c = stack[-1]
                if re.fullmatch(r"!\w+", c):
                    stack[-1] = c[1:]
                elif re.fullmatch(r"\w+", c):
                    stack[-1] = "!" + c
                else:
                    stack[-1] = "!(%s)" % c
        elif line.startswith("!#endif"):
            if stack:
                stack.pop()
        elif not line or line.startswith(("!", "[")):
            continue
        elif is_youtube_rule(line):
            out.append((tuple(stack), line))
    return out


def render(rules):
    """Write rules, grouping consecutive ones that share the same conditions."""
    lines, current = [], ()
    for cond, rule in rules:
        if cond != current:
            lines += ["!#endif"] * len(current)
            lines += ["!#if %s" % c for c in cond]
            current = cond
        lines.append(rule)
    lines += ["!#endif"] * len(current)
    return lines


def main():
    built = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%d %H:%M UTC")
    names = {"ublock": ("uBlock Origin / Brave", "uBlock Origin's uAssets filters (GPL-3.0)"),
             "adguard": ("AdGuard", "AdGuard Base, Mobile Ads and Tracking Protection filters (GPL-3.0)")}
    failed = False
    (ROOT / "browser").mkdir(exist_ok=True)
    for flavour, urls in SOURCES.items():
        rules, seen = [], set()
        try:
            for url in urls:
                for cond, rule in extract(fetch(url)):
                    if (cond, rule) not in seen:
                        seen.add((cond, rule))
                        rules.append((cond, rule))
        except Exception as e:  # noqa: BLE001
            print("  FAIL browser/%s: %s" % (flavour, e))
            failed = True
            continue
        out = ROOT / "browser" / ("youtube-ads-%s.txt" % flavour)
        previous = existing_count(out)
        if not rules or (previous and len(rules) < previous * (1 - MAX_SHRINK)):
            print("  WARNING browser/%s: skipped, shrank from %d to %d rules" % (flavour, previous, len(rules)))
            failed = True
            continue
        label, credit = names[flavour]
        head = [
            "! Title: YouTube Ads (%s)" % label,
            "! Description: Removes YouTube video ads, Shorts ads and ad slots in the browser. Rules taken daily from %s." % credit,
            "! Homepage: %s" % REPO_URL,
            "! License: GPL-3.0 (same as the source lists)",
            "! Expires: 1 day",
            "! Last modified: %s" % built,
            "! Entries: %d" % len(rules),
            "",
        ]
        write_if_changed(out, "\n".join(head + render(rules)) + "\n")
        print("  wrote browser/%-24s %6d rules" % (out.name, len(rules)))
    if failed:
        sys.exit(1)


if __name__ == "__main__":
    main()
