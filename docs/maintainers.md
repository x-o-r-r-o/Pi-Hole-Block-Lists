# For maintainers

[← README](../README.md) · [Lists explained](lists.md) · [Devices](devices.md) · [Routers](routers.md) · [Servers & NAS](servers.md) · [TVs & consoles](tv-and-consoles.md) · [Troubleshooting](troubleshooting.md)

## Contents

<!-- TOC:START -->
- [Sources](#sources)
- [For maintainers](#for-maintainers)
  - [Adding your own domains](#adding-your-own-domains)
  - [How it updates](#how-it-updates)
  - [Adding a new list or source](#adding-a-new-list-or-source)
<!-- TOC:END -->

## Sources

The previous upstream, Developer Dan's (lightswitch05) lists, was archived in 2024 and is no longer used.

Many sources come from the same catalogue AdGuard Home offers by default ([HostlistsRegistry](https://github.com/AdguardTeam/HostlistsRegistry)):
its filter lists, the rules behind its **Blocked services** switches, and the DNS-compatible ad/tracking-server sections of
[AdguardFilters](https://github.com/AdguardTeam/AdguardFilters) (including regional ones).

<!-- SOURCES:START -->
| Source | Used in | License |
|---|---|---|
| [HaGeZi Multi Light](https://github.com/hagezi/dns-blocklists) | `ads-and-tracking`, `ads-and-tracking-extended` | GPL-3.0 |
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
| [Peter Lowe's Ad and Tracking Server List (t.co removed: it breaks every link on X/Twitter)](https://pgl.yoyo.org/adservers/) | `ads-and-tracking`, `ads-and-tracking-extended` | Free for non-commercial use (see home page) |
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
| [Phishing.Database (active domains; big-company domains and major link shorteners removed)](https://github.com/mitchellkrogza/Phishing.Database) | `phishing-and-scams` | MIT |
| [malware-filter Phishing URL Blocklist (PhishTank, OpenPhish, PhishStats)](https://gitlab.com/malware-filter/phishing-filter) | `phishing-and-scams` | MIT / CC0 |
| [Scam Blocklist (durablenapkin)](https://github.com/durablenapkin/scamblocklist) | `phishing-and-scams` | MIT |
| [Live-streaming & video-chat app servers (researched app domains + Certificate Transparency discovery)](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/blob/master/apps/live-streaming.json) | `live-streaming` | this repository |
| [Université Toulouse Capitole: dating](https://dsi.ut-capitole.fr/blacklists/) | `dating` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: drugs](https://dsi.ut-capitole.fr/blacklists/) | `drugs` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: games (big-company domains removed)](https://dsi.ut-capitole.fr/blacklists/) | `online-games` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: violence & hate](https://dsi.ut-capitole.fr/blacklists/) | `violence-hate` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: piracy (warez)](https://dsi.ut-capitole.fr/blacklists/) | `piracy` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: VPN](https://dsi.ut-capitole.fr/blacklists/) | `vpn-proxy-bypass` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: DNS-over-HTTPS](https://dsi.ut-capitole.fr/blacklists/) | `vpn-proxy-bypass` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: AI tools](https://dsi.ut-capitole.fr/blacklists/) | `ai-chatbots` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: stalkerware & monitoring apps](https://dsi.ut-capitole.fr/blacklists/) | `stalkerware` | CC BY-SA 4.0 |
| [HaGeZi DoH/VPN/Proxy Bypass](https://github.com/hagezi/dns-blocklists) | `vpn-proxy-bypass` | GPL-3.0 |
| [HaGeZi Anti-Piracy](https://github.com/hagezi/dns-blocklists) | `piracy` | GPL-3.0 |
| [HaGeZi No SafeSearch](https://github.com/hagezi/dns-blocklists) | `safesearch-bypass` | GPL-3.0 |
| [Dating app servers (researched app domains + Certificate Transparency discovery)](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/blob/master/apps/dating.json) | `dating` | this repository |
| [Université Toulouse Capitole: cheating](https://dsi.ut-capitole.fr/blacklists/) | `cheating` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: remote control](https://dsi.ut-capitole.fr/blacklists/) | `remote-control` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: cryptocurrency](https://dsi.ut-capitole.fr/blacklists/) | `crypto-trading` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: residential proxies](https://dsi.ut-capitole.fr/blacklists/) | `security-strict` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: file hosting](https://dsi.ut-capitole.fr/blacklists/) | `file-sharing` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: shopping](https://dsi.ut-capitole.fr/blacklists/) | `shopping` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: fake news](https://dsi.ut-capitole.fr/blacklists/) | `fake-news` | CC BY-SA 4.0 |
| [Université Toulouse Capitole: cults & sects](https://dsi.ut-capitole.fr/blacklists/) | `cults` | CC BY-SA 4.0 |
| [HaGeZi Spam TLDs](https://github.com/hagezi/dns-blocklists) | `security-strict` | GPL-3.0 |
| [HaGeZi Spam TLDs allowlist (legitimate sites on those TLDs)](https://github.com/hagezi/dns-blocklists) | `security-strict` | GPL-3.0 |
| [HaGeZi Dynamic DNS](https://github.com/hagezi/dns-blocklists) | `security-strict` | GPL-3.0 |
| [HaGeZi Badware Hoster](https://github.com/hagezi/dns-blocklists) | `security-strict` | GPL-3.0 |
| [HaGeZi Native Tracker: Windows/Office](https://github.com/hagezi/dns-blocklists) | `windows-telemetry` | GPL-3.0 |
| [HaGeZi URL Shortener](https://github.com/hagezi/dns-blocklists) | `url-shorteners` | GPL-3.0 |
| [Gaming platform servers (researched app domains + Certificate Transparency discovery)](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/blob/master/apps/gaming-platforms.json) | `gaming-platforms` | this repository |
| [Video streaming servers (researched app domains + Certificate Transparency discovery)](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/blob/master/apps/video-streaming.json) | `video-streaming` | this repository |
| [Messaging app servers (researched app domains + Certificate Transparency discovery)](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/blob/master/apps/messaging.json) | `messaging` | this repository |
| [AdGuard DNS filter (AdGuard Home default)](https://github.com/AdguardTeam/AdGuardSDNSFilter) | `ads-and-tracking`, `ads-and-tracking-extended` | GPL-3.0 |
| [AdGuard DNS Popup Hosts filter](https://github.com/AdguardTeam/AdGuardSDNSFilter) | `ads-and-tracking-extended` | GPL-3.0 |
| [Dan Pollock's List](https://someonewhocares.org/hosts/) | `ads-and-tracking-extended` | non-commercial (see home page) |
| [ShadowWhisperer Tracking List](https://github.com/ShadowWhisperer/BlockLists) | `ads-and-tracking-extended` | MIT |
| [AWAvenue Ads Rule (mobile app ads)](https://github.com/TG-Twilight/AWAvenue-Ads-Rule) | `mobile-ads` | GPL-3.0 |
| [Dandelion Sprout's Anti Push Notifications](https://github.com/DandelionSprout/adfilt) | `ads-and-tracking-extended` | Dandelicence (see repo) |
| [Perflyst and Dandelion Sprout's Smart-TV Blocklist](https://github.com/Perflyst/PiHoleBlocklist) | `smart-tv` | MIT |
| [Dandelion Sprout's Game Console Adblock List](https://github.com/DandelionSprout/adfilt) | `smart-tv`, `game-consoles` | Dandelicence (see repo) |
| [ShadowWhisperer's Dating List](https://github.com/ShadowWhisperer/BlockLists) | `dating` | MIT |
| [The Big List of Hacked Malware Web Sites](https://github.com/mitchellkrogza/The-Big-List-of-Hacked-Malware-Web-Sites) | `security` | MIT |
| [ShadowWhisperer's Malware List](https://github.com/ShadowWhisperer/BlockLists) | `security` | MIT |
| [uBlock Origin filters: Badware risks](https://github.com/uBlockOrigin/uAssets) | `security` | GPL-3.0 |
| [CERT Polska list of malicious domains](https://cert.pl/en/warning-list/) | `security`, `phishing-and-scams` | see home page |
| [Ukrainian Security Filter](https://github.com/braveinnovators/ukrainian-security-filter) | `security` | MIT |
| [Phishing URL Blocklist (PhishTank and OpenPhish)](https://gitlab.com/malware-filter/phishing-filter) | `security`, `phishing-and-scams` | MIT / CC0 |
| [Stalkerware Indicators List](https://github.com/AssoEchap/stalkerware-indicators) | `stalkerware` | CC BY 4.0 |
| [AdGuard DNS filter: Google/YouTube ad-serving rules only](https://github.com/AdguardTeam/AdGuardSDNSFilter) | `youtube-ads` | GPL-3.0 |
| [AdGuard Home Blocked Services: youtube](https://github.com/AdguardTeam/HostlistsRegistry) | `youtube` | GPL-3.0 |
| [AdGuard Home Blocked Services: social networks (WhatsApp media hosts kept working)](https://github.com/AdguardTeam/HostlistsRegistry) | `social-media` | GPL-3.0 |
| [AdGuard Home Blocked Services: whatsapp, telegram, discord, signal, viber, line, wechat, kik, kakaotalk, qq, olvid](https://github.com/AdguardTeam/HostlistsRegistry) | `messaging` | GPL-3.0 |
| [AdGuard Home Blocked Services: netflix, disneyplus, hulu, hbomax, max, paramountplus, peacock_tv, amazon_streaming, apple_streaming, crunchyroll, iqiyi, pluto_tv, twitch, rakuten_viki, discoveryplus, plex, dailymotion, vimeo, nebula, odysee, bilibili, lionsgateplus, globoplay, canais_globo, directvgo, looke, voot, samsung_tv_plus, spotify_video, vivo_play](https://github.com/AdguardTeam/HostlistsRegistry) | `video-streaming` | GPL-3.0 |
| [AdGuard Home Blocked Services: roblox, epic_games, steam, playstation, xboxlive, nintendo, minecraft, leagueoflegends, riot_games, valorant, battle_net, blizzard_entertainment, activision_blizzard, electronic_arts, origin, ubisoft, rockstar_games, gog, wargaming, warnerbrosgames, io_interactive, shell_shockers](https://github.com/AdguardTeam/HostlistsRegistry) | `gaming-platforms` | GPL-3.0 |
| [AdGuard Home Blocked Services: chatgpt, claude, copilot, gemini, deepseek, grok, perplexity, meta_ai, qwen, manus, questionai, dola](https://github.com/AdguardTeam/HostlistsRegistry) | `ai-chatbots` | GPL-3.0 |
| [AdGuard Home Blocked Services: aliexpress, ebay, shein, temu, shopee, lazada, mercado_libre](https://github.com/AdguardTeam/HostlistsRegistry) | `shopping` | GPL-3.0 |
| [AdGuard Home Blocked Services: betano, betfair, betway, fdj_united, blaze](https://github.com/AdguardTeam/HostlistsRegistry) | `gambling` | GPL-3.0 |
| [AdGuard Home Blocked Services: onlyfans](https://github.com/AdguardTeam/HostlistsRegistry) | `adult` | GPL-3.0 |
| [AdGuard Home Blocked Services: tinder, grindr, plenty_of_fish](https://github.com/AdguardTeam/HostlistsRegistry) | `dating` | GPL-3.0 |
| [AdGuard Home Blocked Services: bigo_live, yy](https://github.com/AdguardTeam/HostlistsRegistry) | `live-streaming` | GPL-3.0 |
| [AdGuard Home Blocked Services: dropbox, box](https://github.com/AdguardTeam/HostlistsRegistry) | `file-sharing` | GPL-3.0 |
| [AdGuard Base filter: ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-and-tracking`, `ads-and-tracking-extended` | GPL-3.0 |
| [AdGuard Tracking Protection: tracking servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-and-tracking`, `ads-and-tracking-extended` | GPL-3.0 |
| [AdGuard Mobile Ads filter: ad servers](https://github.com/AdguardTeam/AdguardFilters) | `mobile-ads` | GPL-3.0 |
| [AdGuard Tracking Protection: mobile allowlist](https://github.com/AdguardTeam/AdguardFilters) | `mobile-spyware` | GPL-3.0 |
| [AdGuard Chinese filter: ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-and-tracking-extended`, `ads-regional` | GPL-3.0 |
| [AdGuard Cyrillic (Russian/Ukrainian) filter: ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-and-tracking-extended`, `ads-regional` | GPL-3.0 |
| [AdGuard Japanese filter: ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-and-tracking-extended`, `ads-regional` | GPL-3.0 |
| [AdGuard Spanish/Portuguese filter: ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-and-tracking-extended`, `ads-regional` | GPL-3.0 |
| [AdGuard Turkish filter: ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-and-tracking-extended`, `ads-regional` | GPL-3.0 |
| [AdGuard German filter: ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-and-tracking-extended`, `ads-regional` | GPL-3.0 |
| [AdGuard Dutch filter: ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-and-tracking-extended`, `ads-regional` | GPL-3.0 |
| [AdGuard French filter: ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-and-tracking-extended`, `ads-regional` | GPL-3.0 |
| [AdGuard Chinese filter: first-party ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-regional` | GPL-3.0 |
| [AdGuard Russian filter: first-party ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-regional` | GPL-3.0 |
| [AdGuard Ukrainian filter: first-party ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-regional` | GPL-3.0 |
| [AdGuard Cyrillic filter: first-party ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-regional` | GPL-3.0 |
| [AdGuard Dutch filter: first-party ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-regional` | GPL-3.0 |
| [AdGuard French filter: first-party ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-regional` | GPL-3.0 |
| [AdGuard Italian filter: first-party ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-regional` | GPL-3.0 |
| [AdGuard Japanese filter: first-party ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-regional` | GPL-3.0 |
| [AdGuard Spanish filter: first-party ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-regional` | GPL-3.0 |
| [AdGuard Turkish filter: first-party ad servers](https://github.com/AdguardTeam/AdguardFilters) | `ads-regional` | GPL-3.0 |
| [Dandelion Sprout's Nordic filters (NOR)](https://github.com/DandelionSprout/adfilt) | `ads-regional` | Dandelicence (see repo) |
| [Polish filters for Pi-hole (POL)](https://github.com/MajkiIT/polish-ads-filter) | `ads-regional` | CC BY-NC-SA 4.0 |
| [YousList (KOR)](https://github.com/yous/YousList) | `ads-regional` | GPL-3.0 |
| [ABPVN List (VNM)](https://abpvn.com) | `ads-regional` | GPL-3.0 |
| [Frellwit's Swedish Hosts File (SWE)](https://github.com/lassekongo83/Frellwits-filter-lists) | `ads-regional` | GPL-3.0 |
| [PersianBlocker (IRN)](https://github.com/MasterKia/PersianBlocker) | `ads-regional` | AGPL-3.0 |
| [Macedonian Pi-hole Blocklist (MKD)](https://github.com/cchevy/macedonian-pi-hole-blocklist) | `ads-regional` | see repo |
| [anti-AD (CHN)](https://github.com/privacy-protection-tools/anti-AD) | `ads-regional` | MIT |
| [ABPindo (IDN)](https://github.com/ABPindo/indonesianadblockrules) | `ads-regional` | GPL-3.0 |
| [filterslists-KO (KOR)](https://github.com/List-KR/List-KR) | `ads-regional` | MPL-2.0 |
| [turk-adlist (TUR)](https://github.com/bkrucarci/turk-adlist) | `ads-regional` | see repo |
| [AdRules DNS List (CHN)](https://github.com/Cats-Team/AdRules) | `ads-regional` | GPL-3.0 |
| [Hufilter (HUN)](https://github.com/hufilter/hufilter) | `ads-regional` | see repo |
| [EasyList Lithuania (LIT)](https://github.com/EasyList-Lithuania/easylist_lithuania) | `ads-regional` | GPL-3.0 |
| [Turkish Ad Hosts (TUR)](https://github.com/symbuzzer/Turkish-Ad-Hosts) | `ads-regional` | see repo |
| [EasyList Hebrew (ISR)](https://github.com/easylist/EasyListHebrew) | `ads-regional` | GPL-3.0 |
| [Liste AR (Arabic)](https://code.google.com/p/liste-ar-adblock/) | `ads-regional` | GPL-3.0 |
| [EasyList China](https://github.com/easylist/easylistchina) | `ads-regional` | GPL-3.0 / CC BY-SA 3.0 |
<!-- SOURCES:END -->

All credit goes to these maintainers. Each generated file lists its sources in its header.

<div align="right"><a href="#contents">↑ Back to top</a></div>

## For maintainers

This part is for people running their own copy (fork) of this repository; you don't need it to use the lists. To contribute changes back, see [CONTRIBUTING.md](../CONTRIBUTING.md).

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Adding your own domains

Put extra domains in `custom/<list>.txt` (in your own copy / fork of this repository), one per line. They are always included in that list.
`custom/mobile-ads.txt` and `custom/mobile-spyware.txt` hold the original 2019 lists.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### How it updates

A GitHub Action ([`.github/workflows/update.yml`](../.github/workflows/update.yml)) runs daily, plus whenever
the config changes, and runs [`scripts/build.py`](../scripts/build.py) (Python standard library only):

1. Downloads every source in [`sources.json`](../sources.json). Hosts, plain-domain and adblock formats are all understood.
2. Merges the sources for each list as defined in [`lists.json`](../lists.json), honouring upstream `@@` exceptions.
3. Adds `custom/` domains and removes `allowlist.txt` domains.
4. Writes the three formats, refreshes the tables in this README, and commits only if something changed.

Safety checks: if a source fails to download, or a list would shrink by more than half, that list keeps its previous
version and the run is marked as failed so you notice.

Run it locally:

```
python3 scripts/build.py
```

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Adding a new list or source

1. Add the source to [`sources.json`](../sources.json) (`name`, `url` or a repo `path`, `home`, `license`, and optionally `exclude` regexes).
2. Add or edit the list in [`lists.json`](../lists.json) (`title`, `description`, `sources`).
3. Push. The Action builds the new list in all three formats and adds it to the tables above automatically.

<div align="right"><a href="#contents">↑ Back to top</a></div>
