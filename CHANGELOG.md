# Changelog

Notable changes to the lists, tools and guides. The lists' contents also refresh every day from their sources; those
automatic updates aren't listed here. Dates are UTC.

## 2026-10-10

### Added
- **Lists:** `ads-regional` (36 regional sources: Arabic, Chinese, Cyrillic, Turkish, Persian, Hebrew, Japanese, Korean,
  Vietnamese, Indonesian, European), `game-consoles`, `gaming-platforms`, `youtube`, `video-streaming`, `messaging`,
  `chat-strangers`, `cheating`, `remote-control`, `crypto-trading`, `security-strict`, `file-sharing`,
  `windows-telemetry`, `shopping`, `fake-news`, `cults`, `url-shorteners`.
- **AdGuard sources:** AdGuard Home's default filter catalogue, its *Blocked services* rules (for `youtube`,
  `social-media`, `messaging`, `video-streaming`, `gaming-platforms`, `ai-chatbots` and others) and the DNS-compatible
  sections of AdguardFilters, including regional ones.
- **Device installers** in `install/`: `macos.sh`, `linux.sh`, `windows.ps1`, `android.sh` (Termux) and
  `edgerouter.sh`. They show a menu of all lists, back up the hosts file, update daily, and can remove everything. They're
  tested automatically on Windows, macOS and Linux.
- **Browser lists** `browser/youtube-ads-ublock.txt` and `browser/youtube-ads-adguard.txt`, built daily from uBlock
  Origin's and AdGuard's YouTube rules.
- **Router and NAS formats:** `unifi/` files for UniFi's content filter, and MikroTik (`.rsc`) and EdgeRouter versions
  of the IP list.
- **Docker files** `docker/adguardhome/compose.yaml` and `docker/pihole/compose.yaml`, tested automatically.
- **Guides:**
  - **Routers:** UniFi, pfSense, OPNsense, OpenWrt, MikroTik, EdgeRouter, GL.iNet, Asus, mesh Wi-Fi, Starlink / 4G / 5G,
    Omada and other routers.
  - **NAS and servers:** Synology, QNAP, TrueNAS, Unraid, OpenMediaVault, Proxmox VE, Raspberry Pi, Docker, Home
    Assistant, AdGuard Home on Windows / Mac, and Technitium.
  - **Devices:** iPhone / iPad, Chromebook, smart TVs, game consoles, and away from home (Tailscale, encrypted DNS).
- **README:** Quick start, Choose your setup, What each list blocks, Is it working?, Troubleshooting FAQ, and an
  automatically generated table of contents.
- **Safety guard:** `protected.txt` lists essential sites (Google, Microsoft, Apple, WhatsApp, PayPal, big CDNs...). Every
  build removes them from any list not meant to block them.

### Changed
- **IP lists:** neighbouring ranges are merged (226 → about 70 IPv4 entries; same coverage).
- **List containment is now guaranteed:** `ads-and-tracking-extended` always includes all of `ads-and-tracking`, and
  `smart-tv` all of `game-consoles`.
- **`youtube-ads`** now uses AdGuard's Google/YouTube ad rules and keeps AdGuard's exceptions, so Google's sponsored search
  links work again.

### Fixed
- **`ads-and-tracking` and `ads-and-tracking-extended` blocked `t.co`,** breaking every link on X/Twitter.
- **`phishing-and-scams` blocked `bit.ly`,** breaking bit.ly links.
- **`chat-strangers`** no longer blocks WhatsApp, Teams, Skype, imo or Discord.
- **Adblock rules written as `|domain^`, `||domain^|` or `||domain`** were skipped, losing AdGuard's exceptions and some
  rules (including Nintendo telemetry).
- **The README wrongly said `security` contains `phishing-and-scams`;** it covers only about a third of it.
- **Windows installer:** `-Update` read the saved lists as "True".
- **Docker Pi-hole:** updating reset the password; it's now kept in a `.env` file.

## 2026-10-09

### Added
- **Lists:** `youtube-ads`, `gambling`, `adult`, `social-media`, `crypto-mining`, `phishing-and-scams`, `live-streaming`
  (Bigo, Likee, MICO, Chamet and ~45 more apps) with Bigo's IP ranges, `dating`, `vpn-proxy-bypass`, `piracy`, `drugs`,
  `online-games`, `violence-hate`, `ai-chatbots`, `safesearch-bypass`, `stalkerware`.
- **More malware feeds** in `security` (abuse.ch ThreatFox, Dandelion Sprout's Anti-Malware).
- **Weekly discovery of app server names** from public certificate logs (`apps/*.json`), and README tables generated
  automatically.

### Changed
- **WhatsApp** stays working in `social-media`, including its media servers.

## 2026-10-08

### Changed
- **Lists rebuilt from maintained sources.** The old upstream, Developer Dan's (lightswitch05) lists, was archived in
  2024. The lists are now rebuilt every day from HaGeZi, OISD, StevenBlack, AdAway, AdGuard, EasyList and others.
- **Three formats per list:** adblock (AdGuard Home / Pi-hole v6), plain domains and hosts.
- **The original four list addresses keep working.**
- **New lists:** `smart-tv` and `security`.

## 2019-06-04

- **First release:** `ads-and-tracking`, `ads-and-tracking-extended`, `mobile-ads`, `mobile-spyware`.
