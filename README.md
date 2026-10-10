# Pi-Hole-Block-Lists

[![Update block lists](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/actions/workflows/update.yml/badge.svg)](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/actions/workflows/update.yml)

Ready-to-use block lists for ads, trackers, malware, phishing and unwanted content, rebuilt **every day** from
well-maintained sources. Use them in **AdGuard Home** or **Pi-hole**, on your **router**, or on a single **computer or
phone**, with step-by-step guides for each.

## Quick start

**1. You already run AdGuard Home or Pi-hole** (2 minutes). Add these two links, which block ads, trackers, malware and
phishing without breaking normal sites:
```
https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking.txt
https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/security.txt
```
- **AdGuard Home:** **Filters → DNS blocklists → Add blocklist → Add a custom list** → paste one link → **Save**; repeat for
  the second.
- **Pi-hole v6:** **Lists** → paste a link → **Add blocklist** (both links), then **Tools → Update Gravity**. (Pi-hole v5:
  use the same links without `/adblock`.)

**2. Protect one computer, no extra hardware** (2 minutes). Pick the recommended set from the menu by pressing Enter:
- **macOS / Linux** (Terminal):
  ```bash
  curl -fsSLO https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/install/macos.sh && sudo bash macos.sh
  ```
  (on Linux use `linux.sh` instead of `macos.sh`)
- **Windows** (PowerShell): see [Windows 10 / 11](docs/devices.md#windows-10--11); on Windows choose smaller lists, or run
  [AdGuard Home on the PC](docs/servers.md#adguard-home-on-a-windows-or-mac-computer) for the big ones.

**3. Protect every device at home** (about 30 minutes). Run AdGuard Home or Pi-hole on an always-on device, add the two
links from step 1, and point your router at it:
[Raspberry Pi](docs/servers.md#raspberry-pi) · [Docker](docs/servers.md#docker) · [Synology](docs/servers.md#synology-nas) · [other NAS / servers](#choose-your-setup)
· then your [router](docs/routers.md#routers).

**4. Phones:** Android without root: the free [AdAway app](docs/devices.md#android). iPhone / iPad: [use your home blocker or the
AdGuard app](docs/devices.md#iphone-and-ipad).

Then check it worked with [Is it working?](docs/troubleshooting.md#is-it-working). More lists (adult content, gambling, social media, kids'
apps...) are in [Lists](#lists) and [Suggested setups](#suggested-setups).

## Contents

<!-- TOC:START -->
- [Quick start](#quick-start)
- [Choose your setup](#choose-your-setup)
- [Guides](#guides)
- [Lists](#lists)
  - [Suggested setups](#suggested-setups)
- [How to add a list](#how-to-add-a-list)
- [Contributing and license](#contributing-and-license)
- [Changelog](#changelog)
<!-- TOC:END -->

## Choose your setup

| You have... | Go to |
|---|---|
| AdGuard Home or Pi-hole already | [Lists](#lists) and [How to add a list](#how-to-add-a-list) |
| Nothing yet, and want the whole home protected | a [Raspberry Pi](docs/servers.md#raspberry-pi), or your [NAS / server](docs/servers.md#docker), then your [router](docs/routers.md#routers) |
| A NAS or home server | [Synology](docs/servers.md#synology-nas), [QNAP](docs/servers.md#qnap-nas), [TrueNAS](docs/servers.md#truenas), [Unraid](docs/servers.md#unraid), [OpenMediaVault](docs/servers.md#openmediavault), [Proxmox VE](docs/servers.md#proxmox-ve), [Home Assistant](docs/servers.md#home-assistant), any [Docker](docs/servers.md#docker) host |
| A router that can block by itself | [pfSense](docs/routers.md#pfsense), [OPNsense](docs/routers.md#opnsense), [OpenWrt](docs/routers.md#openwrt), [MikroTik](docs/routers.md#mikrotik), [EdgeRouter](docs/routers.md#ubiquiti-edgerouter), [GL.iNet](docs/routers.md#glinet), [UniFi](docs/routers.md#unifi-cloud-gateway-ucg-ultra--max--fiber-udm-udr) |
| Another router (Asus, TP-Link, Netgear, Fritz!Box, internet provider) | [Asus](docs/routers.md#asus), [Any other router](docs/routers.md#any-other-router-tp-link-netgear-fritzbox-internet-provider-routers), [Mesh Wi-Fi](docs/routers.md#mesh-wi-fi-eero-google-nest-wifi-deco-orbi-velop), [Starlink / 4G / 5G](docs/routers.md#starlink-4g-and-5g-home-routers), [Omada](docs/routers.md#tp-link-omada-and-other-business-gateways), plus a blocker from the rows above |
| Blocking doesn't seem to work | [Is it working?](docs/troubleshooting.md#is-it-working) and [Troubleshooting FAQ](docs/troubleshooting.md#troubleshooting-faq) |
| Not sure which lists to pick | [What each list blocks](docs/lists.md#what-each-list-blocks-and-what-it-doesnt) and [Suggested setups](#suggested-setups) |
| Just one computer or phone | [macOS, Windows, Linux, Android, iPhone, Chromebook](docs/devices.md#use-on-one-device-without-pi-hole-or-adguard-home) |
| Phones and laptops away from home | [Away from home](docs/devices.md#away-from-home) |
| Only a Windows or Mac computer to run a blocker on | [AdGuard Home on a Windows or Mac computer](docs/servers.md#adguard-home-on-a-windows-or-mac-computer), or [Technitium DNS Server](docs/servers.md#technitium-dns-server) |
| YouTube ads | [YouTube ads in the browser](docs/devices.md#youtube-ads-in-the-browser) |
| Smart TVs, streaming sticks, consoles | [Smart TVs](docs/tv-and-consoles.md#smart-tvs-and-streaming-sticks), [Game consoles](docs/tv-and-consoles.md#game-consoles) |
| Kids' devices, parental controls | [Suggested setups](#suggested-setups) (Kids / family) |

<div align="right"><a href="#contents">↑ Back to top</a></div>

## Guides

| Guide | What's inside |
|---|---|
| [Lists explained](docs/lists.md) | What each list blocks and leaves working, list notes, blocking by IP address |
| [Single devices, phones and browsers](docs/devices.md) | macOS, Windows, Linux, Android, iPhone / iPad, Chromebook, YouTube ads in the browser, away from home |
| [Routers](docs/routers.md) | UniFi, pfSense, OPNsense, OpenWrt, MikroTik, EdgeRouter, GL.iNet, Asus, mesh Wi-Fi, Starlink / 4G / 5G, Omada, any other router |
| [Raspberry Pi, Docker, NAS and servers](docs/servers.md) | Raspberry Pi, Docker, Synology, QNAP, TrueNAS, Unraid, OpenMediaVault, Proxmox VE, Home Assistant, AdGuard Home on Windows / Mac, Technitium |
| [Smart TVs and game consoles](docs/tv-and-consoles.md) | Blocking TV and console ads and tracking, privacy settings per brand |
| [Troubleshooting](docs/troubleshooting.md) | Is it working?, troubleshooting FAQ, something broke? |
| [For maintainers](docs/maintainers.md) | Sources and licenses, how the lists are built, adding lists |

<div align="right"><a href="#contents">↑ Back to top</a></div>

## Lists

The table below is updated automatically on every build (sources and licenses: [For maintainers](docs/maintainers.md#sources)).

<!-- LISTS:START -->
| List | What it blocks | Domains | Download |
|---|---|---|---|
| `ads-and-tracking` | Ads and trackers with few false positives. Start here. | ~279k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-and-tracking.txt) |
| `ads-and-tracking-extended` | Aggressive ad, tracker, telemetry and pop-up blocking. Contains everything in `ads-and-tracking` plus much more; may need occasional allowlisting. | ~736k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking-extended.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking-extended.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-and-tracking-extended.txt) |
| `ads-regional` | Ad servers for non-English websites and apps: Arabic, Chinese, Russian/Ukrainian/Bulgarian, Turkish, Persian, Hebrew, Japanese, Korean, Vietnamese, Indonesian, European languages and more. Add next to `ads-and-tracking` or the extended list. | ~233k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-regional.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-regional.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-regional.txt) |
| `mobile-ads` | Ad networks used inside Android and iOS apps. | ~8.3k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/mobile-ads.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/mobile-ads.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/mobile-ads.txt) |
| `mobile-spyware` | Phone-maker and app telemetry/tracking (Apple, Samsung, Xiaomi, Huawei, Oppo/Realme, Vivo, TikTok) plus Android trackers. | ~3.2k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/mobile-spyware.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/mobile-spyware.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/mobile-spyware.txt) |
| `youtube-ads` | Google/YouTube ad servers. Partial: DNS cannot block all YouTube video ads (see [YouTube ads](docs/lists.md#youtube-ads)). | 22 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/youtube-ads.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/youtube-ads.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/youtube-ads.txt) |
| `gambling` | Online casinos, sports betting, poker, lotteries and other gambling sites. | ~584k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/gambling.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/gambling.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/gambling.txt) |
| `adult` | Porn and other adult (NSFW) sites (see the [Safe Search tip](docs/lists.md#adult-safe-search)). | ~527k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/adult.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adult.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/adult.txt) |
| `social-media` | Social networks: Facebook, Instagram, TikTok, X/Twitter, Snapchat, Reddit, LinkedIn, Pinterest, Tumblr, Threads, Bluesky, Discord and more. WhatsApp is not blocked. | ~4.5k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/social-media.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/social-media.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/social-media.txt) |
| `smart-tv` | Tracking and ads on smart TVs, streaming sticks and game consoles (Samsung, LG webOS, Roku, Amazon Fire, PlayStation, Xbox, Nintendo). | ~1.4k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/smart-tv.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/smart-tv.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/smart-tv.txt) |
| `game-consoles` | Ads in the system menus and telemetry of PlayStation, Xbox and Nintendo Switch consoles. Small and safe for online play (on Xbox it also hides Game Pass Perks). | 13 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/game-consoles.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/game-consoles.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/game-consoles.txt) |
| `security` | Malware, phishing, scams and fake shops from threat-intelligence feeds. Recommended for everyone (add `phishing-and-scams` for extra phishing feeds). | ~792k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/security.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/security.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/security.txt) |
| `stalkerware` | Spy and monitoring apps that can be secretly installed on a phone to track messages and location. Also blocks parental-control apps such as Bark, so don't use it if you rely on one. | 949 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/stalkerware.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/stalkerware.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/stalkerware.txt) |
| `crypto-mining` | Hidden crypto-mining scripts and mining pools (cryptojacking). Exchanges like Coinbase/Binance are not blocked. | ~12k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/crypto-mining.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/crypto-mining.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/crypto-mining.txt) |
| `phishing-and-scams` | Phishing sites (fake bank, PayPal, Microsoft and delivery logins), scams and fake shops, from extra phishing feeds. Only partly covered by `security`: add both for the strongest phishing protection. | ~564k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/phishing-and-scams.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/phishing-and-scams.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/phishing-and-scams.txt) |
| `live-streaming` | Bigo Live, Likee, MICO, SUGO, Poppo, Chamet, Tango, StreamKar, LiveMe, 17LIVE, Uplive, Hago, Yalla, SoulChill, Azar, HOLLA, Mango, GOGO LIVE, SuperLive, Kumu, Ahlan, Ola Party, Hiya, Nimo TV and ~30 more paid live/video-chat apps (see [notes](docs/lists.md#live-streaming)). | ~2.3k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/live-streaming.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/live-streaming.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/live-streaming.txt) |
| `dating` | Dating sites and apps: Tinder, Bumble, Badoo, Hinge, OkCupid, Plenty of Fish, Match, Grindr, Tantan, happn, Hily, Boo, Taimi, Muzz, Coffee Meets Bagel and ~10,000 dating websites. | ~13k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/dating.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/dating.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/dating.txt) |
| `vpn-proxy-bypass` | VPNs, web proxies and encrypted-DNS services that people use to get around blocking. Use with the other lists to stop bypassing (may block a work VPN). | ~23k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/vpn-proxy-bypass.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/vpn-proxy-bypass.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/vpn-proxy-bypass.txt) |
| `piracy` | Illegal movie, TV, music and software download and streaming sites (torrents, warez). | ~56k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/piracy.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/piracy.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/piracy.txt) |
| `drugs` | Sites selling or promoting illegal drugs. | 436 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/drugs.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/drugs.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/drugs.txt) |
| `online-games` | Online and browser gaming sites, including Steam, Roblox and Epic Games. | ~34k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/online-games.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/online-games.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/online-games.txt) |
| `violence-hate` | Violent, aggressive and hate-speech sites. | 267 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/violence-hate.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/violence-hate.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/violence-hate.txt) |
| `ai-chatbots` | AI chatbots and writing tools (ChatGPT, Claude, Gemini, Copilot, DeepSeek, Character.AI...). Useful for schools and homework time. | 93 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ai-chatbots.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ai-chatbots.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ai-chatbots.txt) |
| `safesearch-bypass` | Search engines that can't enforce SafeSearch. Use with `adult` so explicit results can't be reached through other search engines. | 203 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/safesearch-bypass.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/safesearch-bypass.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/safesearch-bypass.txt) |
| `gaming-platforms` | Roblox, Fortnite/Epic, Free Fire, PUBG/BGMI, Minecraft, Steam, Xbox, PlayStation, Nintendo, EA, Riot (League, Valorant), Battle.net, Ubisoft, Call of Duty, Clash of Clans, Mobile Legends, Genshin Impact, Candy Crush, Among Us. | ~1.9k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/gaming-platforms.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/gaming-platforms.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/gaming-platforms.txt) |
| `youtube` | All of YouTube, including YouTube Kids and embedded YouTube videos on other sites. For homework or bedtime. | 177 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/youtube.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/youtube.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/youtube.txt) |
| `video-streaming` | Netflix, Disney+, Prime Video, Hulu, Max, Paramount+, Peacock, Shahid, OSN+, STARZPLAY, Viu, iQIYI, WeTV, Crunchyroll, Tubi, Pluto TV, JioHotstar, ZEE5, Sony LIV, Twitch, Kick, Apple TV+. | 235 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/video-streaming.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/video-streaming.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/video-streaming.txt) |
| `messaging` | Telegram, Discord, WhatsApp, Messenger, Signal, Viber, LINE, Kik, imo, WeChat, Threema, Botim. Blocks calls and chats in these apps. | 93 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/messaging.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/messaging.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/messaging.txt) |
| `chat-strangers` | Omegle-style random video and text chat sites (OmeTV, Chatroulette, Emerald Chat, Monkey, Uhmegle and more). | 15 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/chat-strangers.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/chat-strangers.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/chat-strangers.txt) |
| `cheating` | Homework-answer and essay-writing sites (Chegg, Course Hero, Brainly, Gauth, Studocu, essay mills). | 78 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/cheating.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/cheating.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/cheating.txt) |
| `remote-control` | AnyDesk, TeamViewer, RustDesk, UltraViewer, ScreenConnect and other remote-access tools that 'tech support' scammers use. Also blocks legitimate remote IT support. | 174 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/remote-control.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/remote-control.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/remote-control.txt) |
| `crypto-trading` | Crypto exchanges, trading platforms and wallets (Binance, Coinbase, Bybit, OKX, KuCoin, Crypto.com, MetaMask...), a common route for investment scams. | ~1.4k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/crypto-trading.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/crypto-trading.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/crypto-trading.txt) |
| `security-strict` | Extra protection on top of `security`: spam/scam-heavy domain endings (e.g. .zip, .mov), dynamic DNS and abused free hosting used by malware, and apps that resell your internet connection. May block some legitimate sites. AdGuard Home / Pi-hole v6 adblock format recommended. | ~2.9k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/security-strict.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/security-strict.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/security-strict.txt) |
| `file-sharing` | File-hosting and file-sharing sites (including Dropbox and many free hosts), common sources of malware and pirated files. | 961 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/file-sharing.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/file-sharing.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/file-sharing.txt) |
| `windows-telemetry` | Microsoft data collection from Windows and Office. Windows Update and Office keep working. | 383 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/windows-telemetry.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/windows-telemetry.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/windows-telemetry.txt) |
| `shopping` | Online shopping sites, for limiting impulse buying. | ~37k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/shopping.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/shopping.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/shopping.txt) |
| `fake-news` | Fake-news and clickbait-scam sites. | ~1.1k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/fake-news.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/fake-news.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/fake-news.txt) |
| `cults` | Sites of cults, sects and psychic/fortune-telling services. | 143 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/cults.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/cults.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/cults.txt) |
| `url-shorteners` | Link shorteners (bit.ly, tinyurl and ~10,000 more) that hide where scam links go. Also breaks normal shortened links. | ~9.9k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/url-shorteners.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/url-shorteners.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/url-shorteners.txt) |
<!-- LISTS:END -->

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Suggested setups

| Goal | Lists to add |
|---|---|
| **Everyone** | `ads-and-tracking`, `security` (+ `ads-regional` if you use non-English sites or apps) |
| **Stronger privacy & security** | swap in `ads-and-tracking-extended`, add `security-strict`, `mobile-spyware`, `smart-tv`, `windows-telemetry`, `crypto-mining` |
| **Smart TVs & streaming sticks** | `smart-tv`, `ads-and-tracking` ([full guide](docs/tv-and-consoles.md#smart-tvs-and-streaming-sticks)) |
| **Game consoles** | `game-consoles`, `ads-and-tracking` ([full guide](docs/tv-and-consoles.md#game-consoles)) |
| **Older or less tech-savvy relatives** | `ads-and-tracking`, `security`, `phishing-and-scams`, `security-strict`, `remote-control`, `crypto-trading` |
| **Kids / family** | `adult`, `safesearch-bypass`, `gambling`, `dating`, `live-streaming`, `chat-strangers`, `drugs`, `violence-hate`, `vpn-proxy-bypass` (stops getting around the blocks) |
| **Focus / school / bedtime** | `social-media`, `youtube`, `video-streaming`, `gaming-platforms`, `online-games`, `messaging`, `ai-chatbots`, `cheating` |

Tip: in AdGuard Home (Settings → Client settings) and Pi-hole (Group Management) you can apply the stricter lists
only to specific devices, such as the kids' phones, and AdGuard Home can switch them on only at certain times.

Each list comes in three formats. Pick the one that fits your setup:

| Format | Folder | Use with |
|---|---|---|
| Adblock (`\|\|domain^`) | `adblock/` | **AdGuard Home** and **Pi-hole v6** (recommended, also blocks subdomains) |
| Plain domains | repo root | Pi-hole v5, AdGuard Home, most other tools |
| Hosts (`0.0.0.0 domain`) | `hosts/` | hosts files, older tools |
| IP ranges | `ips/` | Only for `live-streaming`: `-adguard.txt` for AdGuard Home, CIDR files for routers/firewalls ([how](docs/lists.md#blocking-by-ip-address-ips)) |
| UniFi | `unifi/` | UniFi Cloud Gateway content filter ([how](docs/routers.md#unifi-cloud-gateway-ucg-ultra--max--fiber-udm-udr)) |

URL pattern (replace `<list>` with a name from the table):

```
Adblock: https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/<list>.txt
Plain:   https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/<list>.txt
Hosts:   https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/<list>.txt
```

The original root URLs (`ads-and-tracking.txt`, `ads-and-tracking-extended.txt`, `mobile-ads.txt`,
`mobile-spyware.txt`) still work, so existing setups keep updating with no changes.

<div align="right"><a href="#contents">↑ Back to top</a></div>

## How to add a list

Copy a list's **Adblock** link from the [Lists](#lists) table (right-click → Copy link), then:

**AdGuard Home:** **Filters → DNS blocklists → Add blocklist → Add a custom list** → enter a name (e.g. the list's name)
and paste the link → **Save**. AdGuard Home checks every list for updates once a day by itself (**Settings → General
settings → Filters update interval**).

**Pi-hole v6:** **Lists** → paste the link into *Domain or URL* (add a comment if you like) → **Add blocklist** → then
**Tools → Update Gravity** → **Update** (or run `pihole -g`). Pi-hole refreshes its lists once a week by itself.

**Pi-hole v5:** **Group Management → Adlists** → paste the **Plain** link instead → **Add**, then run `pihole -g`.

Good to know:
- Don't combine `ads-and-tracking` with `ads-and-tracking-extended`: the extended list already contains it. See
  [What each list blocks](docs/lists.md#what-each-list-blocks-and-what-it-doesnt) for which lists overlap and which add something new.
- Every list uses memory on the device running your blocker; the [Lists](#lists) table shows how many names each has.
- Then check it with [Is it working?](docs/troubleshooting.md#is-it-working).

<div align="right"><a href="#contents">↑ Back to top</a></div>

## Contributing and license

**Found a wrong block, a missed domain or an outdated guide?** [Open an issue](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/issues/new/choose)
using one of the forms, or see [CONTRIBUTING.md](CONTRIBUTING.md) to make the change yourself.

**License:**
- **Scripts, guides and build tools:** [GPL-3.0](LICENSE).
- **The generated lists:** they combine third-party sources and stay under those sources' licenses (see
  [Sources](docs/maintainers.md#sources)). Most are GPL-3.0, MIT or Creative Commons, and every list is free for
  personal and home use.
- **Non-commercial sources:** a few allow non-commercial use only:
  - Peter Lowe's list: `ads-and-tracking`, `ads-and-tracking-extended`
  - Dan Pollock's list: `ads-and-tracking-extended`
  - Polish filters: `ads-regional`
  - Phishing Army: `security`, `phishing-and-scams`

  For commercial use of those lists, check those sources' terms.

<div align="right"><a href="#contents">↑ Back to top</a></div>

## Changelog

Latest changes (the full history is in [CHANGELOG.md](CHANGELOG.md); the lists' contents also refresh every day):

- **2026-10-10:**
  - **Added:** a Quick start; guides for routers, NAS systems, TVs, consoles, phones and away from home; device installers
    for macOS, Windows, Linux, Android and EdgeRouter; YouTube browser lists; and 17 more lists, including
    `ads-regional`, `game-consoles`, `youtube`, `messaging` and `security-strict`.
  - **Changed:** guides moved into separate pages in [`docs/`](#guides), with "Back to top" links on every section.
  - **Fixed:** `t.co` and `bit.ly` links being blocked; `chat-strangers` blocking WhatsApp and Discord; and the wrong
    claim that `security` contains `phishing-and-scams`.
- **2026-10-09:** added the parental-control and content lists (`adult`, `gambling`, `dating`, `social-media`,
  `live-streaming`, `vpn-proxy-bypass` and more).
- **2026-10-08:** lists rebuilt from maintained sources with daily updates, in three formats. The old addresses still
  work.

<div align="right"><a href="#contents">↑ Back to top</a></div>
