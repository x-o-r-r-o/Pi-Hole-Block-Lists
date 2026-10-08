# Pi-Hole-Block-Lists

[![Update block lists](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/actions/workflows/update.yml/badge.svg)](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/actions/workflows/update.yml)

Ready-to-use DNS block lists for **Pi-hole** and **AdGuard Home**, rebuilt **every day**
from well-maintained upstream sources, merged and de-duplicated.

## Lists

The table below and the Sources table are updated automatically on every build.

<!-- LISTS:START -->
| List | What it blocks | Domains | Download |
|---|---|---|---|
| `ads-and-tracking` | Ads and trackers with few false positives. Start here. | ~122k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-and-tracking.txt) |
| `ads-and-tracking-extended` | Aggressive ad, tracker, telemetry and pop-up blocking. Blocks more, may need occasional allowlisting. | ~595k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking-extended.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking-extended.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-and-tracking-extended.txt) |
| `mobile-ads` | Ad networks used inside Android and iOS apps. | ~7.6k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/mobile-ads.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/mobile-ads.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/mobile-ads.txt) |
| `mobile-spyware` | Phone-maker and app telemetry/tracking (Apple, Samsung, Xiaomi, Huawei, Oppo/Realme, Vivo, TikTok) plus Android trackers. | ~3.2k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/mobile-spyware.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/mobile-spyware.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/mobile-spyware.txt) |
| `youtube-ads` | Google/YouTube ad servers. Partial: DNS cannot block all YouTube video ads (see note below). | 16 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/youtube-ads.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/youtube-ads.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/youtube-ads.txt) |
| `gambling` | Online casinos, sports betting, poker, lotteries and other gambling sites. | ~585k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/gambling.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/gambling.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/gambling.txt) |
| `adult` | Porn and other adult (NSFW) sites (see Safe Search tip below). | ~544k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/adult.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adult.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/adult.txt) |
| `social-media` | Social networks: Facebook, Instagram, TikTok, X/Twitter, Snapchat, Reddit, LinkedIn, Pinterest, Tumblr, Threads, Bluesky, Discord and more. WhatsApp is not blocked. | ~4.4k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/social-media.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/social-media.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/social-media.txt) |
| `smart-tv` | Tracking and ads on smart TVs and streaming sticks (Samsung, LG webOS, Roku, Amazon Fire). | ~1.3k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/smart-tv.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/smart-tv.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/smart-tv.txt) |
| `security` | Malware, phishing, scams and fake shops from threat-intelligence feeds. Recommended for everyone. | ~682k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/security.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/security.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/security.txt) |
| `crypto-mining` | Hidden crypto-mining scripts and mining pools (cryptojacking). Exchanges like Coinbase/Binance are not blocked. | ~12k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/crypto-mining.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/crypto-mining.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/crypto-mining.txt) |
| `phishing-and-scams` | Phishing sites (fake bank, PayPal, Microsoft and delivery logins), scams and fake shops. Already included in `security`; use this if you only want phishing/scam protection. | ~562k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/phishing-and-scams.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/phishing-and-scams.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/phishing-and-scams.txt) |
| `live-streaming` | Bigo Live, Likee, MICO, SUGO, Poppo, Chamet, Tango, StreamKar, LiveMe, 17LIVE, Uplive, Hago, Yalla, SoulChill, Azar, HOLLA, Mango, GOGO LIVE, SuperLive, Kumu, Ahlan, Ola Party, Hiya, Nimo TV and ~30 more paid live/video-chat apps (see note below). | ~2.3k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/live-streaming.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/live-streaming.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/live-streaming.txt) |
<!-- LISTS:END -->

> **About `live-streaming`:** covers Bigo Live, Likee, MICO, SUGO, Poppo, Chamet and ~45 similar paid live-stream,
> video-chat and voice-party apps. App domains were researched from each app's Google Play listing, and their server names
> are re-discovered every week from public certificate logs ([`apps/live-streaming.json`](apps/live-streaming.json)).
> Some apps can also connect by IP address, which a DNS blocker can't see. For the strongest block:
>
> | Setup | Add these |
> |---|---|
> | **AdGuard Home** | `adblock/live-streaming.txt` **and** `ips/live-streaming-adguard.txt` (blocks any server name that points into Bigo's own network, even new ones) |
> | **Pi-hole v6** | `adblock/live-streaming.txt` |
> | **Pi-hole v5** | `live-streaming.txt` (plain) |
> | **Router / firewall** (optional, extra) | `ips/live-streaming.txt` or `-ipv4.txt` / `-ipv6.txt` as an IP block list (pfSense, OPNsense, OpenWrt, MikroTik) |
>
> Only Bigo runs its own network. The other apps use shared clouds (Alibaba, Amazon, Cloudflare...), so their IPs are not
> listed: blocking them would break normal websites. Pi-hole can't block by IP, which is why the router option exists.
> Also block the app installs with your phone's parental controls (Google Family Link / Apple Screen Time).
> To add an app, put its domains in `apps/live-streaming.json` and push.

> **Tip for `adult`:** a block list can't stop explicit images from appearing in Google/Bing image search.
> In AdGuard Home, also turn on **Settings → General settings → Enforce Safe Search** (and Safe Browsing).

> **About YouTube ads:** YouTube serves most video ads from the same servers as the videos (`googlevideo.com`),
> so no DNS blocker (Pi-hole or AdGuard Home) can remove them all. Lists that block `googlevideo.com` servers end up
> breaking or freezing playback, so `youtube-ads` leaves those out and blocks only the separate ad servers. That stops some
> ads, mostly in apps, on smart TVs and on other websites. To remove every YouTube ad, use a browser ad blocker
> such as uBlock Origin, or YouTube Premium.

Each list comes in three formats. Pick the one that fits your setup:

| Format | Folder | Use with |
|---|---|---|
| Adblock (`\|\|domain^`) | `adblock/` | **AdGuard Home** and **Pi-hole v6** (recommended, also blocks subdomains) |
| Plain domains | repo root | Pi-hole v5, AdGuard Home, most other tools |
| Hosts (`0.0.0.0 domain`) | `hosts/` | hosts files, older tools |
| IP ranges | `ips/` | Only for `live-streaming`: `-adguard.txt` for AdGuard Home, CIDR files for routers/firewalls |

URL pattern (replace `<list>` with a name from the table):

```
Adblock: https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/<list>.txt
Plain:   https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/<list>.txt
Hosts:   https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/<list>.txt
```

The original root URLs (`ads-and-tracking.txt`, `ads-and-tracking-extended.txt`, `mobile-ads.txt`,
`mobile-spyware.txt`) still work, so existing setups keep updating with no changes.

## How to add a list

**AdGuard Home:** Filters → DNS blocklists → Add blocklist → Add a custom list → paste an `adblock/` URL → Save.

**Pi-hole v6:** Lists → paste an `adblock/` URL into "Domain or URL" → Add blocklist.
Then run `pihole -g` (or Tools → Update Gravity).

**Pi-hole v5:** Group Management → Adlists → paste a plain (root) URL → Add. Then run `pihole -g`.

Don't combine `ads-and-tracking` and `ads-and-tracking-extended`. The extended list already contains everything in the smaller one.

## Something broke?

Add the domain to [`allowlist.txt`](allowlist.txt). It will be removed from every list on the next build.
You can also allow it right away in Pi-hole/AdGuard Home.

## Adding your own domains

Put extra domains in `custom/<list>.txt`, one per line. They are always included in that list.
`custom/mobile-ads.txt` and `custom/mobile-spyware.txt` hold the original 2019 lists.

## How it updates

A GitHub Action ([`.github/workflows/update.yml`](.github/workflows/update.yml)) runs daily, plus whenever
the config changes, and runs [`scripts/build.py`](scripts/build.py) (Python standard library only):

1. Downloads every source in [`sources.json`](sources.json). Hosts, plain-domain and adblock formats are all understood.
2. Merges the sources for each list as defined in [`lists.json`](lists.json), honouring upstream `@@` exceptions.
3. Adds `custom/` domains and removes `allowlist.txt` domains.
4. Writes the three formats, refreshes the tables in this README, and commits only if something changed.

Safety checks: if a source fails to download, or a list would shrink by more than half, that list keeps its previous
version and the run is marked as failed so you notice.

Run it locally:

```
python3 scripts/build.py
```

## Sources

The previous upstream, Developer Dan's (lightswitch05) lists, was archived in 2024 and is no longer used.

<!-- SOURCES:START -->
| Source | Used in | License |
|---|---|---|
| [HaGeZi Multi Light](https://github.com/hagezi/dns-blocklists) | `ads-and-tracking` | GPL-3.0 |
| [HaGeZi Multi Pro++](https://github.com/hagezi/dns-blocklists) | `ads-and-tracking-extended` | GPL-3.0 |
| [HaGeZi Pop-Up Ads](https://github.com/hagezi/dns-blocklists) | `ads-and-tracking-extended` | GPL-3.0 |
| [HaGeZi Threat Intelligence Feeds (Medium)](https://github.com/hagezi/dns-blocklists) | `security` | GPL-3.0 |
| [HaGeZi Fake (scams, fake shops)](https://github.com/hagezi/dns-blocklists) | `security`, `phishing-and-scams` | GPL-3.0 |
| [HaGeZi Native Tracker: Apple](https://github.com/hagezi/dns-blocklists) | `mobile-spyware` | GPL-3.0 |
| [HaGeZi Native Tracker: Samsung](https://github.com/hagezi/dns-blocklists) | `mobile-spyware`, `smart-tv` | GPL-3.0 |
| [HaGeZi Native Tracker: Xiaomi](https://github.com/hagezi/dns-blocklists) | `mobile-spyware` | GPL-3.0 |
| [HaGeZi Native Tracker: Huawei](https://github.com/hagezi/dns-blocklists) | `mobile-spyware` | GPL-3.0 |
| [HaGeZi Native Tracker: Oppo/Realme](https://github.com/hagezi/dns-blocklists) | `mobile-spyware` | GPL-3.0 |
| [HaGeZi Native Tracker: Vivo](https://github.com/hagezi/dns-blocklists) | `mobile-spyware` | GPL-3.0 |
| [HaGeZi Native Tracker: TikTok](https://github.com/hagezi/dns-blocklists) | `mobile-spyware` | GPL-3.0 |
| [HaGeZi Native Tracker: LG webOS](https://github.com/hagezi/dns-blocklists) | `smart-tv` | GPL-3.0 |
| [HaGeZi Native Tracker: Roku](https://github.com/hagezi/dns-blocklists) | `smart-tv` | GPL-3.0 |
| [HaGeZi Native Tracker: Amazon](https://github.com/hagezi/dns-blocklists) | `smart-tv` | GPL-3.0 |
| [OISD Big](https://oisd.nl) | `ads-and-tracking-extended` | GPL-3.0 |
| [StevenBlack Unified Hosts](https://github.com/StevenBlack/hosts) | `ads-and-tracking`, `ads-and-tracking-extended` | MIT |
| [1Hosts Lite](https://github.com/badmojr/1Hosts) | `ads-and-tracking-extended` | MPL-2.0 |
| [EasyList (Firebog domain conversion)](https://easylist.to) | `ads-and-tracking-extended` | GPL-3.0 / CC BY-SA 3.0 |
| [EasyPrivacy (Firebog domain conversion)](https://easylist.to) | `ads-and-tracking-extended` | GPL-3.0 / CC BY-SA 3.0 |
| [Frogeye First-Party Trackers](https://hostfiles.frogeye.fr) | `ads-and-tracking-extended` | MIT |
| [AdAway Default](https://adaway.org) | `ads-and-tracking`, `ads-and-tracking-extended`, `mobile-ads` | CC BY 3.0 |
| [Peter Lowe's Ad and Tracking Server List](https://pgl.yoyo.org/adservers/) | `ads-and-tracking`, `ads-and-tracking-extended` | Free for non-commercial use (see home page) |
| [AdGuard Mobile Ads filter (domain rules only)](https://github.com/AdguardTeam/AdguardFilters) | `mobile-ads` | GPL-3.0 |
| [AdGuard Tracking Protection: mobile section (domain rules only)](https://github.com/AdguardTeam/AdguardFilters) | `mobile-spyware` | GPL-3.0 |
| [Perflyst Android Tracking](https://github.com/Perflyst/PiHoleBlocklist) | `mobile-spyware` | MIT |
| [Perflyst Smart TV](https://github.com/Perflyst/PiHoleBlocklist) | `smart-tv` | MIT |
| [HaGeZi Gambling](https://github.com/hagezi/dns-blocklists) | `gambling` | GPL-3.0 |
| [StevenBlack Gambling extension](https://github.com/StevenBlack/hosts) | `gambling` | MIT |
| [HaGeZi NSFW](https://github.com/hagezi/dns-blocklists) | `adult` | GPL-3.0 |
| [OISD NSFW](https://oisd.nl) | `adult` | GPL-3.0 |
| [StevenBlack Porn extension](https://github.com/StevenBlack/hosts) | `adult` | MIT |
| [HaGeZi Social Networks (WhatsApp kept working)](https://github.com/hagezi/dns-blocklists) | `social-media` | GPL-3.0 |
| [StevenBlack Social extension (WhatsApp kept working)](https://github.com/StevenBlack/hosts) | `social-media` | MIT |
| [kboghdady YouTube ads for Pi-hole (ad servers only)](https://github.com/kboghdady/youTube_ads_4_pi-hole) | `youtube-ads` | see repository |
| [abuse.ch ThreatFox (malware hosts)](https://threatfox.abuse.ch) | `security` | CC0 |
| [Dandelion Sprout's Anti-Malware List](https://github.com/DandelionSprout/adfilt) | `security` | Dandelicence (see repo) |
| [NoCoin (hoshsadiq)](https://github.com/hoshsadiq/adblock-nocoin-list) | `crypto-mining` | MIT |
| [Université Toulouse Capitole cryptojacking (via Firebog)](https://dsi.ut-capitole.fr/blacklists/) | `crypto-mining` | CC BY-SA 4.0 |
| [abuse.ch URLhaus (malware hosts)](https://urlhaus.abuse.ch) | `security` | CC0 |
| [Phishing Army Extended](https://phishing.army) | `security`, `phishing-and-scams` | CC BY-NC 4.0 |
| [Phishing.Database (active domains; big-company domains removed)](https://github.com/mitchellkrogza/Phishing.Database) | `phishing-and-scams` | MIT |
| [malware-filter Phishing URL Blocklist (PhishTank, OpenPhish, PhishStats)](https://gitlab.com/malware-filter/phishing-filter) | `phishing-and-scams` | MIT / CC0 |
| [Scam Blocklist (durablenapkin)](https://github.com/durablenapkin/scamblocklist) | `phishing-and-scams` | MIT |
| [Live-streaming & video-chat app servers (researched app domains + Certificate Transparency discovery)](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/blob/master/apps/live-streaming.json) | `live-streaming` | this repository |
<!-- SOURCES:END -->

All credit goes to these maintainers. Each generated file lists its sources in its header.

## Adding a new list or source

1. Add the source to [`sources.json`](sources.json) (`name`, `url` or a repo `path`, `home`, `license`, and optionally `exclude` regexes).
2. Add or edit the list in [`lists.json`](lists.json) (`title`, `description`, `sources`).
3. Push. The Action builds the new list in all three formats and adds it to the tables above automatically.
