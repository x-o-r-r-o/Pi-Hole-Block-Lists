# Pi-Hole-Block-Lists

[![Update block lists](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/actions/workflows/update.yml/badge.svg)](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/actions/workflows/update.yml)

Ready-to-use DNS block lists for **Pi-hole** and **AdGuard Home**, rebuilt **every day**
from well-maintained upstream sources, merged and de-duplicated.

## Contents

<!-- TOC:START -->
- [Lists](#lists)
  - [Suggested setups](#suggested-setups)
- [How to add a list](#how-to-add-a-list)
- [Use on one device, without Pi-hole or AdGuard Home](#use-on-one-device-without-pi-hole-or-adguard-home)
  - [macOS](#macos)
  - [Windows 10 / 11](#windows-10--11)
  - [Linux](#linux)
  - [Android](#android)
  - [iPhone and iPad](#iphone-and-ipad)
- [YouTube ads in the browser](#youtube-ads-in-the-browser)
- [Blocking by IP address (ips/)](#blocking-by-ip-address-ips)
- [UniFi Cloud Gateway (UCG Ultra / Max / Fiber, UDM, UDR)](#unifi-cloud-gateway-ucg-ultra--max--fiber-udm-udr)
  - [Option 1 (recommended): UniFi + AdGuard Home or Pi-hole, updates automatically](#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically)
  - [Option 2: UniFi only, no extra device (manual updates)](#option-2-unifi-only-no-extra-device-manual-updates)
- [Routers: pfSense, OPNsense, OpenWrt, MikroTik and EdgeRouter](#routers-pfsense-opnsense-openwrt-mikrotik-and-edgerouter)
  - [pfSense](#pfsense)
  - [OPNsense](#opnsense)
  - [OpenWrt](#openwrt)
  - [MikroTik](#mikrotik)
  - [Ubiquiti EdgeRouter](#ubiquiti-edgerouter)
- [Synology NAS](#synology-nas)
  - [Step 1: prepare the NAS](#step-1-prepare-the-nas)
  - [Step 2: run AdGuard Home](#step-2-run-adguard-home)
  - [Step 3: use it for the whole home](#step-3-use-it-for-the-whole-home)
- [Raspberry Pi](#raspberry-pi)
  - [Step 1: set up the Pi](#step-1-set-up-the-pi)
  - [Step 2: install AdGuard Home or Pi-hole](#step-2-install-adguard-home-or-pi-hole)
  - [Step 3: use it for the whole home](#step-3-use-it-for-the-whole-home-1)
- [Docker](#docker)
  - [Step 1: free port 53 (Ubuntu and Debian servers)](#step-1-free-port-53-ubuntu-and-debian-servers)
  - [Step 2: start AdGuard Home or Pi-hole](#step-2-start-adguard-home-or-pi-hole)
  - [Step 3: use it for the whole home](#step-3-use-it-for-the-whole-home-2)
- [Proxmox VE](#proxmox-ve)
  - [Step 1: create the container](#step-1-create-the-container)
  - [Step 2: install AdGuard Home or Pi-hole](#step-2-install-adguard-home-or-pi-hole-1)
  - [Step 3: use it for the whole home, and keep it safe](#step-3-use-it-for-the-whole-home-and-keep-it-safe)
- [TrueNAS](#truenas)
  - [Step 1: prepare TrueNAS](#step-1-prepare-truenas)
  - [Step 2: install AdGuard Home or Pi-hole from the Apps catalogue](#step-2-install-adguard-home-or-pi-hole-from-the-apps-catalogue)
  - [Step 3: use it for the whole home](#step-3-use-it-for-the-whole-home-3)
- [Smart TVs and streaming sticks](#smart-tvs-and-streaming-sticks)
  - [Step 1: block the TV's ad and tracking servers](#step-1-block-the-tvs-ad-and-tracking-servers)
  - [Step 2: turn off viewing data and ad tracking on the TV](#step-2-turn-off-viewing-data-and-ad-tracking-on-the-tv)
  - [Step 3: stop devices that ignore your DNS](#step-3-stop-devices-that-ignore-your-dns)
  - [What to expect](#what-to-expect)
- [Game consoles](#game-consoles)
  - [Step 1: block console ads and telemetry](#step-1-block-console-ads-and-telemetry)
  - [Step 2: turn off tracking and ads in the console's settings](#step-2-turn-off-tracking-and-ads-in-the-consoles-settings)
  - [What to expect](#what-to-expect-1)
- [Something broke?](#something-broke)
- [Adding your own domains](#adding-your-own-domains)
- [How it updates](#how-it-updates)
- [Sources](#sources)
- [Adding a new list or source](#adding-a-new-list-or-source)
<!-- TOC:END -->

## Lists

The table below and the Sources table are updated automatically on every build.

<!-- LISTS:START -->
| List | What it blocks | Domains | Download |
|---|---|---|---|
| `ads-and-tracking` | Ads and trackers with few false positives. Start here. | ~279k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-and-tracking.txt) |
| `ads-and-tracking-extended` | Aggressive ad, tracker, telemetry and pop-up blocking. Blocks more, may need occasional allowlisting. | ~733k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking-extended.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking-extended.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-and-tracking-extended.txt) |
| `ads-regional` | Ad servers for non-English websites and apps: Arabic, Chinese, Russian/Ukrainian/Bulgarian, Turkish, Persian, Hebrew, Japanese, Korean, Vietnamese, Indonesian, European languages and more. Add next to `ads-and-tracking` or the extended list. | ~233k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-regional.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-regional.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-regional.txt) |
| `mobile-ads` | Ad networks used inside Android and iOS apps. | ~8.3k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/mobile-ads.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/mobile-ads.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/mobile-ads.txt) |
| `mobile-spyware` | Phone-maker and app telemetry/tracking (Apple, Samsung, Xiaomi, Huawei, Oppo/Realme, Vivo, TikTok) plus Android trackers. | ~3.2k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/mobile-spyware.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/mobile-spyware.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/mobile-spyware.txt) |
| `youtube-ads` | Google/YouTube ad servers. Partial: DNS cannot block all YouTube video ads (see note below). | 22 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/youtube-ads.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/youtube-ads.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/youtube-ads.txt) |
| `gambling` | Online casinos, sports betting, poker, lotteries and other gambling sites. | ~584k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/gambling.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/gambling.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/gambling.txt) |
| `adult` | Porn and other adult (NSFW) sites (see Safe Search tip below). | ~527k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/adult.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adult.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/adult.txt) |
| `social-media` | Social networks: Facebook, Instagram, TikTok, X/Twitter, Snapchat, Reddit, LinkedIn, Pinterest, Tumblr, Threads, Bluesky, Discord and more. WhatsApp is not blocked. | ~4.5k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/social-media.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/social-media.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/social-media.txt) |
| `smart-tv` | Tracking and ads on smart TVs, streaming sticks and game consoles (Samsung, LG webOS, Roku, Amazon Fire, PlayStation, Xbox, Nintendo). | ~1.4k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/smart-tv.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/smart-tv.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/smart-tv.txt) |
| `game-consoles` | Ads in the system menus and telemetry of PlayStation, Xbox and Nintendo Switch consoles. Small and safe for online play (on Xbox it also hides Game Pass Perks). | 13 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/game-consoles.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/game-consoles.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/game-consoles.txt) |
| `security` | Malware, phishing, scams and fake shops from threat-intelligence feeds. Recommended for everyone. | ~792k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/security.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/security.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/security.txt) |
| `stalkerware` | Spy and monitoring apps that can be secretly installed on a phone to track messages and location. Also blocks parental-control apps such as Bark, so don't use it if you rely on one. | 949 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/stalkerware.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/stalkerware.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/stalkerware.txt) |
| `crypto-mining` | Hidden crypto-mining scripts and mining pools (cryptojacking). Exchanges like Coinbase/Binance are not blocked. | ~12k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/crypto-mining.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/crypto-mining.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/crypto-mining.txt) |
| `phishing-and-scams` | Phishing sites (fake bank, PayPal, Microsoft and delivery logins), scams and fake shops. Already included in `security`; use this if you only want phishing/scam protection. | ~564k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/phishing-and-scams.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/phishing-and-scams.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/phishing-and-scams.txt) |
| `live-streaming` | Bigo Live, Likee, MICO, SUGO, Poppo, Chamet, Tango, StreamKar, LiveMe, 17LIVE, Uplive, Hago, Yalla, SoulChill, Azar, HOLLA, Mango, GOGO LIVE, SuperLive, Kumu, Ahlan, Ola Party, Hiya, Nimo TV and ~30 more paid live/video-chat apps (see note below). | ~2.3k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/live-streaming.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/live-streaming.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/live-streaming.txt) |
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

### Suggested setups

| Goal | Lists to add |
|---|---|
| **Everyone** | `ads-and-tracking`, `security` (+ `ads-regional` if you use non-English sites or apps) |
| **Stronger privacy & security** | swap in `ads-and-tracking-extended`, add `security-strict`, `mobile-spyware`, `smart-tv`, `windows-telemetry`, `crypto-mining` |
| **Smart TVs & streaming sticks** | `smart-tv`, `ads-and-tracking` ([full guide](#smart-tvs-and-streaming-sticks)) |
| **Game consoles** | `game-consoles`, `ads-and-tracking` ([full guide](#game-consoles)) |
| **Older or less tech-savvy relatives** | `ads-and-tracking`, `security`, `security-strict`, `phishing-and-scams`, `remote-control`, `crypto-trading` |
| **Kids / family** | `adult`, `safesearch-bypass`, `gambling`, `dating`, `live-streaming`, `chat-strangers`, `drugs`, `violence-hate`, `vpn-proxy-bypass` (stops getting around the blocks) |
| **Focus / school / bedtime** | `social-media`, `youtube`, `video-streaming`, `gaming-platforms`, `online-games`, `messaging`, `ai-chatbots`, `cheating` |

Tip: in AdGuard Home (Settings → Client settings) and Pi-hole (Group Management) you can apply the stricter lists
only to specific devices, such as the kids' phones, and AdGuard Home can switch them on only at certain times.

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
> | **Router / firewall** (optional, extra) | the IP lists, see [Blocking by IP address](#blocking-by-ip-address-ips) |
>
> Only Bigo runs its own network. The other apps use shared clouds (Alibaba, Amazon, Cloudflare...), so their IPs are not
> listed: blocking them would break normal websites. Pi-hole can't block by IP, which is why the router option exists.
> Also block the app installs with your phone's parental controls (Google Family Link / Apple Screen Time).
> To add an app, put its domains in `apps/live-streaming.json` and push. `dating`, `gaming-platforms`, `video-streaming` and `messaging` work the same way with their own file in [`apps/`](apps/).

> **About `security-strict`:** besides domains, it blocks whole spam-heavy web-address endings such as `.zip` and `.mov`
> (with exceptions for known legitimate sites). Those ending rules only exist in the **adblock** version and are fully
> supported by AdGuard Home; Pi-hole may skip them, but the rest of the list still works there.

> **Tip for `adult`:** a block list can't stop explicit images from appearing in Google/Bing image search.
> In AdGuard Home, also turn on **Settings → General settings → Enforce Safe Search** (and Safe Browsing).

> **About YouTube ads:** YouTube serves most video ads from the same servers as the videos (`googlevideo.com`),
> so no DNS blocker (Pi-hole or AdGuard Home) can remove them all. `youtube-ads` blocks the separate Google/YouTube ad and
> ad-tracking servers (using AdGuard's own DNS rules) and keeps AdGuard's exceptions, so clicking Google's sponsored search
> results still works. That stops some ads, mostly in apps, on smart TVs and on other websites. To remove every YouTube ad,
> use a browser ad blocker such as uBlock Origin or AdGuard, or YouTube Premium. Those work inside the page: small scripts
> remove the ad instructions (`adPlacements`, `playerAds`, `adSlots`) from the video data before YouTube's player reads
> them, and hide leftover ad boxes. A DNS blocker only sees server names, so it can't do that.

Each list comes in three formats. Pick the one that fits your setup:

| Format | Folder | Use with |
|---|---|---|
| Adblock (`\|\|domain^`) | `adblock/` | **AdGuard Home** and **Pi-hole v6** (recommended, also blocks subdomains) |
| Plain domains | repo root | Pi-hole v5, AdGuard Home, most other tools |
| Hosts (`0.0.0.0 domain`) | `hosts/` | hosts files, older tools |
| IP ranges | `ips/` | Only for `live-streaming`: `-adguard.txt` for AdGuard Home, CIDR files for routers/firewalls ([how](#blocking-by-ip-address-ips)) |
| UniFi | `unifi/` | UniFi Cloud Gateway content filter ([how](#unifi-cloud-gateway-ucg-ultra--max--fiber-udm-udr)) |

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

## Use on one device, without Pi-hole or AdGuard Home

Don't have a Pi-hole or AdGuard Home? These scripts block the lists you choose on a single computer or phone by adding
them to the device's **hosts file** (a built-in system file that maps names to addresses). Each script shows a menu of
every list above, lets you pick one or several, backs up your original hosts file, and can update itself every day.

| System | Script | How it blocks |
|---|---|---|
| macOS | [`install/macos.sh`](install/macos.sh) | hosts file, daily update via launchd |
| Windows 10/11 | [`install/windows.ps1`](install/windows.ps1) | hosts file, daily update via Task Scheduler |
| Linux | [`install/linux.sh`](install/linux.sh) | hosts file, daily update via cron or systemd |
| Android | [`install/android.sh`](install/android.sh) (in Termux) | rooted: hosts file. Not rooted: sets you up with the free AdAway app |
| Ubiquiti EdgeRouter | [`install/edgerouter.sh`](install/edgerouter.sh) | the router's DNS (dnsmasq) for every device, daily update via the task scheduler; see [EdgeRouter](#ubiquiti-edgerouter) |
| iPhone / iPad | no script possible (see [iPhone and iPad](#iphone-and-ipad)) | your AdGuard Home / Pi-hole, the AdGuard app, AdGuard DNS, or Screen Time |

**Good to know before you start**
- Pick only what you need. The hosts file has no wildcards, so every server name is listed one by one. Big lists such as
  `ads-and-tracking-extended`, `security` or `adult` (500k+ names each) are fine on macOS and Linux, but **Windows gets
  slow above ~150,000 names**; the Windows script warns you. `ads-and-tracking` + `security` is a good start.
- It blocks in every app and browser on that device, including with the browser's "Secure DNS" setting on.
- It only protects the device you run it on. To protect every device at home at once, use Pi-hole or AdGuard Home.
- Your original hosts file is saved once as `hosts.block-lists-backup` next to it, and `--remove` / `-Remove` takes out
  only what the script added.

### macOS

1. Open **Terminal** (press ⌘ Space, type *Terminal*, press Enter).
2. Download the script:
   ```bash
   curl -fsSLO https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/install/macos.sh
   ```
3. Run it, type your Mac password when asked:
   ```bash
   sudo bash macos.sh
   ```
4. Type the numbers of the lists you want (for example `1 12 14`) and press Enter. Press Enter alone for the
   recommended set (Ads & Tracking + Security).
5. Answer **y** to "Update these lists automatically every day?" if you want that.
6. Restart your browser.

Later: `sudo bash macos.sh --update` (refresh now), `sudo bash macos.sh` (choose different lists),
`sudo bash macos.sh --remove` (undo everything), `sudo bash macos.sh --auto-update off`.
You can also skip the menu: `sudo bash macos.sh --lists ads-and-tracking,security,adult`.

### Windows 10 / 11

1. Click **Start**, type *PowerShell* and open **Windows PowerShell**.
2. Download the script to your Downloads folder:
   ```powershell
   cd $HOME\Downloads; Invoke-WebRequest https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/install/windows.ps1 -OutFile windows.ps1
   ```
3. Run it and click **Yes** when Windows asks for administrator permission:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\windows.ps1
   ```
4. A window lists every block list. Click the ones you want (hold **Ctrl** to pick several), then click **OK**.
5. Answer **y** to the daily-update question if you want that, then restart your browser.

Later (in PowerShell, in your Downloads folder): `... -File .\windows.ps1 -Update`, `-Remove`, `-AutoUpdate off`, or
`-Lists ads-and-tracking,security` to skip the window. `-NoGui` shows a text menu instead of the window.

If you choose `windows-telemetry`, Microsoft Defender may warn about a "HostsFileHijack". That's expected (the list blocks
Microsoft's own data collection): choose *Allow on device*.

### Linux

```bash
curl -fsSLO https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/install/linux.sh     # or: wget https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/install/linux.sh
sudo bash linux.sh
```
Then follow the same menu as on macOS. The same `--update`, `--remove`, `--lists`, `--auto-update` options work.

### Android

**Most phones (not rooted):** Android doesn't let apps change the hosts file, so use the free **AdAway** app, which reads
these lists directly and blocks them through a local VPN (nothing leaves your phone):

1. Install AdAway from [adaway.org](https://adaway.org) or F-Droid and open it. Choose **VPN-based ad blocking**.
2. Go to **Hosts sources → +** and add the link of each list you want, in the `hosts/` format:
   `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/<list>.txt` (for example `.../hosts/ads-and-tracking.txt`).
3. Tap the update button. AdAway keeps the lists up to date.

Want help picking? Install [Termux](https://termux.dev) (from F-Droid), then run the script; it shows the menu and copies
the links for AdAway to your clipboard (with the Termux:API add-on):
```bash
pkg install curl; curl -fsSLO https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/install/android.sh; bash android.sh
```

**Rooted phones (Magisk):** turn on **Magisk → Settings → Systemless hosts** and reboot, then run the same Termux commands.
The script asks for root access and writes the lists into the hosts file. Re-run `bash android.sh --update` to refresh,
or `bash android.sh --remove` to undo.

### iPhone and iPad

Apple doesn't let apps or scripts change the hosts file on iOS / iPadOS, so there's no installer. Pick one of these
instead:

**Option 1: your AdGuard Home or Pi-hole (free, blocks in every app; recommended).**
- *At home on Wi-Fi:* if your router (or UniFi, see below) already hands out AdGuard Home / Pi-hole as the DNS server,
  there's nothing to do. Otherwise: **Settings → Wi-Fi** → tap **ⓘ** next to your network → **Configure DNS** →
  **Manual** → remove the existing servers → **Add Server** → type the IP address of your AdGuard Home / Pi-hole →
  **Save**.
- *Everywhere, also on mobile data:* this needs AdGuard Home with encryption turned on and reachable from the internet
  (Settings → Encryption settings in AdGuard Home). Then in AdGuard Home open **Setup Guide → DNS Privacy → iOS** and
  download the **.mobileconfig** profile. Open it on the iPhone, install it under **Settings → General → VPN & Device
  Management**, and make sure it's selected under **DNS** on that same screen. (Pi-hole has no encrypted DNS of its own,
  so away from home it only works through a VPN back to your house, such as WireGuard or Tailscale.)

**Option 2: the AdGuard app (no server needed; needs AdGuard Premium).** Custom DNS filters, custom Safari filters and
Advanced protection are Premium features.
1. Install **AdGuard** from the App Store and upgrade to Premium.
2. Tap the ⚙ gear → **General** → turn on **Advanced mode**.
3. Tap the 🛡 shield (**Protection**) → **DNS protection** → turn it on → **DNS filtering** → **DNS filters** →
   **Add a filter** → paste a list link in the adblock format, e.g. `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking.txt` → **Next** →
   **Add**. Repeat for each list. Keep it to a few lists: AdGuard filters inside the phone (as a local VPN), and very
   large lists use more memory and battery.
4. YouTube ads in Safari: **Protection → Safari protection → Filters → Custom → Add custom filter** →
   `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/browser/youtube-ads-adguard.txt` (tick **Trusted** if offered), turn on **Advanced protection**, and enable the
   AdGuard extensions under iPhone **Settings → Apps → Safari → Extensions**. The YouTube *app* itself can't be filtered.

Only one VPN-type app can run at a time on iOS, so AdGuard (Option 2) can't run alongside another VPN.

**Option 3: AdGuard DNS cloud service (small lists only).** At [adguard-dns.io](https://adguard-dns.io), open **Servers →
My server → Blocklists → Custom → Add custom blocklist** and paste a list link, then install the server's iOS profile from
its **Devices** page. The Personal plan allows only 1,000 rules, so this fits only tiny lists such as
`https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/youtube-ads.txt` or `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/live-streaming.txt`.

**Built-in Screen Time (free, for children's devices).** It can't load these lists, but it covers some of the same ground:
**Settings → Screen Time → Content & Privacy Restrictions → App Store, Media, Web & Games**: under **Web Content** choose
**Limit Adult Websites** and add any sites you want to block under *Never Allow* (for example `bigo.tv`, `tiktok.com`);
under **App Store** limit apps by age or block app installs. App Limits and Downtime set time limits per app.

## YouTube ads in the browser

DNS and hosts-file blocking can't remove YouTube video ads (see the note above). Browser ad blockers can, and these lists
collect the YouTube rules from **uBlock Origin** and **AdGuard**, rebuilt every day:

| Ad blocker | Add this list |
|---|---|
| uBlock Origin, Brave | `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/browser/youtube-ads-ublock.txt` |
| AdGuard (browser extension, AdGuard for Windows / Mac / Android) | `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/browser/youtube-ads-adguard.txt` |

**How to add it**
- **uBlock Origin** (Firefox, Edge, Chrome): click the uBlock icon → ⚙ Dashboard → **Filter lists** → scroll down →
  **Import…** → paste the link → **Apply changes**.
- **AdGuard extension / apps**: Settings → **Filters** → **Custom** → **Add custom filter** → paste the link → tick
  **Trusted** (needed for the rules that edit YouTube's player data) → **Subscribe**.
- **Brave**: open `brave://settings/shields/filters` → **Add custom filter list** → paste the link.
- **Android phones**: use Firefox for Android with uBlock Origin, or the AdGuard app (with HTTPS filtering on), and add
  the link the same way.
- **iPhone / iPad**: AdGuard for iOS (Premium) in Safari, see [iPhone and iPad](#iphone-and-ipad) step 4.

Honest note: uBlock Origin and AdGuard **already include these rules** in their default lists, and uBlock Origin
ignores the most powerful kind ("trusted" rules) when they come from an added list. So with a default uBlock Origin
setup this list adds little; it's most useful in AdGuard, Brave, or blockers where the default lists are turned off.
For the in-video sponsor messages creators read themselves, add the free **SponsorBlock** extension.

## Blocking by IP address (`ips/`)

Some apps connect straight to an IP address and never ask DNS, so a DNS or hosts-file blocker can't see them. For those,
`ips/` lists the IP ranges of **Bigo Technology's own network** (Bigo Live, HelloYo and other Bigo services), refreshed
daily from internet routing records. Only Bigo runs its own network: the other apps use shared clouds (Alibaba, Amazon,
Cloudflare...), so blocking their IPs would break normal websites, and they're not listed.

| File | Use with |
|---|---|
| [`ips/live-streaming-adguard.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-adguard.txt) | AdGuard Home |
| [`ips/live-streaming-ipv4.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-ipv4.txt) / [`-ipv6.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-ipv6.txt) | Routers and firewalls (pfSense, OPNsense, OpenWrt, UniFi, Windows Firewall) |
| [`ips/live-streaming-mikrotik.rsc`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-mikrotik.rsc) | MikroTik RouterOS (`/import`) |
| [`ips/live-streaming-edgeos.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-edgeos.txt) | Ubiquiti EdgeRouter (paste in `configure` mode) |
| [`ips/live-streaming.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming.txt) | Same, IPv4 and IPv6 together |

**AdGuard Home:** Filters → DNS blocklists → Add blocklist → Add a custom list → paste the `-adguard.txt` link → Save.
AdGuard Home then refuses any DNS answer that points into Bigo's network, which also catches new Bigo server names.
Use it together with `adblock/live-streaming.txt`. (Pi-hole can't block by IP; use your router for that.)

**pfSense (pfBlockerNG)** ([full router guide](#pfsense)): Firewall → pfBlockerNG → **IP → IPv4** → Add → paste the `-ipv4.txt` link as the source,
Action *Deny Both*, Update frequency *Once a day* → Save, then run **Update → Force Update**. Repeat under **IPv6** with
`-ipv6.txt`.

**OPNsense** ([full router guide](#opnsense)): Firewall → **Aliases** → + → Type *URL Table (IPs)*, Content: the `live-streaming.txt` link, Refresh
frequency 1 day → Save → Apply. Then Firewall → **Rules → LAN** → + → Action *Block*, Destination: the alias → Save →
Apply.

**OpenWrt** ([full router guide](#openwrt)): with the **banIP** package, add the `-ipv4.txt` / `-ipv6.txt` links as custom feeds (see the banIP docs for
your OpenWrt version).

**MikroTik** ([full router guide](#mikrotik)): import [`ips/live-streaming-mikrotik.rsc`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-mikrotik.rsc), which fills an address list named `live-streaming`, then block that list in the forward chain.

**Ubiquiti EdgeRouter** ([full router guide](#ubiquiti-edgerouter)): paste [`ips/live-streaming-edgeos.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-edgeos.txt) in configure mode to create the network group `live-streaming`, then drop it in your `LAN_IN` firewall.

**Windows Firewall (one PC):** in PowerShell as administrator:
```powershell
$ips = (Invoke-RestMethod https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming.txt) -split "`n" | Where-Object { $_ -and $_ -notmatch '^#' }
New-NetFirewallRule -DisplayName "Block Bigo network" -Direction Outbound -Action Block -RemoteAddress $ips
```
Undo with `Remove-NetFirewallRule -DisplayName "Block Bigo network"`. Re-run both lines now and then to refresh.

**Linux with ufw (one PC):**
```bash
curl -fsSL https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-ipv4.txt | grep -v '^#' | grep . | xargs -n1 sudo ufw deny out to
```

## UniFi Cloud Gateway (UCG Ultra / Max / Fiber, UDM, UDR)

UniFi's built-in **Ad Blocking** uses Ubiquiti's own list only, and its **Content Filter** block list can't subscribe to a
list by link (you paste or upload entries, and they don't update themselves). So there are two ways to use these lists:

### Option 1 (recommended): UniFi + AdGuard Home or Pi-hole, updates automatically

Run AdGuard Home or Pi-hole on any always-on device (a Raspberry Pi, a NAS, a mini PC or Docker), add the lists you want
(see [How to add a list](#how-to-add-a-list)), then make UniFi hand it out as the DNS server:

1. In the **UniFi Network** app: **Settings → Networks** → choose your network → **DHCP** (under *DHCP Service
   Management*) → **DNS Server**: turn off *Auto* and enter the IP address of your AdGuard Home / Pi-hole → **Apply**.
   Repeat for each network (for example a separate Kids or IoT network).
2. Turn **off** UniFi's own **Ad Blocking** (Settings → CyberSecure → Ad Blocking, or Settings → Security on older
   versions). While it's on, the gateway sends all DNS to itself, which skips AdGuard Home / Pi-hole.
3. Stop devices from going around it: **Settings → Policy Engine → Firewall** (Zone-Based Firewall) → **Create Policy** →
   Action *Block*, Source zone *Internal* (exclude the AdGuard Home / Pi-hole IP), Destination zone *External*, port
   **53** and **853**, protocol TCP and UDP → Save. Also add the `vpn-proxy-bypass` list in AdGuard Home / Pi-hole to
   stop encrypted DNS (DNS-over-HTTPS) and VPN apps.
4. Turn Wi-Fi off and on (or reconnect) on each device so it picks up the new DNS server.

To block Bigo by IP as well, add `ips/live-streaming-adguard.txt` in AdGuard Home (above) or use Option 2, step 4.

### Option 2: UniFi only, no extra device (manual updates)

The [`unifi/`](unifi/) folder has every list in the format UniFi's content filter expects: one domain per line, no
comments, and each entry also blocks its subdomains.

1. Download the file you want, e.g. [`unifi/live-streaming.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/unifi/live-streaming.txt) (right-click → Save link as).
2. In the **UniFi Network** app: **Settings → CyberSecure → Content Filter** → select (or create) the filter for your
   network → **Block List** → **Add Multiple** and upload the `.txt` file (or paste its contents) → **Apply**.
3. Repeat every few weeks with a fresh download: UniFi can't update the list by itself.
4. To block Bigo by IP: **Settings → Profiles → IP Groups** (*Port & IP Groups* / *Network Lists* on some versions) →
   create a group named *Bigo network* and add the ranges from
   [`ips/live-streaming-ipv4.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-ipv4.txt) (66 entries). Then **Policy Engine → Firewall →
   Create Policy** → Action *Block*, Source zone *Internal*, Destination zone *External* → destination: the IP group →
   Save.

Keep Option 2 to the smaller lists (for example `live-streaming`, `social-media`, `dating`, `youtube`,
`gaming-platforms`, `messaging`, `video-streaming`, `ai-chatbots`). Lists with hundreds of thousands of entries
(`security`, `adult`, `gambling`, the ads lists) can be rejected or slow the gateway down; use Option 1 for those.
Devices that use their own encrypted DNS (browser "Secure DNS", Android "Private DNS") skip the gateway's filter;
block them with Option 1, step 3. Menu names move around between UniFi Network versions; Ubiquiti's
[Content and Domain Filtering](https://help.ui.com/hc/en-us/articles/12568927589143-Content-and-Domain-Filtering-in-UniFi)
and [Zone-Based Firewall](https://help.ui.com/hc/en-us/articles/115003173168-Zone-Based-Firewalls-in-UniFi) help pages
show the current ones.

## Routers: pfSense, OPNsense, OpenWrt, MikroTik and EdgeRouter

If your router runs pfSense, OPNsense, OpenWrt, MikroTik RouterOS or a Ubiquiti EdgeRouter, it can do the blocking itself for every device at home, and update the lists
every day. Each router has two ways: its own blocking package, or AdGuard Home running next to it.

Which list link to use:
- **pfSense (pfBlockerNG)**, **OPNsense (Unbound blocklists)** and **OpenWrt (adblock-fast)**: the **plain** links, `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/<list>.txt`
  (for example `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking.txt`).
- **EdgeRouter**: no links needed, the [script](#ubiquiti-edgerouter) shows a menu.
- **MikroTik (DNS adlist)**: the **hosts** links, `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/<list>.txt`.
- **AdGuard Home** (on any of them): the **adblock** links, `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/<list>.txt`.

Router memory is the limit: roughly 100 MB of free RAM per 500,000 domains. Check **Status → Dashboard** (pfSense), **Lobby → Dashboard** (OPNsense),
**Status → Overview** (OpenWrt) or **System → Resources** (MikroTik) and start small (`ads-and-tracking` + `security`), adding more lists while there's room.

### pfSense

**Option A: pfBlockerNG (built into pfSense, recommended).**
1. **System → Package Manager → Available Packages** → search *pfBlockerNG* → **Install**.
2. **Firewall → pfBlockerNG** → follow the setup wizard (or tick **Enable pfBlockerNG** on the *General* tab) → Save.
3. **Firewall → pfBlockerNG → DNSBL**: tick **Enable DNSBL**, set **DNSBL Mode** to **Unbound python mode** → Save.
4. **Firewall → pfBlockerNG → DNSBL → DNSBL Groups → + Add**: give it a name (e.g. *BlockLists*). Under **DNSBL
   Source Definitions** add one row per list: State *ON*, Source = the plain link, Header = a short name (e.g.
   *ads_and_tracking*). Set **Action** to **Unbound** (a new group starts as *Disabled*) and **Update frequency** to
   **Once a day** → Save.
5. **Firewall → pfBlockerNG → Update** → select **Force**, **Reload**, **All** → **Run**. Read the log for download
   errors.
6. Devices must use pfSense as their DNS server, which is the default (DNS Resolver enabled, DHCP handing out pfSense).
   Check **Services → DNS Resolver** is enabled.
7. Optional, block by IP: add the [IP lists](#blocking-by-ip-address-ips) under **pfBlockerNG → IP → IPv4 / IPv6**.

If DNS stops working after step 3, switch DNSBL Mode back to *Unbound mode* and Force Reload: Python mode has had
problems on some versions.

**Option B: AdGuard Home on another device.** Run AdGuard Home on a Raspberry Pi, NAS or server and add the adblock
links there. Then in pfSense go to **Services → DHCP Server → LAN → DNS servers**, enter the AdGuard Home IP address →
Save, and reconnect your devices.

**Stop devices from going around it (both options):** **Firewall → NAT → Port Forward → Add**: Interface *LAN*, Protocol
*TCP/UDP*, Destination tick **Invert match** and choose *LAN address*, Destination port *DNS (53)*, Redirect target IP
*127.0.0.1* (Option B: the AdGuard Home IP), Redirect port *53* → Save → Apply. Then **Firewall → Rules → LAN → Add**:
Action *Block*, Protocol *TCP/UDP*, Destination port *853* → Save → Apply. Also add the `vpn-proxy-bypass` list.

### OPNsense

**Option A: Unbound DNS blocklists (built in, recommended).** No extra package needed.
1. **Services → Unbound DNS → General**: make sure **Enable Unbound** is ticked (it is by default, and DHCP hands out
   OPNsense as the DNS server).
2. **Services → Unbound DNS → Blocklists** → **Enable**. Leave **Type of DNSBL** empty (or keep any predefined lists you
   like) and paste the plain links of the lists you want into **URLs of Blocklists**, one per entry, e.g.
   `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking.txt` and `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/security.txt` → **Apply**. Unbound loads them within about a minute,
   without restarting.
3. Different lists per network: add a second blocklist policy and set its **Source Net(s)** to, for example, the kids'
   network, with stricter lists such as `adult`, `gambling` and `live-streaming`. Leave Source Net(s) empty on the policy
   that should apply to everyone.
4. Daily updates: **System → Settings → Cron** → **+** → Command **Update Unbound DNSBLs**, Hours *4*, Minutes *30* →
   Save → Apply.
5. Check it: **Reporting → Unbound DNS** shows blocked queries, and the Blocklists page has a tester for single names.
   If a site breaks, add it under **Allowlist Domains** (or permanently in [`allowlist.txt`](allowlist.txt)).

**Option B: AdGuard Home on another device.** Add the adblock links in AdGuard Home, then set your LAN's DHCP service
(**Services → ISC DHCPv4 → LAN**, or **Dnsmasq DNS & DHCP** / **Kea DHCP** on newer versions) to hand out the AdGuard
Home IP address as the DNS server, and reconnect your devices. (Community plugins can run AdGuard Home on OPNsense
itself, but they're not official.)

**Stop devices from going around it (both options):** **Firewall → NAT → Port Forward → +**: Interface *LAN*, Protocol
*TCP/UDP*, Destination tick **Destination / Invert** and choose *This Firewall*, Destination port *DNS*, Redirect target
IP *127.0.0.1* (Option B: the AdGuard Home IP), Redirect target port *DNS*, Filter rule association *Add associated
filter rule* → Save → Apply. Then **Firewall → Rules → LAN → +**: Action *Block*, Protocol *TCP/UDP*, Destination port
*853* → Save → Apply. Also add the `vpn-proxy-bypass` list.

**Block by IP (optional):** see the OPNsense steps under [Blocking by IP address](#blocking-by-ip-address-ips).

### OpenWrt

Menu names below are for the LuCI web interface (**http://192.168.1.1** by default). OpenWrt 25.12 and newer install
packages with `apk`; older versions use `opkg`.

**Option A: adblock-fast (light, recommended for most routers).**
1. Install it: **System → Software** → *Update lists* → search **luci-app-adblock-fast** → Install. Or over SSH:
   ```bash
   apk update && apk add luci-app-adblock-fast          # OpenWrt 25.12 and newer
   opkg update && opkg install luci-app-adblock-fast    # OpenWrt 24.10 and older
   ```
2. Reload the web page and open **Services → AdBlock-Fast**.
3. In the block-list URLs section (*Block-List URLs* / *File URLs*, depending on version), remove the default lists you
   don't want and **Add** one row per list with its plain link.
4. Turn on **Force Router DNS** (makes every device use the router for DNS) and the automatic list update, if your
   version offers it.
5. **Save & Apply**, then **Start** / **Restart** the service and check its status shows the domains loaded.

**Option B: AdGuard Home on the router (routers with 256 MB+ RAM and spare storage).**
```bash
apk update && apk add adguardhome          # OpenWrt 25.12 and newer
opkg update && opkg install adguardhome    # OpenWrt 24.10 and older
service adguardhome enable && service adguardhome start
```
Open **http://192.168.1.1:3000**, finish the setup wizard, and add the adblock links (see
[How to add a list](#how-to-add-a-list)). Follow the OpenWrt wiki's *AdGuard Home* page to make the router's DNS (dnsmasq)
forward to it, so every device is covered.

**Stop devices from going around it:** with adblock-fast, *Force Router DNS* (step 4) redirects normal DNS. For both
options, also add the `vpn-proxy-bypass` list: encrypted DNS (DoH/DoT) can't be redirected, only blocked.

**Block by IP (optional):** install **luci-app-banip** and add the [IP list](#blocking-by-ip-address-ips) links as
custom feeds.

### MikroTik

Commands below are typed in **New Terminal** (WinBox or WebFig) and need **RouterOS 7.15 or newer** (check with
`/system package update check-for-updates`). They assume MikroTik's default configuration, where the router is the DNS
server for your devices and the `LAN` interface list exists.

**Option A: DNS adlist (built in, recommended).**
1. Let the router answer DNS and give it room for the lists (adlist entries are kept in the DNS cache):
   ```
   /ip dns set allow-remote-requests=yes cache-size=65536KiB
   ```
   Use less on routers with little memory (check **System → Resources**): `ads-and-tracking` alone is about 280,000
   names. If the DNS log says the maximum cache size was reached, raise `cache-size` or use fewer lists.
2. Add each list with its **hosts** link:
   ```
   /ip dns adlist add url=https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-and-tracking.txt ssl-verify=no
   /ip dns adlist add url=https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/security.txt ssl-verify=no
   ```
   RouterOS checks the lists for updates every 4 hours by itself. `/ip dns adlist print` shows how many names each list
   loaded, and `/ip dns adlist reload` updates them right away.
3. If a site breaks, let it through with a forwarding entry, e.g. `/ip dns static add name=example.com type=FWD`
   (or permanently in [`allowlist.txt`](allowlist.txt)).

`ssl-verify=no` follows MikroTik's own example; with trusted root certificates installed on the router you can use
`ssl-verify=yes`.

**Option B: AdGuard Home on another device.** Add the adblock links in AdGuard Home, then hand it out as the DNS server:
`/ip dhcp-server network set [find] dns-server=192.168.88.2` (use your AdGuard Home's IP), and reconnect your devices.
(RouterOS can also run AdGuard Home in a *container* on models with enough storage; that's an advanced setup.)

**Stop devices from going around it (both options):**
```
/ip firewall nat add chain=dstnat in-interface-list=LAN protocol=udp dst-port=53 action=redirect to-ports=53 comment="Force DNS"
/ip firewall nat add chain=dstnat in-interface-list=LAN protocol=tcp dst-port=53 action=redirect to-ports=53 comment="Force DNS"
/ip firewall filter add chain=forward in-interface-list=LAN protocol=tcp dst-port=853 action=reject reject-with=tcp-reset comment="Block DNS-over-TLS"
```
(Option B: instead of `redirect`, use `action=dst-nat to-addresses=<AdGuard Home IP> to-ports=53`, and add
`src-address=!<AdGuard Home IP>` so AdGuard Home itself can still reach the internet.) Also add the `vpn-proxy-bypass`
list.

**Block by IP (optional):** load Bigo's network into an address list, block it, and refresh it daily:
```
/tool fetch url="https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-mikrotik.rsc" dst-path=live-streaming.rsc
/import file-name=live-streaming.rsc
/ip firewall filter add chain=forward dst-address-list=live-streaming action=drop comment="Block Bigo network"
/ipv6 firewall filter add chain=forward dst-address-list=live-streaming action=drop comment="Block Bigo network"
/system scheduler add name=update-live-streaming-ips interval=1d start-time=04:30:00 on-event="/tool fetch url=\"https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-mikrotik.rsc\" dst-path=live-streaming.rsc; :delay 5s; /import file-name=live-streaming.rsc"
```

### Ubiquiti EdgeRouter

For EdgeRouters running **EdgeOS 2.x** (ER-X, ER-X-SFP, ER-4, ER-6P, ER-8, ER-12...). For UniFi gateways, see
[UniFi Cloud Gateway](#unifi-cloud-gateway-ucg-ultra--max--fiber-udm-udr) instead. EdgeOS has no block-list feature of its
own, so [`install/edgerouter.sh`](install/edgerouter.sh) adds one: it downloads the lists you pick into `/config` (kept
across reboots and firmware upgrades), points the router's DNS service at them, and updates them every day through the
EdgeOS task scheduler.

**Before you start:** the router must be the DNS server for your devices. The *Basic Setup* wizard does this. To check,
log in over SSH and run `show configuration commands | match "dns forwarding"`: if nothing is printed, set it up
(`switch0` is the LAN on an ER-X; use `eth1` or your LAN interface on other models, and your own LAN addresses):
```
configure
set service dns forwarding listen-on switch0
set service dns forwarding cache-size 10000
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 dns-server 192.168.1.1
commit; save; exit
```

**Install:**
1. Log in over SSH from a terminal (macOS/Linux Terminal, or PowerShell on Windows): `ssh ubnt@192.168.1.1` (use your
   router's address and user).
2. Download and run the script, then pick lists from the menu:
   ```bash
   curl -fsSLO https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/install/edgerouter.sh
   sudo bash edgerouter.sh
   ```
3. That's it: the lists update daily. Later: `sudo bash /config/scripts/block-lists.sh --update` (refresh now),
   `sudo bash /config/scripts/block-lists.sh` (choose different lists) or `... --remove` (undo everything).

**Memory:** the router's DNS service needs roughly 100 MB per 500,000 names and the script warns when there isn't enough
free. On an ER-X (256 MB) start with `ads-and-tracking`, or with smaller lists; models with 1 GB+ (ER-4, ER-6P, ER-12)
handle much more.

**Option B: AdGuard Home on another device.** Instead of the script, add the adblock links in AdGuard Home and hand it out
as the DNS server (delete the old `dns-server` entry first):
```
configure
set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 dns-server <AdGuard Home IP>
commit; save; exit
```

**Stop devices from going around it:** send all DNS to the router, and block encrypted DNS (DNS-over-TLS). Replace
`switch0` and `192.168.1.1` with your LAN interface and router address (Option B: use the AdGuard Home IP as
`inside-address` and add it as an exception in `destination address`). If you already have a firewall named `LAN_IN`,
only add the rule.
```
configure
set service nat rule 1 type destination
set service nat rule 1 description "Force DNS"
set service nat rule 1 inbound-interface switch0
set service nat rule 1 protocol tcp_udp
set service nat rule 1 destination port 53
set service nat rule 1 destination address '!192.168.1.1'
set service nat rule 1 inside-address address 192.168.1.1
set service nat rule 1 inside-address port 53
set firewall name LAN_IN default-action accept
set firewall name LAN_IN rule 10 description "Block DNS-over-TLS"
set firewall name LAN_IN rule 10 action reject
set firewall name LAN_IN rule 10 protocol tcp
set firewall name LAN_IN rule 10 destination port 853
set interfaces switch0 firewall in name LAN_IN
commit; save; exit
```
Also add the `vpn-proxy-bypass` list.

**Block by IP (optional):** in `configure` mode paste the commands from
[`ips/live-streaming-edgeos.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-edgeos.txt) (they create the network group `live-streaming`),
then block it and save:
```
set firewall name LAN_IN rule 20 description "Block Bigo network"
set firewall name LAN_IN rule 20 action drop
set firewall name LAN_IN rule 20 destination group network-group live-streaming
commit; save; exit
```
Paste the file again now and then to pick up changes.

## Synology NAS

A Synology NAS is on all the time, which makes it a good home for **AdGuard Home** (or Pi-hole): it filters DNS for every
device in the house, and you then add these lists to it. This uses Synology's **Container Manager** (DSM 7.2 or newer, on
models that support it; older DSM calls it *Docker*).

### Step 1: prepare the NAS

1. Give the NAS a fixed IP address, so devices can always find it: **Control Panel → Network → Network Interface** →
   select your LAN → **Edit** → **IPv4** → *Use manual configuration* (or reserve its address in your router).
2. **Package Center** → install **Container Manager**.
3. **File Station** → open the `docker` shared folder (Container Manager creates it; otherwise **Control Panel → Shared
   Folder → Create** → `docker`) → create a folder `adguardhome`, and inside it `work` and `conf`.
4. Make sure nothing else uses port 53: if the **DNS Server** package is installed, stop or uninstall it.

### Step 2: run AdGuard Home

1. **Container Manager → Project → Create**. Project name `adguardhome`, Path `/docker/adguardhome`, Source *Create
   docker-compose.yml*, and paste:
   ```yaml
   services:
     adguardhome:
       image: adguard/adguardhome:latest
       container_name: adguardhome
       network_mode: host
       restart: unless-stopped
       volumes:
         - /volume1/docker/adguardhome/work:/opt/adguardhome/work
         - /volume1/docker/adguardhome/conf:/opt/adguardhome/conf
   ```
   (Change `/volume1` if your `docker` folder is on another volume.) → **Next** → **Done**. The container starts.
2. Open `http://<NAS IP>:3000` and follow the setup wizard. Keep the **DNS server** on port **53**; for the **admin web
   interface** keep port **3000** (DSM already uses 80, 443, 5000 and 5001). Create your username and password.
3. Add the lists you want ([How to add a list](#how-to-add-a-list)), using the adblock links.

**Pi-hole instead?** Use this compose file (Pi-hole v6; its web page is then at `http://<NAS IP>:8081/admin`):
```yaml
services:
  pihole:
    image: pihole/pihole:latest
    container_name: pihole
    restart: unless-stopped
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "8081:80/tcp"
    environment:
      TZ: "Europe/London"
      FTLCONF_webserver_api_password: "choose-a-password"
      FTLCONF_dns_listeningMode: "all"
    volumes:
      - /volume1/docker/pihole/etc-pihole:/etc/pihole
```
(Create the `pihole/etc-pihole` folders first, and set your own time zone and password.)

### Step 3: use it for the whole home

1. If the NAS firewall is on (**Control Panel → Security → Firewall**), allow **port 53 (TCP and UDP)** and the admin port
   (3000, or 8081 for Pi-hole) from your local network.
2. In your router's DHCP settings, set the **DNS server** to the NAS's IP address (UniFi:
   [Option 1](#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically); other routers: look for
   *DHCP* or *LAN* settings). Then reconnect your devices.
3. Stop devices from going around it with your router's firewall (see your router's section above) and the
   `vpn-proxy-bypass` list.
4. Updates: AdGuard Home / Pi-hole refresh the lists by themselves. To update AdGuard Home or Pi-hole itself, go to
   **Container Manager → Project** → select it → **Action → Build** (it pulls the latest image).

**Good to know:** while the NAS is off or restarting, DNS stops working at home unless your router has a second DNS
server; adding a public one as backup means some lookups will skip the block lists, so a second AdGuard Home / Pi-hole
(for example on a Raspberry Pi) is the better backup.

## Raspberry Pi

A Raspberry Pi is the classic way to run **Pi-hole** or **AdGuard Home** for the whole home: small, quiet and cheap to
leave on. Any Pi 3, 4, 5 or Zero 2 W works. Use a wired network cable if you can.

**How many lists fit:** a Pi with 512 MB (Zero 2 W, Pi 3) is fine with a few lists (roughly 500,000 names in total, e.g.
`ads-and-tracking` + `mobile-ads` + `smart-tv`); a Pi 4 or 5 with 2 GB or more handles the big combinations such as
`ads-and-tracking-extended` + `security` + `adult`.

### Step 1: set up the Pi

1. On your computer, install **Raspberry Pi Imager** from [raspberrypi.com/software](https://www.raspberrypi.com/software/).
2. Choose your Pi model, **Raspberry Pi OS Lite (64-bit)** and your microSD card. When asked about OS customisation,
   choose **Edit settings**: set a hostname (e.g. `blocker`), a username and password, your Wi-Fi if you won't use a cable,
   and on the **Services** tab tick **Enable SSH**. Write the card, put it in the Pi and power it on.
3. Give the Pi a fixed address: in your router, find the Pi in the list of connected devices and **reserve** its IP
   address (often called *DHCP reservation* or *fixed IP*). Note the address, e.g. `192.168.1.2`.
4. Log in from your computer's terminal (PowerShell on Windows): `ssh <username>@blocker.local` (or
   `ssh <username>@192.168.1.2`), then update it:
   ```bash
   sudo apt update && sudo apt full-upgrade -y
   ```

### Step 2: install AdGuard Home or Pi-hole

Pick one.

**AdGuard Home** (official installer):
```bash
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
```
Then open `http://192.168.1.2:3000` (your Pi's address) and follow the setup wizard: keep the DNS server on port 53,
choose the admin web port (80 is fine on a Pi) and create your username and password. Add lists under **Filters → DNS
blocklists** with the adblock links ([How to add a list](#how-to-add-a-list)).

**Pi-hole** (official installer):
```bash
curl -sSL https://install.pi-hole.net | bash
```
Answer the questions (the defaults are fine; choose any upstream DNS provider). Set the web password with
`sudo pihole setpassword`, then open `http://192.168.1.2/admin`. Add lists under **Lists** with the adblock links
(Pi-hole v6) and run **Tools → Update Gravity**.

### Step 3: use it for the whole home

1. In your router's DHCP / LAN settings, set the **DNS server** to the Pi's address, save, and reconnect your devices
   (turn Wi-Fi off and on). UniFi users: [Option 1](#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically).
2. **Router won't let you change DNS** (common on internet-provider routers)? Let the Pi hand out addresses instead:
   turn **off** DHCP on the router, then turn it **on** in AdGuard Home (**Settings → DHCP settings**) or Pi-hole
   (**Settings → DHCP**). Every device then gets the Pi as its DNS server automatically.
3. Stop devices from going around it with your router's firewall if it can (see the [router guides](#routers-pfsense-opnsense-openwrt-mikrotik-and-edgerouter))
   and the `vpn-proxy-bypass` list.
4. Check it works: the dashboard should show queries and blocked requests within a few minutes.

**Keeping it updated:** the lists update by themselves. Update the Pi now and then with
`sudo apt update && sudo apt full-upgrade -y`; update AdGuard Home from its web page when it offers a new version, or
Pi-hole with `pihole -up`.

**Good to know:** if the Pi is off, DNS stops working at home unless there's a second DNS server. A public DNS server as
backup would let some lookups skip the lists, so a second Pi (or the [Synology NAS](#synology-nas) setup) is the better
backup. To use the same blocking away from home on phones, see [iPhone and iPad](#iphone-and-ipad) and
[Android](#android).

## Docker

Run AdGuard Home or Pi-hole in Docker on any always-on computer: a Linux server or mini PC, or a NAS / home server with
Docker (Unraid, OpenMediaVault...). Proxmox users: see [Proxmox VE](#proxmox-ve); TrueNAS users: see [TrueNAS](#truenas). Ready-made files are in [`docker/`](docker/); they're tested
automatically on every change. (Synology users: see [Synology NAS](#synology-nas).)

### Step 1: free port 53 (Ubuntu and Debian servers)

DNS uses port 53. On Ubuntu (and some Debian setups) the built-in `systemd-resolved` already listens there, so the
container can't start ("address already in use"). Turn that listener off and let the server use AdGuard Home / Pi-hole
itself (AdGuard's documented fix):
```bash
sudo mkdir -p /etc/systemd/resolved.conf.d
printf '[Resolve]\nDNS=127.0.0.1\nDNSStubListener=no\n' | sudo tee /etc/systemd/resolved.conf.d/adguardhome.conf
sudo mv /etc/resolv.conf /etc/resolv.conf.backup
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo systemctl reload-or-restart systemd-resolved
```
Do this **after** step 2's `docker compose pull` (the server needs working DNS to download the image). Check nothing
else uses the port with `sudo ss -lunp | grep ':53 '`.

### Step 2: start AdGuard Home or Pi-hole

Install Docker first if needed ([docs.docker.com/engine/install](https://docs.docker.com/engine/install/), or
`curl -fsSL https://get.docker.com | sh` on most Linux systems). Then pick one:

**AdGuard Home**
```bash
mkdir -p ~/adguardhome && cd ~/adguardhome
curl -fsSLO https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/adguardhome/compose.yaml
docker compose pull
docker compose up -d
```
Open `http://<server IP>:3000`, follow the setup wizard (keep the admin web interface on port **3000** and the DNS server
on port **53**), and add the lists under **Filters → DNS blocklists** with the adblock links
([How to add a list](#how-to-add-a-list)).

**Pi-hole**
```bash
mkdir -p ~/pihole && cd ~/pihole
curl -fsSLO https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/pihole/compose.yaml
docker compose pull
PIHOLE_PASSWORD='choose-a-password' TZ='Europe/London' docker compose up -d
```
Open `http://<server IP>:8081/admin`, sign in, add the adblock links under **Lists**, then **Tools → Update Gravity**.

### Step 3: use it for the whole home

Follow [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home-1): set the server's IP as the DNS server in your router
(or let AdGuard Home / Pi-hole run DHCP), stop devices going around it, and check the dashboard. If the server has a
firewall, allow port 53 (TCP and UDP) and the admin port: `sudo ufw allow 53 && sudo ufw allow 3000/tcp` (Pi-hole:
`8081/tcp`).

**Updating:** the lists update themselves. To update AdGuard Home / Pi-hole, in its folder run
`docker compose pull && docker compose up -d`. Your settings are kept in the `work`/`conf` (or `etc-pihole`) folders
next to `compose.yaml`; back those up.

**Good to know**
- On Linux you can change AdGuard Home's file to `network_mode: host` (see the comment in it): it then sees each
  device's own address in the logs and can run DHCP. With the normal port mapping it still works for DNS.
- **Docker Desktop on Windows or macOS** is fine for trying it out, but the computer must stay on and its firewall must
  allow port 53 from your network; a small always-on device (Raspberry Pi, NAS) is better for the whole home.
- If the container stops, DNS at home stops too unless there's a second DNS server; `restart: unless-stopped` brings it
  back after a reboot.

## Proxmox VE

On a Proxmox server, run AdGuard Home or Pi-hole in a small **LXC container**: it uses about 512 MB of RAM and a few GB of
disk, starts in seconds and is easy to back up. Don't install them on the Proxmox host itself.

### Step 1: create the container

1. Download a template: in the left tree select your **storage (e.g. `local`)** → **CT Templates** → **Templates** →
   pick **debian-12-standard** (or debian-13-standard on Proxmox VE 9) → **Download**.
2. Click **Create CT** (top right) and fill in the tabs:
   - **General:** hostname (e.g. `adguard`), a root password, keep **Unprivileged container** ticked.
   - **Template:** the Debian template you downloaded.
   - **Disks:** 4–8 GB. **CPU:** 1 core. **Memory:** 512 MB (1024 MB or more for big lists such as `security` or
     `adult`), Swap 512 MB.
   - **Network:** bridge `vmbr0`, IPv4 **Static**, e.g. `192.168.1.3/24` with your router as **Gateway**
     (e.g. `192.168.1.1`). A fixed address matters: your devices will point at it.
   - **DNS:** leave as *use host settings*. **Confirm:** tick **Start after created** → **Finish**.
3. Select the new container → **Options** → **Start at boot**: *Yes* (and set **Start/Shutdown order** to `1`, so DNS is
   up before other guests).

### Step 2: install AdGuard Home or Pi-hole

Select the container → **Console**, log in as `root`, then update it and install `curl`:
```bash
apt update && apt full-upgrade -y && apt install -y curl
```
Then run the official installer of the one you want, exactly as on a Raspberry Pi
([Raspberry Pi, step 2](#step-2-install-adguard-home-or-pi-hole)):
```bash
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v   # AdGuard Home
curl -sSL https://install.pi-hole.net | bash                                                                    # or Pi-hole
```
AdGuard Home: open `http://192.168.1.3:3000` (your container's address) and follow the wizard. Pi-hole: set the password
with `pihole setpassword`, then open `http://192.168.1.3/admin`. Add the lists with the adblock links
([How to add a list](#how-to-add-a-list)).

**Prefer Docker?** Create a Debian VM (or a container with **Options → Features → nesting** turned on), install Docker and
follow the [Docker](#docker) guide. **Prefer a one-click script?** The community
[Proxmox VE Helper-Scripts](https://community-scripts.github.io/ProxmoxVE/) can create an AdGuard Home or Pi-hole container
for you; they're not official, so read a script before running it on your host.

### Step 3: use it for the whole home, and keep it safe

1. Point your network at it: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home-1) (router DNS or AdGuard Home /
   Pi-hole as DHCP server, stopping devices going around it, checking the dashboard).
2. **Backups:** **Datacenter → Backup → Add**: select the container, schedule daily or weekly. Before updating, take a
   **Snapshot** (container → *Snapshots*) so you can roll back in one click.
3. **Updates:** the lists update themselves. Update the container now and then with
   `apt update && apt full-upgrade -y`; update AdGuard Home from its web page, or Pi-hole with `pihole -up`.
4. **No single point of failure:** if the Proxmox server is off, home DNS stops. Create a second container (ideally on
   another Proxmox node, a Raspberry Pi or a NAS) with the same lists and give its address to your router as the second
   DNS server. AdGuard Home can copy settings between the two with community sync tools; with Pi-hole, use
   *Settings → Teleporter* to export and import.

## TrueNAS

For **TrueNAS Community Edition / SCALE 24.10 or newer** (the Linux-based TrueNAS, whose Apps run on Docker). TrueNAS CORE
(FreeBSD) isn't covered: use another device or a VM. Menu names below are from 25.04 / 25.10 and may move between
releases.

### Step 1: prepare TrueNAS

1. Make sure TrueNAS has a fixed IP address (it usually does; check **Network → Interfaces**, or reserve its address in
   your router). Below it's `192.168.1.4`.
2. Apps need a pool: open **Apps**; if asked, **Configure → Choose Pool**.
3. Optional, to keep the settings in your own dataset: **Datasets → Add Dataset** → e.g. `apps/adguardhome` (or
   `apps/pihole`).

### Step 2: install AdGuard Home or Pi-hole from the Apps catalogue

1. **Apps → Discover Apps** → search **AdGuard Home** (or **Pi-hole**) → **Install**.
2. In the install form:
   - **Network Configuration:** turn on **Host Network** and, under **Host IPs**, choose your TrueNAS LAN address
     (`192.168.1.4`) rather than *0.0.0.0*. This avoids the port 53 clash described below. Keep the suggested **Web
     Port** (TrueNAS itself uses 80 and 443).
   - **Pi-hole only:** set the admin **password** and your **time zone**.
   - **Storage:** keep the default *ixVolume*, or choose **Host Path** and the dataset from step 1.
   - Click **Install** and wait until the app shows **Running**.
3. Click **Web UI** on the app's page.
   - AdGuard Home: if the setup wizard appears, keep the DNS server on port **53** and the admin port the same as the
     app's Web Port, then create your username and password.
   - Pi-hole: sign in with the password from the form.
4. Add the lists with the adblock links ([How to add a list](#how-to-add-a-list)).

**"Port 53 is already in use" / "used by Virt Service"?** On TrueNAS 25.04 and newer, the built-in containers & VMs
service (**Instances**, based on Incus) keeps its own DNS on port 53. Fixes, in order:
1. Bind the app to your TrueNAS LAN address with Host Network (step 2 above), then **Edit** and save the app again.
2. If you don't use Instances / VMs, unset their pool (**Instances → Configuration**) so the service stops.
3. Last resort (community workaround, not tested by TrueNAS): move the Incus DNS to another port from **System → Shell**:
   `sudo incus network set incusbr0 raw.dnsmasq="port=5354"`.
Check what holds the port with `sudo ss -lunp | grep ':53 '`.

**Prefer our compose file?** **Apps → Discover Apps → ⋮ → Install via YAML**, give it a name and paste
[`docker/adguardhome/compose.yaml`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/adguardhome/compose.yaml), replacing `./work` and `./conf` with full
paths such as `/mnt/<pool>/apps/adguardhome/work`. The port 53 notes above apply here too.

### Step 3: use it for the whole home

1. Point your network at it: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home-1) (router DNS or AdGuard Home /
   Pi-hole as DHCP server, stopping devices going around it). Then from a computer run
   `nslookup example.com 192.168.1.4` to confirm it answers.
2. **Updates:** the lists update themselves; when **Apps → Installed** shows *Update available* for the app, click
   **Update**.
3. **Backups:** take snapshots of the app's dataset (**Data Protection → Periodic Snapshot Tasks**), and keep a second
   DNS server (a Raspberry Pi or another NAS) so home DNS keeps working when TrueNAS restarts for updates.

## Smart TVs and streaming sticks

Smart TVs (Samsung, LG, Sony, TCL, Hisense, Vizio, Philips) and streaming sticks (Roku, Fire TV, Chromecast / Google TV,
Apple TV) show ads on their home screens and report what you watch. TVs can't run our scripts, so block at the network
and turn off tracking in the TV's own settings. Do both: the settings stop the TV collecting data, the block list stops
what it still tries to send.

### Step 1: block the TV's ad and tracking servers

Add these lists to the DNS blocker your TV uses:
- [`smart-tv`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/smart-tv.txt): tracking and ads of Samsung, LG webOS, Roku, Amazon Fire TV, Android/Google TV
  and game consoles (for consoles see [Game consoles](#game-consoles)).
- [`ads-and-tracking`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking.txt): ads inside free TV apps and ad-supported channels.
- Optional: [`youtube-ads`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/youtube-ads.txt) (blocks some ad tracking; see the YouTube note above).

Where to add them, from best to simplest:
1. **AdGuard Home or Pi-hole on your network** (see [How to add a list](#how-to-add-a-list)). Every TV, stick and console
   in the house is covered. On UniFi, follow [Option 1](#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically).
2. **Only the TV:** in the TV's network settings, change DNS from automatic to manual and enter your AdGuard Home /
   Pi-hole IP address. The path is usually **Settings → Network (or General → Network) → Network status / Advanced /
   IP settings → DNS → Manual**.
3. **No blocker at home:** enter AdGuard's free public ad-blocking DNS on the TV (`94.140.14.14` and `94.140.15.15`). It
   doesn't use these lists, but blocks common ads and trackers with no setup.
4. **UniFi without AdGuard Home:** upload [`unifi/smart-tv.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/unifi/smart-tv.txt) as in
   [Option 2](#option-2-unifi-only-no-extra-device-manual-updates).

### Step 2: turn off viewing data and ad tracking on the TV

Menu names differ between models and years; if a path doesn't match, search the TV's settings for *viewing information*,
*privacy*, *ads* or *advertising*.

| Brand | What to turn off |
|---|---|
| **Samsung** (Tizen) | Settings → General & Privacy (or Support) → Terms & Privacy → Privacy Choices: turn off **Viewing Information Services**, **Interest-Based Advertisement** and **Voice Recognition Services** |
| **LG** (webOS) | Settings → All Settings → General (or Support) → System → Additional Settings: turn off **Live Plus**; under User Agreements, untick **Viewing Information** and **Interest-Based Recommendations** |
| **Roku** (and Roku TVs from TCL, Hisense...) | Settings → Privacy → Smart TV Experience: untick **Use info from TV inputs**; Settings → Privacy → Advertising: tick **Limit ad tracking** |
| **Google TV / Android TV** (Sony, TCL, Hisense, Philips, Chromecast) | Settings → Privacy → Ads: **Delete advertising ID** / opt out of personalised ads; Settings → Privacy → Usage & Diagnostics: **Off**. On Sony, also turn off **Samba Interactive TV** if it's listed |
| **Amazon Fire TV** | Settings → Preferences → Privacy Settings: turn off **Device Usage Data**, **Collect App Usage Data** and **Interest-based Ads**; Settings → Preferences → **Data Monitoring**: Off |
| **Vizio** | Settings → Admin & Privacy (or System → Reset & Admin) → **Viewing Data**: Off |
| **Apple TV** | Settings → General → Privacy & Security: turn off **Analytics** sharing and **Personalized Ads** under Apple Advertising |

### Step 3: stop devices that ignore your DNS

Some devices use Google's DNS (`8.8.8.8`) directly instead of the one your router gives them; Chromecast and many
Google TV / Android TV models do this. Block outgoing DNS (port 53 and 853) on your router for everything except your
AdGuard Home / Pi-hole: the device then falls back to your blocker. On UniFi this is
[Option 1, step 3](#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically); on other routers look
for firewall rules or "DNS redirect". Add the `vpn-proxy-bypass` list too, so encrypted-DNS servers are blocked as well.

### What to expect

- **Gone or reduced:** viewing-data reporting, home-screen ad banners and sponsored rows on many models, tracking in
  free apps and ad-supported channels.
- **Not blockable by DNS:** ads inside YouTube, Netflix, Prime Video, Disney+ and similar apps (they come from the same
  servers as the shows), and ads the TV maker serves from the same servers as essential features.
- **If something breaks** (the home screen won't load, an app or a free channel stops working, updates fail): open your
  AdGuard Home / Pi-hole **query log**, filter by the TV's IP address, find the blocked name that appeared when it
  broke, and allow it (in AdGuard Home / Pi-hole right away, or permanently in [`allowlist.txt`](allowlist.txt)).
  Samsung TV Plus, LG Channels and The Roku Channel are free channels paid for by ads; they may stop playing when their
  ad servers are blocked.

## Game consoles

PlayStation, Xbox and Nintendo Switch show ads and sponsored tiles in their menus and send play data ("telemetry") back
to Sony, Microsoft and Nintendo. Consoles can't run our scripts either, so the setup is like the smart TV one: block at
the network, then turn tracking off in the console's settings.

### Step 1: block console ads and telemetry

Add these lists to the DNS blocker your console uses:
- [`game-consoles`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/game-consoles.txt): menu ads (PlayStation, Xbox) and telemetry (PlayStation, Nintendo
  Switch, Xbox error reporting). Small on purpose so sign-in, the store, updates and online play keep working.
- [`ads-and-tracking`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking.txt): ads and trackers in the console's web browser, media apps
  and free-to-play games.

Where to add them:
1. **AdGuard Home or Pi-hole on your network** (see [How to add a list](#how-to-add-a-list)); on UniFi follow
   [Option 1](#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically). Covers every console at home.
2. **Only the console:** set its DNS to your AdGuard Home / Pi-hole IP address (or AdGuard's free public DNS,
   `94.140.14.14` and `94.140.15.15`, if you have no blocker; it doesn't use these lists):
   - **PlayStation 5:** Settings → Network → Settings → Set Up Internet Connection → highlight your network → press
     Options → Advanced Settings → DNS Settings: **Manual**.
   - **Xbox Series X|S / One:** Settings → General → Network settings → Advanced settings → DNS settings: **Manual**.
   - **Nintendo Switch:** System Settings → Internet → Internet Settings → choose your network → Change Settings →
     DNS Settings: **Manual**.
3. **UniFi without AdGuard Home:** upload [`unifi/game-consoles.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/unifi/game-consoles.txt) as in
   [Option 2](#option-2-unifi-only-no-extra-device-manual-updates).

### Step 2: turn off tracking and ads in the console's settings

Menu names change with system updates; if a path doesn't match, look for *privacy*, *data*, *diagnostics* or *ads*.

| Console | What to change |
|---|---|
| **PlayStation 5** | Settings → Users and Accounts → Privacy: set **Data You Provide** to **Limited**, and turn off personalised recommendations and ads under **Personalization** |
| **Xbox** | Settings → Account → Privacy & online safety: share only **required** diagnostic data. Personalised ads are set on your Microsoft account at [account.microsoft.com/privacy/ad-settings](https://account.microsoft.com/privacy/ad-settings) |
| **Nintendo Switch** | Lock-screen eShop ads: System Settings → System → News Channel Settings → Nintendo News → **Unfollow**. Marketing use of your data: your Nintendo Account settings at [accounts.nintendo.com](https://accounts.nintendo.com) |

### What to expect

- **Gone:** sponsored tiles in the Xbox and PlayStation menus, console telemetry and error reports, trackers in the
  console browser and media apps.
- **Still there:** ads that are part of a game itself (in-game billboards, free-to-play shop offers) and the consoles'
  own store pages, which come from the same servers as purchases and downloads.
- **On Xbox,** `game-consoles` also hides **Game Pass Perks** (they use the same server as the sponsored tiles). Allow
  `rad.msn.com` if you want Perks back.
- **Avoid the aggressive lists on consoles.** `ads-and-tracking-extended`, `gaming-platforms` and `online-games` are
  meant for blocking or limiting gaming, and can break sign-in, achievements, party chat or game downloads. Use them on
  consoles only if that's what you want (for example on a child's console with time limits).
- DNS blocking doesn't change your **NAT type**, ping or download speed.
- **If something breaks:** open the AdGuard Home / Pi-hole query log, filter by the console's IP address, find the
  blocked name from when it broke and allow it (right away in the blocker, or permanently in
  [`allowlist.txt`](allowlist.txt)).

## Something broke?

Add the domain to [`allowlist.txt`](allowlist.txt). It will be removed from every list on the next build.
You can also allow it right away in Pi-hole/AdGuard Home.

Essential sites (Google, Microsoft, Apple, WhatsApp, PayPal, big CDNs, common link shorteners...) are listed in
[`protected.txt`](protected.txt). Every build removes them from all lists automatically, unless a list is meant to block
them (set with `may_block` in `lists.json`, e.g. `social-media` may block Facebook). This stops a mistake in an upstream
source from breaking those sites.

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

Many sources come from the same catalogue AdGuard Home offers by default ([HostlistsRegistry](https://github.com/AdguardTeam/HostlistsRegistry)):
its filter lists, the rules behind its **Blocked services** switches, and the DNS-compatible ad/tracking-server sections of
[AdguardFilters](https://github.com/AdguardTeam/AdguardFilters) (including regional ones).

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

## Adding a new list or source

1. Add the source to [`sources.json`](sources.json) (`name`, `url` or a repo `path`, `home`, `license`, and optionally `exclude` regexes).
2. Add or edit the list in [`lists.json`](lists.json) (`title`, `description`, `sources`).
3. Push. The Action builds the new list in all three formats and adds it to the tables above automatically.
