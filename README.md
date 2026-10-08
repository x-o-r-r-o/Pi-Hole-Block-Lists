# Pi-Hole-Block-Lists

Ready-to-use DNS block lists for **Pi-hole** and **AdGuard Home**, rebuilt **every day**
from well-maintained upstream sources, merged and de-duplicated.

## Lists

| List | What it blocks | Size |
|---|---|---|
| `ads-and-tracking` | Ads and trackers, few false positives. **Start here.** | ~120k |
| `ads-and-tracking-extended` | Aggressive ads, trackers, telemetry, pop-ups. May need some allowlisting. | ~600k |
| `mobile-ads` | Ad networks inside Android/iOS apps | ~7k |
| `mobile-spyware` | Phone-maker and app telemetry (Apple, Samsung, Xiaomi, Huawei, Oppo/Realme, Vivo, TikTok), Android trackers | ~3k |
| `youtube-ads` | Google/YouTube ad servers. Partial, see note below. | ~20 |
| `gambling` | Online casinos, sports betting, poker, lotteries | ~580k |
| `adult` | Porn and other adult (NSFW) sites. See tip below. | ~550k |
| `social-media` | Facebook, Instagram, TikTok, X/Twitter, Snapchat, Reddit, LinkedIn, Pinterest, Threads, Bluesky, Discord and more. WhatsApp stays allowed. | ~4k |
| `smart-tv` | Smart TV / streaming stick tracking (Samsung, LG, Roku, Amazon Fire) | ~1k |
| `security` | Malware, phishing, scams, fake shops | ~640k |

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
4. Writes the three formats and commits only if something changed.

Safety checks: if a source fails to download, or a list would shrink by more than half, that list keeps its previous
version and the run is marked as failed so you notice.

Run it locally:

```
python3 scripts/build.py
```

## Sources

The previous upstream, Developer Dan's (lightswitch05) lists, was archived in 2024 and is no longer used.

| Source | Used in | License |
|---|---|---|
| [HaGeZi DNS Blocklists](https://github.com/hagezi/dns-blocklists): Light, Pro++, Pop-Up Ads, TIF Medium, Fake, Gambling, NSFW, Social, Native Trackers | most lists | GPL-3.0 |
| [OISD Big / NSFW](https://oisd.nl) | extended, adult | GPL-3.0 |
| [StevenBlack Unified Hosts](https://github.com/StevenBlack/hosts) + Gambling, Porn and Social extensions | ads-and-tracking, extended, gambling, adult, social-media | MIT |
| [1Hosts Lite](https://github.com/badmojr/1Hosts) | extended | MPL-2.0 |
| [EasyList / EasyPrivacy](https://easylist.to) (via [Firebog](https://firebog.net)) | extended | GPL-3.0 / CC BY-SA 3.0 |
| [Frogeye First-Party Trackers](https://hostfiles.frogeye.fr) | extended | MIT |
| [AdAway](https://adaway.org) | ads-and-tracking, extended, mobile-ads | CC BY 3.0 |
| [Peter Lowe's list](https://pgl.yoyo.org/adservers/) | ads-and-tracking, extended | see site |
| [AdGuard Filters](https://github.com/AdguardTeam/AdguardFilters): Mobile Ads, Tracking Protection (mobile) | mobile-ads, mobile-spyware | GPL-3.0 |
| [Perflyst PiHoleBlocklist](https://github.com/Perflyst/PiHoleBlocklist): Android Tracking, Smart TV | mobile-spyware, smart-tv | MIT |
| [kboghdady YouTube ads](https://github.com/kboghdady/youTube_ads_4_pi-hole) (ad servers only, video servers removed) | youtube-ads | see repo |
| [abuse.ch URLhaus](https://urlhaus.abuse.ch) | security | CC0 |
| [Phishing Army Extended](https://phishing.army) | security | CC BY-NC 4.0 |

All credit goes to these maintainers. Each generated file lists its sources in its header.
To add or remove a source, edit `sources.json` and `lists.json`.
