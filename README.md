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
- **Windows** (PowerShell): see [Windows 10 / 11](#windows-10--11); on Windows choose smaller lists, or run
  [AdGuard Home on the PC](#adguard-home-on-a-windows-or-mac-computer) for the big ones.

**3. Protect every device at home** (about 30 minutes). Run AdGuard Home or Pi-hole on an always-on device, add the two
links from step 1, and point your router at it:
[Raspberry Pi](#raspberry-pi) · [Docker](#docker) · [Synology](#synology-nas) · [other NAS / servers](#choose-your-setup)
· then your [router](#routers).

**4. Phones:** Android without root: the free [AdAway app](#android). iPhone / iPad: [use your home blocker or the
AdGuard app](#iphone-and-ipad).

Then check it worked with [Is it working?](#is-it-working). More lists (adult content, gambling, social media, kids'
apps...) are in [Lists](#lists) and [Suggested setups](#suggested-setups).

## Contents

<!-- TOC:START -->
- [Quick start](#quick-start)
- [Choose your setup](#choose-your-setup)
- [Lists](#lists)
  - [Suggested setups](#suggested-setups)
- [What each list blocks (and what it doesn't)](#what-each-list-blocks-and-what-it-doesnt)
- [How to add a list](#how-to-add-a-list)
- [Use on one device, without Pi-hole or AdGuard Home](#use-on-one-device-without-pi-hole-or-adguard-home)
  - [macOS](#macos)
  - [Windows 10 / 11](#windows-10--11)
  - [Linux](#linux)
  - [Android](#android)
  - [iPhone and iPad](#iphone-and-ipad)
  - [Chromebook](#chromebook)
- [YouTube ads in the browser](#youtube-ads-in-the-browser)
- [Blocking by IP address (ips/)](#blocking-by-ip-address-ips)
- [UniFi Cloud Gateway (UCG Ultra / Max / Fiber, UDM, UDR)](#unifi-cloud-gateway-ucg-ultra--max--fiber-udm-udr)
  - [Option 1 (recommended): UniFi + AdGuard Home or Pi-hole, updates automatically](#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically)
  - [Option 2: UniFi only, no extra device (manual updates)](#option-2-unifi-only-no-extra-device-manual-updates)
- [Routers](#routers)
  - [pfSense](#pfsense)
  - [OPNsense](#opnsense)
  - [OpenWrt](#openwrt)
  - [MikroTik](#mikrotik)
  - [Ubiquiti EdgeRouter](#ubiquiti-edgerouter)
  - [GL.iNet](#glinet)
  - [Asus](#asus)
  - [Any other router (TP-Link, Netgear, Fritz!Box, internet-provider routers)](#any-other-router-tp-link-netgear-fritzbox-internet-provider-routers)
  - [Mesh Wi-Fi (eero, Google Nest Wifi, Deco, Orbi, Velop)](#mesh-wi-fi-eero-google-nest-wifi-deco-orbi-velop)
  - [Starlink, 4G and 5G home routers](#starlink-4g-and-5g-home-routers)
  - [TP-Link Omada and other business gateways](#tp-link-omada-and-other-business-gateways)
- [Synology NAS](#synology-nas)
  - [Step 1: prepare the NAS](#step-1-prepare-the-nas)
  - [Step 2: run AdGuard Home](#step-2-run-adguard-home)
  - [Step 3: use it for the whole home](#step-3-use-it-for-the-whole-home)
- [Raspberry Pi](#raspberry-pi)
  - [Step 1: set up the Pi](#step-1-set-up-the-pi)
  - [Step 2: install AdGuard Home or Pi-hole](#step-2-install-adguard-home-or-pi-hole)
  - [Step 3: use it for the whole home](#step-3-use-it-for-the-whole-home-1)
- [Docker](#docker)
  - [Step 1: install Docker and download AdGuard Home or Pi-hole](#step-1-install-docker-and-download-adguard-home-or-pi-hole)
  - [Step 2: free port 53 (Ubuntu and Debian servers)](#step-2-free-port-53-ubuntu-and-debian-servers)
  - [Step 3: start it](#step-3-start-it)
  - [Step 4: use it for the whole home](#step-4-use-it-for-the-whole-home)
- [Proxmox VE](#proxmox-ve)
  - [Step 1: create the container](#step-1-create-the-container)
  - [Step 2: install AdGuard Home or Pi-hole](#step-2-install-adguard-home-or-pi-hole-1)
  - [Step 3: use it for the whole home, and keep it safe](#step-3-use-it-for-the-whole-home-and-keep-it-safe)
- [TrueNAS](#truenas)
  - [Step 1: prepare TrueNAS](#step-1-prepare-truenas)
  - [Step 2: install AdGuard Home or Pi-hole from the Apps catalogue](#step-2-install-adguard-home-or-pi-hole-from-the-apps-catalogue)
  - [Step 3: use it for the whole home](#step-3-use-it-for-the-whole-home-2)
- [Unraid](#unraid)
  - [Step 1: install the container](#step-1-install-the-container)
  - [Step 2: set it up](#step-2-set-it-up)
  - [Step 3: use it for the whole home](#step-3-use-it-for-the-whole-home-3)
- [OpenMediaVault](#openmediavault)
  - [Step 1: install omv-extras and the Compose plugin](#step-1-install-omv-extras-and-the-compose-plugin)
  - [Step 2: add AdGuard Home or Pi-hole](#step-2-add-adguard-home-or-pi-hole)
  - [Step 3: use it for the whole home](#step-3-use-it-for-the-whole-home-4)
- [QNAP NAS](#qnap-nas)
- [Home Assistant](#home-assistant)
- [Away from home](#away-from-home)
  - [Option A: Tailscale (easiest, free for personal use)](#option-a-tailscale-easiest-free-for-personal-use)
  - [Option B: encrypted DNS from AdGuard Home](#option-b-encrypted-dns-from-adguard-home)
- [AdGuard Home on a Windows or Mac computer](#adguard-home-on-a-windows-or-mac-computer)
- [Technitium DNS Server](#technitium-dns-server)
- [Smart TVs and streaming sticks](#smart-tvs-and-streaming-sticks)
  - [Step 1: block the TV's ad and tracking servers](#step-1-block-the-tvs-ad-and-tracking-servers)
  - [Step 2: turn off viewing data and ad tracking on the TV](#step-2-turn-off-viewing-data-and-ad-tracking-on-the-tv)
  - [Step 3: stop devices that ignore your DNS](#step-3-stop-devices-that-ignore-your-dns)
  - [What to expect](#what-to-expect)
- [Game consoles](#game-consoles)
  - [Step 1: block console ads and telemetry](#step-1-block-console-ads-and-telemetry)
  - [Step 2: turn off tracking and ads in the console's settings](#step-2-turn-off-tracking-and-ads-in-the-consoles-settings)
  - [What to expect](#what-to-expect-1)
- [Is it working?](#is-it-working)
- [Troubleshooting FAQ](#troubleshooting-faq)
- [Something broke?](#something-broke)
- [Changelog](#changelog)
- [Sources](#sources)
- [For maintainers](#for-maintainers)
  - [Adding your own domains](#adding-your-own-domains)
  - [How it updates](#how-it-updates)
  - [Adding a new list or source](#adding-a-new-list-or-source)
<!-- TOC:END -->

## Choose your setup

| You have... | Go to |
|---|---|
| AdGuard Home or Pi-hole already | [Lists](#lists) and [How to add a list](#how-to-add-a-list) |
| Nothing yet, and want the whole home protected | a [Raspberry Pi](#raspberry-pi), or your [NAS / server](#docker), then your [router](#routers) |
| A NAS or home server | [Synology](#synology-nas), [QNAP](#qnap-nas), [TrueNAS](#truenas), [Unraid](#unraid), [OpenMediaVault](#openmediavault), [Proxmox VE](#proxmox-ve), [Home Assistant](#home-assistant), any [Docker](#docker) host |
| A router that can block by itself | [pfSense](#pfsense), [OPNsense](#opnsense), [OpenWrt](#openwrt), [MikroTik](#mikrotik), [EdgeRouter](#ubiquiti-edgerouter), [GL.iNet](#glinet), [UniFi](#unifi-cloud-gateway-ucg-ultra--max--fiber-udm-udr) |
| Another router (Asus, TP-Link, Netgear, Fritz!Box, internet provider) | [Asus](#asus), [Any other router](#any-other-router-tp-link-netgear-fritzbox-internet-provider-routers), [Mesh Wi-Fi](#mesh-wi-fi-eero-google-nest-wifi-deco-orbi-velop), [Starlink / 4G / 5G](#starlink-4g-and-5g-home-routers), [Omada](#tp-link-omada-and-other-business-gateways), plus a blocker from the rows above |
| Blocking doesn't seem to work | [Is it working?](#is-it-working) and [Troubleshooting FAQ](#troubleshooting-faq) |
| Not sure which lists to pick | [What each list blocks](#what-each-list-blocks-and-what-it-doesnt) and [Suggested setups](#suggested-setups) |
| Just one computer or phone | [macOS, Windows, Linux, Android, iPhone, Chromebook](#use-on-one-device-without-pi-hole-or-adguard-home) |
| Phones and laptops away from home | [Away from home](#away-from-home) |
| Only a Windows or Mac computer to run a blocker on | [AdGuard Home on a Windows or Mac computer](#adguard-home-on-a-windows-or-mac-computer), or [Technitium DNS Server](#technitium-dns-server) |
| YouTube ads | [YouTube ads in the browser](#youtube-ads-in-the-browser) |
| Smart TVs, streaming sticks, consoles | [Smart TVs](#smart-tvs-and-streaming-sticks), [Game consoles](#game-consoles) |
| Kids' devices, parental controls | [Suggested setups](#suggested-setups) (Kids / family) |

## Lists

The table below and the Sources table are updated automatically on every build.

<!-- LISTS:START -->
| List | What it blocks | Domains | Download |
|---|---|---|---|
| `ads-and-tracking` | Ads and trackers with few false positives. Start here. | ~279k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-and-tracking.txt) |
| `ads-and-tracking-extended` | Aggressive ad, tracker, telemetry and pop-up blocking. Contains everything in `ads-and-tracking` plus much more; may need occasional allowlisting. | ~736k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking-extended.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking-extended.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-and-tracking-extended.txt) |
| `ads-regional` | Ad servers for non-English websites and apps: Arabic, Chinese, Russian/Ukrainian/Bulgarian, Turkish, Persian, Hebrew, Japanese, Korean, Vietnamese, Indonesian, European languages and more. Add next to `ads-and-tracking` or the extended list. | ~233k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-regional.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-regional.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ads-regional.txt) |
| `mobile-ads` | Ad networks used inside Android and iOS apps. | ~8.3k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/mobile-ads.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/mobile-ads.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/mobile-ads.txt) |
| `mobile-spyware` | Phone-maker and app telemetry/tracking (Apple, Samsung, Xiaomi, Huawei, Oppo/Realme, Vivo, TikTok) plus Android trackers. | ~3.2k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/mobile-spyware.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/mobile-spyware.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/mobile-spyware.txt) |
| `youtube-ads` | Google/YouTube ad servers. Partial: DNS cannot block all YouTube video ads (see note below). | 22 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/youtube-ads.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/youtube-ads.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/youtube-ads.txt) |
| `gambling` | Online casinos, sports betting, poker, lotteries and other gambling sites. | ~584k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/gambling.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/gambling.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/gambling.txt) |
| `adult` | Porn and other adult (NSFW) sites (see Safe Search tip below). | ~527k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/adult.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adult.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/adult.txt) |
| `social-media` | Social networks: Facebook, Instagram, TikTok, X/Twitter, Snapchat, Reddit, LinkedIn, Pinterest, Tumblr, Threads, Bluesky, Discord and more. WhatsApp is not blocked. | ~4.5k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/social-media.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/social-media.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/social-media.txt) |
| `smart-tv` | Tracking and ads on smart TVs, streaming sticks and game consoles (Samsung, LG webOS, Roku, Amazon Fire, PlayStation, Xbox, Nintendo). | ~1.4k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/smart-tv.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/smart-tv.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/smart-tv.txt) |
| `game-consoles` | Ads in the system menus and telemetry of PlayStation, Xbox and Nintendo Switch consoles. Small and safe for online play (on Xbox it also hides Game Pass Perks). | 13 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/game-consoles.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/game-consoles.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/game-consoles.txt) |
| `security` | Malware, phishing, scams and fake shops from threat-intelligence feeds. Recommended for everyone (add `phishing-and-scams` for extra phishing feeds). | ~792k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/security.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/security.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/security.txt) |
| `stalkerware` | Spy and monitoring apps that can be secretly installed on a phone to track messages and location. Also blocks parental-control apps such as Bark, so don't use it if you rely on one. | 949 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/stalkerware.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/stalkerware.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/stalkerware.txt) |
| `crypto-mining` | Hidden crypto-mining scripts and mining pools (cryptojacking). Exchanges like Coinbase/Binance are not blocked. | ~12k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/crypto-mining.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/crypto-mining.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/crypto-mining.txt) |
| `phishing-and-scams` | Phishing sites (fake bank, PayPal, Microsoft and delivery logins), scams and fake shops, from extra phishing feeds. Only partly covered by `security`: add both for the strongest phishing protection. | ~564k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/phishing-and-scams.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/phishing-and-scams.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/phishing-and-scams.txt) |
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
| **Older or less tech-savvy relatives** | `ads-and-tracking`, `security`, `phishing-and-scams`, `security-strict`, `remote-control`, `crypto-trading` |
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

## What each list blocks (and what it doesn't)

**No single list blocks everything, on purpose.** Each list has one job, so you choose exactly what to block. Turning on
all of them would also block YouTube, WhatsApp, Netflix, shopping, Dropbox and more. The lists come in three kinds:

| Kind | Lists | Who should use them |
|---|---|---|
| **Protection**: ads, trackers, threats | `ads-and-tracking`, `ads-and-tracking-extended`, `ads-regional`, `mobile-ads`, `mobile-spyware`, `youtube-ads`, `smart-tv`, `game-consoles`, `windows-telemetry`, `security`, `phishing-and-scams`, `security-strict`, `crypto-mining`, `stalkerware` | Everyone; normal sites and apps keep working |
| **Content filters**: unwanted content | `adult`, `safesearch-bypass`, `gambling`, `dating`, `live-streaming`, `chat-strangers`, `drugs`, `violence-hate`, `piracy`, `fake-news`, `cults`, `vpn-proxy-bypass` | Families, children's devices, workplaces |
| **Service blockers**: switch whole services off | `social-media`, `messaging`, `youtube`, `video-streaming`, `gaming-platforms`, `online-games`, `ai-chatbots`, `cheating`, `shopping`, `file-sharing`, `crypto-trading`, `remote-control`, `url-shorteners` | Only where you want those services gone (e.g. bedtime, homework, a relative's PC) |

**Which lists contain others** (measured on the current lists):
- `ads-and-tracking-extended` contains **all** of `ads-and-tracking` (guaranteed), and 94–98% of `mobile-ads`,
  `mobile-spyware`, `ads-regional`, `smart-tv` and `windows-telemetry`. With the extended list, those add little.
- `smart-tv` contains all of `game-consoles`.
- `online-games` contains ~93% of `gaming-platforms`, plus thousands of browser-game sites.
- `security` and `phishing-and-scams` overlap only partly (about a third of `phishing-and-scams` is in `security`): add
  both for the strongest phishing protection.
- `security-strict`, `crypto-mining`, `stalkerware` and `url-shorteners` are almost entirely separate from `security`:
  each adds something new.
- `youtube-ads` and `youtube` are different: `youtube-ads` blocks Google's ad servers and keeps YouTube working;
  `youtube` blocks YouTube itself.

**Per list: what's blocked, and what's deliberately left working**

| List | Blocks | Leaves working / doesn't block |
|---|---|---|
| `ads-and-tracking` | Ad and tracking servers on websites and apps | The sites and apps themselves; Google's sponsored search links; [essential sites](#something-broke) |
| `ads-and-tracking-extended` | Everything above, plus telemetry, pop-ups and push-notification spam | Same; may block some tracked email or shopping links (fix: [referral allowlist](#is-it-working)) |
| `ads-regional` | Ad servers of non-English sites and apps | Non-English sites themselves (Baidu, Yandex, Naver, Trendyol, Shahid... stay reachable) |
| `mobile-ads` | In-app ad networks | The apps themselves |
| `mobile-spyware` | Phone-maker and app telemetry | Phone updates, app stores, sign-in |
| `youtube-ads` | Google/YouTube ad servers | YouTube itself; most video ads still play ([why](#lists)) |
| `smart-tv` | TV and streaming-stick tracking and ads (includes `game-consoles`) | Streaming apps, TV updates; ad-supported free channels may stop |
| `game-consoles` | Console menu ads and telemetry | Sign-in, store, updates, online play; Xbox Game Pass Perks are hidden |
| `windows-telemetry` | Windows and Office data collection | Windows Update, Office, Microsoft sign-in |
| `security` | Malware, phishing, scams, fake shops | Normal sites; whole link-shortener and file-hosting services (see `url-shorteners`, `file-sharing`) |
| `phishing-and-scams` | Extra phishing and scam feeds | Google, Microsoft, Apple, PayPal and other big-company sites |
| `security-strict` | Spam-heavy domain endings (`.zip`, `.mov`...), dynamic DNS, abused free hosting, bandwidth-reselling apps | Known legitimate sites on those endings; may still block a few small legitimate sites |
| `crypto-mining` | Hidden crypto-mining scripts and pools | Exchanges and wallets (see `crypto-trading`) |
| `stalkerware` | Spy and monitoring apps | Nothing exempt: also blocks parental-control apps such as Bark |
| `adult` | Porn and adult sites | Explicit images in search results: add `safesearch-bypass` and turn on Safe Search |
| `safesearch-bypass` | Search engines that can't enforce SafeSearch | Google, Bing, DuckDuckGo (they support SafeSearch) |
| `gambling`, `dating`, `drugs`, `violence-hate`, `piracy`, `fake-news`, `cults` | Sites of that kind | Everything else; WhatsApp and messaging stay working |
| `live-streaming` | Bigo, Likee, MICO, Chamet and ~45 paid live/video-chat apps | YouTube, TikTok, Twitch (see `youtube`, `social-media`, `video-streaming`) |
| `chat-strangers` | Omegle-style random chat sites | Normal messaging apps |
| `vpn-proxy-bypass` | VPNs, web proxies, encrypted DNS used to get around blocking | Nothing exempt: may block a work VPN or iCloud Private Relay |
| `social-media` | Facebook, Instagram, TikTok, X, Snapchat, Reddit, Discord... | **WhatsApp** (see `messaging`) |
| `messaging` | WhatsApp, Telegram, Discord, Signal, Viber, LINE, WeChat... (chats and calls) | Email, SMS and normal phone calls |
| `youtube` | All of YouTube, YouTube Kids and embedded videos | Other video sites (see `video-streaming`) |
| `video-streaming` | Netflix, Disney+, Prime Video, Shahid, Twitch... | YouTube (see `youtube`) |
| `gaming-platforms` | Roblox, Fortnite, Steam, Xbox, PlayStation, Nintendo, PUBG, Free Fire... | Browser game sites (see `online-games`) |
| `online-games` | Online and browser game sites, including Steam, Roblox and Epic | App Store website and other big-company sites |
| `ai-chatbots`, `cheating` | AI chatbots; homework-answer and essay sites | Normal search and learning sites (Wikipedia, Khan Academy...) |
| `shopping`, `crypto-trading` | Online shops; crypto exchanges and wallets | Banking and payment sites such as PayPal |
| `file-sharing` | File hosts, **including Dropbox** | Google Drive and OneDrive |
| `remote-control` | AnyDesk, TeamViewer and similar | Nothing exempt: also blocks legitimate remote IT support |
| `url-shorteners` | bit.ly, tinyurl and ~10,000 more | Nothing exempt: normal shortened links break too |

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
  [What each list blocks](#what-each-list-blocks-and-what-it-doesnt) for which lists overlap and which add something new.
- Every list uses memory on the device running your blocker; the [Lists](#lists) table shows how many names each has.
- Then check it with [Is it working?](#is-it-working).

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
- Pick only what you need. The hosts file has no wildcards, so every server name is listed one by one.
  - **macOS and Linux** handle big lists fine: `ads-and-tracking` + `security` is a good start.
  - **Windows gets slow above ~150,000 names** (the script warns you), so pick smaller lists there, such as
    `mobile-ads`, `smart-tv`, `youtube-ads`, `live-streaming` or `dating`. For the big ad and security lists on Windows,
    run [AdGuard Home on the PC](#adguard-home-on-a-windows-or-mac-computer) instead: it handles millions of names and
    can protect just that PC.
- It works in every app. A browser set to its own "secure DNS" may skip it; see [Is it working?](#is-it-working), step 3.
- It only protects the device you run it on. To protect every device at home at once, use Pi-hole or AdGuard Home.
- Your original hosts file is saved once as `hosts.block-lists-backup` next to it, and `--remove` / `-Remove` takes out
  only what the script added.
- Afterwards, check it with [Is it working?](#is-it-working).

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
   A second PowerShell window opens with administrator rights; the rest happens there.
4. A window lists every block list. Click the ones you want (hold **Ctrl** to pick several), then click **OK**. Keep the
   total under ~150,000 names (see the *Domains* column) or Windows may get slow.
5. Answer **y** to the daily-update question if you want that, then restart your browser.

Later (in PowerShell, in your Downloads folder): `... -File .\windows.ps1 -Update`, `-Remove`, `-AutoUpdate off`, or
`-Lists mobile-ads,smart-tv` to skip the window. `-NoGui` shows a text menu instead of the window.

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
4. Set **Settings → Network & internet → Private DNS** to **Off** or **Automatic**: a named Private DNS provider makes
   Android skip AdAway.

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

### Chromebook

ChromeOS doesn't let scripts change its hosts file, so point it at a blocker instead:
- **At home:** **Settings → Network → Wi-Fi** → your network → **Network** → **Name servers** → **Custom name servers** →
  enter your AdGuard Home / Pi-hole IP address. (If your router already hands out the blocker, there's nothing to do.)
- **Away from home:** install the **Tailscale** app from the Play Store and follow [Away from home](#away-from-home), or
  use Chrome's **Settings → Privacy and security → Security → Use secure DNS → With: Custom** with an encrypted
  AdGuard Home address (`https://<your AdGuard Home>/dns-query`).
- School or work Chromebooks are managed by an administrator, who may block these settings.

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
   Leave the second DNS field empty, or enter a second blocker; never a public DNS server, or devices skip the blocking
   part of the time. Repeat for each network (for example a separate Kids or IoT network).
2. Turn **off** UniFi's own **Ad Blocking** (Settings → CyberSecure → Ad Blocking, or Settings → Security on older
   versions). While it's on, the gateway sends all DNS to itself, which skips AdGuard Home / Pi-hole.
3. Stop devices from going around it, with two policies in **Settings → Policy Engine → Firewall** (Zone-Based
   Firewall) → **Create Policy**:
   - **Allow blocker DNS:** Action *Allow*, Source zone *Internal* with source IP = your AdGuard Home / Pi-hole, Destination
     zone *External*, ports **53** and **853**, TCP and UDP.
   - **Block other DNS:** Action *Block*, Source zone *Internal*, Destination zone *External*, ports **53** and **853**,
     TCP and UDP. Make sure the *Allow* policy is listed above this one.

   Also add the `vpn-proxy-bypass` list in AdGuard Home / Pi-hole to stop encrypted DNS (DNS-over-HTTPS) and VPN apps.
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
   [`ips/live-streaming-ipv4.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-ipv4.txt) (about 70 entries). Then **Policy Engine → Firewall →
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

## Routers

If your router runs pfSense, OPNsense, OpenWrt, MikroTik RouterOS, a Ubiquiti EdgeRouter, or is a GL.iNet router, it can do the blocking itself for every device at home, and update the lists
every day. Each router has two ways: its own blocking package, or AdGuard Home running next to it. Other routers
(Asus, TP-Link, Netgear, Fritz!Box, internet-provider routers) can't load lists, but can send every device to a
blocker: see [Asus](#asus) and [Any other router](#any-other-router-tp-link-netgear-fritzbox-internet-provider-routers).

Which list link to use:
- **pfSense (pfBlockerNG)**, **OPNsense (Unbound blocklists)** and **OpenWrt (adblock-fast)**: the **plain** links, `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/<list>.txt`
  (for example `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking.txt`).
- **EdgeRouter**: no links needed, the [script](#ubiquiti-edgerouter) shows a menu.
- **MikroTik (DNS adlist)**: the **hosts** links, `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/<list>.txt`.
- **AdGuard Home** (on any of them): the **adblock** links, `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/<list>.txt`.

Router memory is the limit: roughly 100 MB of free RAM per 500,000 domains. Check **Status → Dashboard** (pfSense),
**Lobby → Dashboard** (OPNsense), **Status → Overview** (OpenWrt) or **System → Resources** (MikroTik). Start with
`ads-and-tracking` (about 280,000 names, ~60 MB), then add `security` (about 800,000 names, ~160 MB) and others only while
there's room.

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
*127.0.0.1* (Option B: the AdGuard Home IP, and also set **Source**: tick *Invert match*, *Single host or alias*, the
AdGuard Home IP, so AdGuard Home itself can still reach the internet), Redirect port *53* → Save → Apply. Then **Firewall → Rules → LAN → Add**:
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
   If a site breaks, add it under **Allowlist Domains** (and [report it](#something-broke)).

**Option B: AdGuard Home on another device.** Add the adblock links in AdGuard Home, then set your LAN's DHCP service
(**Services → ISC DHCPv4 → LAN**, or **Dnsmasq DNS & DHCP** / **Kea DHCP** on newer versions) to hand out the AdGuard
Home IP address as the DNS server, and reconnect your devices. (Community plugins can run AdGuard Home on OPNsense
itself, but they're not official.)

**Stop devices from going around it (both options):** **Firewall → NAT → Port Forward → +**: Interface *LAN*, Protocol
*TCP/UDP*, Destination tick **Destination / Invert** and choose *This Firewall*, Destination port *DNS*, Redirect target
IP *127.0.0.1* (Option B: the AdGuard Home IP, and set **Source** to *Invert* + the AdGuard Home IP so it can still
reach the internet), Redirect target port *DNS*, Filter rule association *Add associated filter rule* → Save → Apply. Then **Firewall → Rules → LAN → +**: Action *Block*, Protocol *TCP/UDP*, Destination port
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
   (and [report it](#something-broke)).

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

### GL.iNet

Most GL.iNet routers (Flint, Slate, Beryl, Brume...) have **AdGuard Home built in**, which makes them the easiest
all-in-one option, including as a travel router.
1. Open the router's admin page (`http://192.168.8.1` by default) → **APPLICATIONS → AdGuard Home** → turn it **on** →
   **Apply**.
2. Click **Settings Page** to open AdGuard Home (or go to `http://192.168.8.1:3000`) → **Filters → DNS blocklists → Add
   blocklist → Add a custom list** → paste the adblock links of the lists you want.
3. Keep it modest: router memory is limited, and big combinations can make the built-in AdGuard Home slow. Start with
   `ads-and-tracking`; add `security` on models with 512 MB of RAM or more (e.g. Flint 2).
4. If you use VPN domain-based routing, leave GL.iNet's *AdGuard Home Handle Client Requests* option off: it can conflict
   with those VPN policies.

### Asus

- **Asus "AI" routers** (e.g. GT-BE19000AI) have AdGuard Home built in: install it from the AI Board section of the web
  interface, open `http://<AI Board hostname>:3000`, add the adblock links under **Filters → DNS blocklists**, then set
  **LAN → DHCP Server → DNS and WINS Server Setting** to its address (see Asus's
  [AdGuard Home guide](https://www.asus.com/support/faq/1055942)).
- **Other Asus routers (stock firmware):** they can't load lists. Run AdGuard Home or Pi-hole on another device
  ([Raspberry Pi](#raspberry-pi), [Docker](#docker), a NAS...) and set **LAN → DHCP Server → DNS and WINS Server Setting
  → DNS Server** to its IP address → **Apply**. Asus's built-in *AiProtection* uses Asus's own filters, not these lists.
- **Asuswrt-Merlin** (community firmware): the **Diversion** add-on (installed through `amtm` over SSH) brings dnsmasq-based
  ad blocking to the router itself; see [diversion.ch](https://diversion.ch).

After changing DNS, reach the router by its IP address (e.g. `http://192.168.50.1`) if `www.asusrouter.com` stops loading.

### Any other router (TP-Link, Netgear, Fritz!Box, internet-provider routers)

These can't load block lists, but you can make every device use your blocker (AdGuard Home or Pi-hole on a
[Raspberry Pi](#raspberry-pi), [Docker](#docker), a NAS or [Home Assistant](#home-assistant)). Look in the router's
**LAN / DHCP** settings for a **DNS server** field and enter the blocker's IP address. If there's a second DNS field, leave
it empty or repeat the same address; a public DNS server there lets devices skip the blocking. Typical places:

| Router | Where |
|---|---|
| **TP-Link** (Archer, Deco) | Archer: **Advanced → Network → DHCP Server → Primary DNS**. Deco app: **More → Advanced → DHCP Server → DNS** (newer models) |
| **Netgear** (Nighthawk, Orbi) | Usually no LAN DNS field: use **Advanced → Setup → Internet Setup → Domain Name Server (DNS) Address → Use These DNS Servers** and enter the blocker's IP (all queries then appear to come from the router) |
| **Fritz!Box** | **Home Network → Network → Network Settings → IP Addresses → IPv4 Settings → Local DNS server** |
| **Internet-provider routers** | Often locked. If there's no DNS field, turn **off** the router's DHCP and turn it **on** in AdGuard Home (**Settings → DHCP settings**) or Pi-hole (**Settings → DHCP**) |

Save, then reconnect your devices (turn Wi-Fi off and on). Menu names vary by model and firmware.

### Mesh Wi-Fi (eero, Google Nest Wifi, Deco, Orbi, Velop)

Mesh systems are set up in a phone app, and most let you choose the DNS server. Enter your AdGuard Home / Pi-hole IP
address (and leave the second DNS field empty or set to a second blocker):
- **eero:** eero app → **Settings → Network settings → DNS → Customized DNS**.
- **Google Nest Wifi / Wifi Pro:** Google Home app → **Wi-Fi** → ⚙ **Settings → Advanced networking → DNS → Custom**.
- **TP-Link Deco, Netgear Orbi, Linksys Velop:** see the TP-Link / Netgear rows above; for Velop look under the app's
  **Advanced settings** for DNS.

Many mesh systems forward DNS themselves, so AdGuard Home / Pi-hole may show all queries coming from the router instead of
each device; blocking still works. Turn off the system's own filtering subscriptions (eero Plus, Netgear Armor...) if
they override DNS.

### Starlink, 4G and 5G home routers

- **Starlink:** check the Starlink app for a **Custom DNS** option first (Settings) and enter the blocker's IP there. If
  your router doesn't offer it, turn on **Bypass mode** (Starlink app → Settings → Router) and use your own router behind
  it, then follow that router's section. Gen 2 kits need Starlink's Ethernet adapter for this; undoing bypass mode
  requires a factory reset of the Starlink router.
- **4G / 5G home routers** (Huawei, ZTE, Netgear Nighthawk M-series, provider-branded): look for DNS under **DHCP** /
  **LAN** settings. If there's none, either turn off the router's DHCP and let AdGuard Home / Pi-hole hand out addresses,
  or put the router in **bridge / IP passthrough** mode and use your own router behind it.

### TP-Link Omada and other business gateways

Omada gateways can't load these lists, but they can hand out your blocker as the DNS server: in the Omada controller
(software, OC200/OC300 or cloud) → **Settings → Wired & Wireless Networks → LAN** → edit your network → **DHCP Server**
(under advanced settings) → **DNS Server: Manual** → enter the AdGuard Home / Pi-hole IP → **Save**. Repeat for each
network (VLAN). To stop devices going around it, add an ACL (**Settings → Network Security → ACL**) blocking LAN → WAN
traffic to ports 53 and 853 except from the blocker. Other business gateways (Sophos, Fortinet, Cisco...) work the same
way: set the DNS server their DHCP hands out, and block outgoing DNS from everything else.

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

**How many lists fit:** a Zero 2 W (512 MB) is fine with a few lists (roughly 500,000 names in total, e.g.
`ads-and-tracking` + `mobile-ads` + `smart-tv`); a Pi 3 (1 GB) handles about a million (e.g. `ads-and-tracking` +
`security`); a Pi 4 or 5 with 2 GB or more handles the big combinations such as `ads-and-tracking-extended` + `security`
+ `adult`.

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
   (turn Wi-Fi off and on, or restart them; otherwise they can take up to a day to pick up the change). Find your
   router's menu in [Routers](#routers); UniFi users:
   [Option 1](#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically).
   - If the router asks for a **second DNS server**, enter the same address again or a second blocker. **Don't** put a
     public DNS server (8.8.8.8, 1.1.1.1...) there: devices use both at random, and would skip the blocking part of the
     time.
2. **Router won't let you change DNS** (common on internet-provider routers)? Let the Pi hand out addresses instead:
   turn **off** DHCP on the router, then turn it **on** in AdGuard Home (**Settings → DHCP settings**) or Pi-hole
   (**Settings → DHCP**). Every device then gets the Pi as its DNS server automatically.
3. Stop devices from going around it with your router's firewall if it can (see the [router guides](#routers))
   and the `vpn-proxy-bypass` list.
4. Check it works: the dashboard should show queries and blocked requests within a few minutes; then run the checks in
   [Is it working?](#is-it-working).

**Keeping it updated:** the lists update by themselves. Update the Pi now and then with
`sudo apt update && sudo apt full-upgrade -y`; update AdGuard Home from its web page when it offers a new version, or
Pi-hole with `pihole -up`.

**Good to know:** if the Pi is off, DNS stops working at home unless there's a second DNS server. A public DNS server as
backup would let some lookups skip the lists, so a second Pi (or the [Synology NAS](#synology-nas) setup) is the better
backup. To use the same blocking away from home on phones, see [iPhone and iPad](#iphone-and-ipad) and
[Android](#android).

## Docker

Run AdGuard Home or Pi-hole in Docker on any always-on computer: a Linux server or mini PC, or a NAS / home server with
Docker. OpenMediaVault, QNAP and Unraid users: see [OpenMediaVault](#openmediavault), [QNAP NAS](#qnap-nas) and [Unraid](#unraid); Proxmox users: see [Proxmox VE](#proxmox-ve); TrueNAS users: see [TrueNAS](#truenas). Ready-made files are in [`docker/`](docker/); they're tested
automatically on every change. (Synology users: see [Synology NAS](#synology-nas).)

Commands below use `sudo docker`; you can leave out `sudo` if your user is in the `docker` group.

### Step 1: install Docker and download AdGuard Home or Pi-hole

Install Docker if needed ([docs.docker.com/engine/install](https://docs.docker.com/engine/install/), or
`curl -fsSL https://get.docker.com | sudo sh` on most Linux systems). Then download the ready-made file for the one you
want, and the program itself (do this first: step 2 briefly changes how the server looks up names):

**AdGuard Home**
```bash
mkdir -p ~/adguardhome && cd ~/adguardhome
curl -fsSLO https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/adguardhome/compose.yaml
sudo docker compose pull
```

**Pi-hole** (set your own password and time zone in the `.env` file; Docker reads it on every start, so updates keep it)
```bash
mkdir -p ~/pihole && cd ~/pihole
curl -fsSLO https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/pihole/compose.yaml
printf 'PIHOLE_PASSWORD=choose-a-password\nTZ=Europe/London\n' > .env
sudo docker compose pull
```

### Step 2: free port 53 (Ubuntu and Debian servers)

DNS uses port 53. Check whether something already uses it: `sudo ss -lunp | grep ':53 '`. If nothing is printed, go to
step 3. If `systemd-resolved` is listed (usual on Ubuntu), turn its listener off and let the server use your blocker
itself (AdGuard's documented fix):
```bash
sudo mkdir -p /etc/systemd/resolved.conf.d
printf '[Resolve]\nDNS=127.0.0.1\nDNSStubListener=no\n' | sudo tee /etc/systemd/resolved.conf.d/adguardhome.conf
sudo mv /etc/resolv.conf /etc/resolv.conf.backup
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo systemctl reload-or-restart systemd-resolved
```

### Step 3: start it

In the folder from step 1 run `sudo docker compose up -d`. Then:
- **AdGuard Home:** open `http://<server IP>:3000` and follow the setup wizard (keep the admin web interface on port
  **3000** and the DNS server on port **53**), then add the lists ([How to add a list](#how-to-add-a-list)).
- **Pi-hole:** open `http://<server IP>:8081/admin`, sign in with the password from `.env`, add the lists under **Lists**,
  then **Tools → Update Gravity**.

### Step 4: use it for the whole home

Follow [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home-1): set the server's IP as the DNS server in your router
(or let AdGuard Home / Pi-hole run DHCP), stop devices going around it, and check the dashboard. If the server has a
firewall, allow port 53 (TCP and UDP) and the admin port: `sudo ufw allow 53 && sudo ufw allow 3000/tcp` (Pi-hole:
`8081/tcp`).

**Updating:** the lists update themselves. To update AdGuard Home / Pi-hole, in its folder run
`sudo docker compose pull && sudo docker compose up -d`. Your settings are kept in the `work`/`conf` (or `etc-pihole`)
folders next to `compose.yaml`; back those up.

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

## Unraid

On Unraid, install AdGuard Home or Pi-hole as a Docker container from **Community Applications** and give it its own IP
address on your network, so it doesn't clash with Unraid's web interface. (Unraid 6.12 or newer; menu names may differ
slightly between versions.)

### Step 1: install the container

1. Open the **Apps** tab. If Community Applications isn't installed yet, Unraid offers to install it; accept.
2. Search **AdGuard Home** (or **Pi-hole**) and pick the template whose **Repository** is the official image
   (`adguard/adguardhome`, or `pihole/pihole`) → **Install**.
3. In the template:
   - **Network Type:** **Custom: br0** (or *eth0* / *bond0*, whichever is your LAN), and **Fixed IP address**: a free
     address on your network outside the router's DHCP range, e.g. `192.168.1.5`.
   - **Pi-hole only:** fill in the admin **password** field and your **time zone** (`TZ`).
   - Keep the suggested **appdata** paths (`/mnt/user/appdata/...`) so settings survive updates.
   - **Apply** and wait for the container to start.
4. **Docker** tab → make sure **Autostart** is on for the container.

### Step 2: set it up

- **AdGuard Home:** open `http://192.168.1.5:3000` (its own address) and follow the setup wizard: DNS server on port
  **53**, admin web interface on port **80** (fine, because the container has its own IP), then create your username
  and password.
- **Pi-hole:** open `http://192.168.1.5/admin` and sign in.
- Add the lists with the adblock links ([How to add a list](#how-to-add-a-list)).

Unraid itself can't reach containers on `br0` unless you allow it: **Settings → Docker** → stop Docker → **Host access
to custom networks: Enabled** → Apply → start Docker. Keep Unraid's own DNS (**Settings → Network Settings**) pointing at
your router or a public DNS server, so Unraid can still download updates while the container is stopped.

### Step 3: use it for the whole home

1. Point your network at it: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home-1) (router DNS or AdGuard Home /
   Pi-hole as DHCP server, stopping devices going around it).
2. **Updates:** the lists update themselves. Update the container from the **Docker** tab (**Check for Updates** →
   **apply update**), or automatically with the *CA Auto Update Applications* plugin.
3. **Backups:** the *Appdata Backup* plugin (from Apps) backs up the container's settings on a schedule.
4. If the array is stopped or Unraid restarts, the container stops too: give your router a second DNS server running
   the same lists (a Raspberry Pi or another NAS) to keep home DNS working.

## OpenMediaVault

On an OpenMediaVault NAS (OMV 7), run AdGuard Home or Pi-hole with the **Compose** plugin from omv-extras, using our
ready-made files.

### Step 1: install omv-extras and the Compose plugin

1. Log in to the NAS over SSH (enable SSH under **Services → SSH** if needed) and install omv-extras with its official
   command:
   ```bash
   wget -O - https://github.com/OpenMediaVault-Plugin-Developers/packages/raw/master/install | sudo bash
   ```
2. In the OMV web interface: **System → Plugins** → search **openmediavault-compose** → **Install**.
3. **Storage → Shared Folders → Create**: a folder for app data, e.g. `appdata`. Then **Services → Compose → Settings**:
   choose it as the **Compose Files** location (and set the Docker storage path if asked) → **Save** → apply. If Docker
   isn't installed yet, use the **Reinstall Docker** button on that page.

### Step 2: add AdGuard Home or Pi-hole

1. Check port 53 is free (OMV's own web interface uses port 80 and doesn't need it): over SSH run
   `sudo ss -lunp | grep ':53 '`; if `systemd-resolved` shows up, apply [Docker, step 2](#step-2-free-port-53-ubuntu-and-debian-servers).
2. **Services → Compose → Files → Create (+)**: name it `adguardhome` (or `pihole`) and paste
   [`docker/adguardhome/compose.yaml`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/adguardhome/compose.yaml)
   (or [`docker/pihole/compose.yaml`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/pihole/compose.yaml): replace `${PIHOLE_PASSWORD:-change-me}` with
   your own password and `${TZ:-UTC}` with your time zone, e.g. `Europe/London`) → **Save**.
3. Select the file → **Up** (▲). Then open `http://<NAS IP>:3000` (AdGuard Home setup wizard: keep the admin port
   3000 and DNS on 53) or `http://<NAS IP>:8081/admin` (Pi-hole), and add the lists ([How to add a list](#how-to-add-a-list)).

### Step 3: use it for the whole home

Follow [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home-1). To update AdGuard Home / Pi-hole later: select the
file in **Services → Compose → Files** → **Pull** → **Up**.

## QNAP NAS

On a QNAP NAS, use **Container Station** (version 3) with our ready-made Compose files.

1. **App Center** → install **Container Station** and open it.
2. **Applications → Create**: application name `adguardhome` (or `pihole`), paste
   [`docker/adguardhome/compose.yaml`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/adguardhome/compose.yaml)
   (or [`docker/pihole/compose.yaml`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/pihole/compose.yaml): replace `${PIHOLE_PASSWORD:-change-me}` with
   your own password and `${TZ:-UTC}` with your time zone) → **Validate YAML**
   → **Create**. Container Station keeps the files under `/share/Container/container-station-data/application/<name>`.
3. Open `http://<NAS IP>:3000` (AdGuard Home setup wizard: keep the admin port 3000 and DNS on 53) or
   `http://<NAS IP>:8081/admin` (Pi-hole), and add the lists ([How to add a list](#how-to-add-a-list)).
4. If the container won't start because **port 53** is in use (another app or QNAP service on the NAS uses it), give the
   container its own IP address on your network instead of publishing ports: in Container Station's network settings use
   a **bridge / qnet** network with a fixed IP, and remove the `ports:` lines.
5. Give the NAS (or the container) a fixed IP, then follow [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home-1).
   Update later from **Applications** → the app → **Update** (or recreate it, which pulls the latest image).

## Home Assistant

Running Home Assistant OS? Its **AdGuard Home** app (add-on) turns the same box into the blocker for your whole home.

1. **Give Home Assistant a static IP and fixed DNS servers first** (the add-on's own instructions insist on this): **Settings
   → System → Network → Configure network interfaces** → your interface → **IPv4** → **Static**: set the address (e.g.
   `192.168.1.6`), gateway (your router) and DNS servers (e.g. `1.1.1.1`) → **Save**. A reservation in your router is not
   enough.
2. **Settings → Add-ons** (called **Apps** in newer versions) → **Add-on Store** → search **AdGuard Home** → **Install** →
   **Start**, and turn on **Start on boot** and **Show in sidebar**. Check its **Log** tab for errors.
3. Click **Open Web UI** (you're signed in with your Home Assistant account) → **Filters → DNS blocklists → Add blocklist →
   Add a custom list** → paste the adblock links ([How to add a list](#how-to-add-a-list)).
4. Point your network at Home Assistant's IP: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home-1). Keep Home
   Assistant's own DNS (step 1) on a public server, so it still works when the add-on restarts.
5. Updates: the lists update themselves; Home Assistant offers add-on updates under **Settings → Updates**. Include the
   add-on in your Home Assistant backups.

If Home Assistant runs as a VM or container on another system (Proxmox, a NAS), you can instead follow that system's
section ([Proxmox VE](#proxmox-ve), [Docker](#docker)...).

## Away from home

Phones and laptops are only protected while they use your home network. To keep the same blocking on mobile data, at
work or while travelling, connect them back to your AdGuard Home / Pi-hole.

### Option A: Tailscale (easiest, free for personal use)

Tailscale creates a private, encrypted network between your devices, without opening anything on your router.
1. Create a free account at [tailscale.com](https://tailscale.com) and install Tailscale on the device running AdGuard
   Home / Pi-hole. On a Raspberry Pi or Linux server: `curl -fsSL https://tailscale.com/install.sh | sh` then
   `sudo tailscale up` (open the link it prints to sign in). Synology, QNAP, TrueNAS, Unraid and Home Assistant have a
   Tailscale app in their app stores. Then turn off Tailscale's own DNS on that device, so the blocker doesn't ask
   itself: `sudo tailscale set --accept-dns=false`.
2. In the [admin console](https://login.tailscale.com/admin/machines), note the blocker's Tailscale address (it starts
   with `100.`).
3. Admin console → **DNS** → **Global nameservers** → **Add nameserver → Custom** → enter that `100.x.x.x` address →
   **Save**, then turn on **Override DNS servers**.
4. Install the Tailscale app on your phones and laptops and sign in with the same account (keep **Use Tailscale DNS
   settings** on). Their DNS now goes through your blocker wherever they are.
5. AdGuard Home must listen on all interfaces (the default, `0.0.0.0`); in Pi-hole set **Settings → DNS → Interface
   settings → Permit all origins**.

On phones, Tailscale counts as a VPN, so it can't run at the same time as another VPN app (or AdGuard / AdAway).

### Option B: encrypted DNS from AdGuard Home

AdGuard Home can serve encrypted DNS (DNS-over-HTTPS and DNS-over-TLS) to devices anywhere. This needs a domain name, a
certificate (**Settings → Encryption settings**) and ports 443/853 forwarded to it from your router, so it's for more
experienced users. Devices then use:
- **Android:** **Settings → Network & internet → Private DNS** → your AdGuard Home hostname.
- **iPhone / iPad:** the profile from **Setup Guide → DNS Privacy → iOS** (see [iPhone and iPad](#iphone-and-ipad)).
- **Browsers / Chromebooks:** **Use secure DNS** with `https://<your hostname>/dns-query`.

Pi-hole has no encrypted DNS of its own: use Option A.

## AdGuard Home on a Windows or Mac computer

No Raspberry Pi or NAS? AdGuard Home also runs directly on an always-on Windows or Mac computer as a background service,
and can protect the whole home from there. The computer needs a fixed IP address (reserve it in your router) and must
stay on.

**Windows**
1. Download `AdGuardHome_windows_amd64.zip` from the [latest release](https://github.com/AdguardTeam/AdGuardHome/releases/latest)
   and unzip it to a permanent folder, e.g. `C:\AdGuardHome`.
2. Open **PowerShell as administrator** in that folder and install it as a service:
   ```powershell
   cd C:\AdGuardHome
   .\AdGuardHome.exe -s install
   New-NetFirewallRule -DisplayName "AdGuard Home DNS" -Direction Inbound -Protocol UDP -LocalPort 53 -Action Allow
   New-NetFirewallRule -DisplayName "AdGuard Home DNS TCP" -Direction Inbound -Protocol TCP -LocalPort 53,3000 -Action Allow
   ```
3. Open `http://127.0.0.1:3000`, follow the setup wizard (keep the admin port 3000 and DNS on 53) and add the lists
   ([How to add a list](#how-to-add-a-list)). If it reports port 53 in use, check with `netstat -ano | findstr ":53 "`
   (Windows *Internet Connection Sharing* is a common cause).

**macOS**
```bash
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
```
The official script installs it into `/Applications/AdGuardHome` as a service. Open `http://127.0.0.1:3000`, finish
the wizard and add the lists. Allow incoming connections if macOS asks.

Then either:
- **Protect the whole home:** point your network at the computer: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home-1).
- **Protect only this computer:** set its own DNS server to `127.0.0.1`. Windows 11: **Settings → Network & internet →
  Wi-Fi** (or Ethernet) → your network → **DNS server assignment → Edit → Manual** → IPv4 on → Preferred DNS `127.0.0.1` →
  Save. macOS: **System Settings → Network** → your network → **Details → DNS** → **+** `127.0.0.1` (remove the others).

Manage the service later with `AdGuardHome -s stop|start|uninstall` (as administrator / with `sudo`).

## Technitium DNS Server

[Technitium DNS Server](https://technitium.com/dns/) is a free alternative to AdGuard Home and Pi-hole. It runs natively
on Windows, Linux, macOS and in Docker, and accepts these lists by link.

1. Install it:
   - **Windows:** download and run the installer from [technitium.com/dns](https://technitium.com/dns/).
   - **Linux / Raspberry Pi:** `curl -sSL https://download.technitium.com/dns/install.sh | sudo bash`
   - **Docker:** the `technitium/dns-server` image (ports 53/udp, 53/tcp and 5380/tcp).
2. Open the web console at `http://<computer IP>:5380` and set an admin password.
3. **Settings → Blocking** → make sure blocking is enabled → under **Allow / Block List URLs**, add the plain links of
   the lists you want, one per line, e.g. `https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ads-and-tracking.txt` → **Save Settings**. Technitium downloads them in
   the background and refreshes them every day.
4. Point your network at it: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home-1).

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
  broke, and allow it (in AdGuard Home / Pi-hole; see [Something broke?](#something-broke)).
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
  blocked name from when it broke and allow it (right away in the blocker; see [Something broke?](#something-broke)).

## Is it working?

**1. Is the device using your blocker?** On a computer run `nslookup example.com`: the **Server** line should show your
AdGuard Home / Pi-hole address (or your router's, if the router forwards to it). Phones: open the blocker's query log and
look for the phone's address after browsing.

**2. Is blocking working?** Run `nslookup doubleclick.net` (it's in `ads-and-tracking`): the answer should be `0.0.0.0`
or "can't find". The [d3ward ad-block test](https://d3ward.github.io/toolz/adblock) shows which ad and tracking servers
are blocked from your browser (its "cosmetic" tests are for browser ad blockers and won't change with DNS blocking).

**3. Still seeing ads or no blocking?** Something is going around your blocker:
- **Browser "secure DNS":** Chrome / Edge: **Settings → Privacy and security → Security → Use secure DNS** → off, or
  *with your current service provider*. Firefox: **Settings → Privacy & Security → DNS over HTTPS → Default protection**
  (AdGuard Home and Pi-hole already tell Firefox to use the network's DNS).
- **Android Private DNS:** **Settings → Network & internet → Private DNS → Off** or *Automatic* (unless you set it up in
  [Away from home](#away-from-home)).
- **iPhone iCloud Private Relay:** **Settings → [your name] → iCloud → Private Relay**: off, or switch it off for your
  home Wi-Fi network.
- **VPN apps** and devices with hard-coded DNS: see [Smart TVs, step 3](#step-3-stop-devices-that-ignore-your-dns) and add
  the `vpn-proxy-bypass` list.
- **Old cached answers:** restart the browser, or flush the cache (`ipconfig /flushdns` on Windows,
  `sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder` on macOS), or toggle Wi-Fi on phones.

**4. Something broke?** Open the **query log** in AdGuard Home / Pi-hole, filter by the device's IP address, repeat what
broke, and allow the blocked name it shows. Common ones:
- **Shopping, deal and affiliate links** (cashback sites, newsletter deals): add HaGeZi's referral allowlist in AdGuard
  Home under **Filters → DNS allowlists → Add allowlist**:
  `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/whitelist-referral.txt`.
- **Links in emails** (newsletters, receipts) often go through a tracking address: allow the address shown in the log.
- **Smart-home devices, app stores, sign-in and payment pages:** allow the blocked name from the log.

Then [report it](#something-broke) so it's fixed for everyone using these lists.

## Troubleshooting FAQ

**Blocking works on some devices but not others, or only some of the time.**
Usually a second DNS server is letting devices go around the blocker:
- A public DNS server (8.8.8.8, 1.1.1.1...) in the router's second DNS field: remove it or repeat the blocker's address.
- **IPv6:** many routers (especially on fibre) also hand out their own or the provider's DNS over IPv6, which devices
  prefer. Fix it in the router's IPv6 / LAN settings: set the IPv6 DNS server to your blocker's IPv6 address (shown in
  AdGuard Home's dashboard / Pi-hole's *Settings*), or turn off *advertise DNS* / IPv6 DNS for the LAN.
- Devices haven't picked up the change yet: reconnect Wi-Fi or restart them.
- A device or browser uses its own secure DNS, Private DNS or VPN: see [Is it working?](#is-it-working), step 3.

**The whole internet stopped working.**
Your blocker is probably off or restarting. Restart it (the Pi, NAS app or container). To get online immediately, set
your router's DNS back to *automatic*, then fix the blocker. To avoid this, run a second blocker and give the router
both addresses.

**Websites load slowly.**
Check the blocker's upstream DNS (AdGuard Home: **Settings → DNS settings → Upstream DNS servers**; Pi-hole: **Settings
→ DNS**) and pick a fast, nearby provider. Too many big lists on a small device (Pi Zero, small router) also slows it
down: check its memory and drop lists you don't need. A wired connection helps a Raspberry Pi.

**AdGuard Home / Pi-hole shows 0 rules, or a list fails to download.**
Use the **raw** links from the [Lists](#lists) table (they start with `https://raw.githubusercontent.com/`), not the
GitHub page address. Pi-hole v5 needs the **Plain** link; Pi-hole v6 and AdGuard Home take the **Adblock** link. Check
the blocker itself has internet access, then update the lists again.

**Why does the Adblock version have fewer entries than the Plain one?**
That's normal: one adblock rule such as `||example.com^` also covers all its subdomains, so they don't need their own
lines.

**I still see ads on YouTube, Facebook, Instagram, Twitch or Spotify.**
Those services deliver ads from the same servers as their content, so DNS blocking can't separate them. Use a browser ad
blocker for the websites (see [YouTube ads in the browser](#youtube-ads-in-the-browser)) or the paid ad-free plans for
the apps.

**A site, app, email link or shopping link stopped working.**
See [Is it working?](#is-it-working) step 4 and [Something broke?](#something-broke).

**Children still get around the blocks.**
DNS blocking only works on your network: on **mobile data** or a friend's hotspot it doesn't apply, so also use the
phone's parental controls (Google Family Link, Apple Screen Time). Add `vpn-proxy-bypass` against VPN apps and encrypted
DNS, block outside DNS on the router ([Smart TVs, step 3](#step-3-stop-devices-that-ignore-your-dns)), and apply the
stricter lists only to the children's devices (AdGuard Home **Settings → Client settings**, Pi-hole **Group
Management**). Private / incognito browser windows don't get around DNS blocking.

**"Port 53 is already in use" when installing.**
Something else answers DNS on that device. See [Docker, step 2](#step-2-free-port-53-ubuntu-and-debian-servers) (Linux),
[TrueNAS](#truenas), [Synology, step 1](#step-1-prepare-the-nas), [QNAP](#qnap-nas), or
[AdGuard Home on Windows](#adguard-home-on-a-windows-or-mac-computer).

**Microsoft Defender reports "HostsFileHijack".**
Expected when the Windows script adds `windows-telemetry`, because it blocks Microsoft's data collection. Choose *Allow on
device*, or don't use that list with the script.

**The device script ran, but nothing seems blocked.**
Restart the browser (it keeps its own cache), and check its secure-DNS setting ([Is it working?](#is-it-working), step
3). Make sure you ran the script with administrator rights (`sudo`, or **Yes** on Windows' prompt).

**How often do the lists update? Can I update them now?**
This repository rebuilds them every day. AdGuard Home fetches updates daily (or **Filters → DNS blocklists → Check for
updates**); Pi-hole weekly (or **Tools → Update Gravity**); the device scripts daily if you turned that on (or run them
with `--update` / `-Update`). A list's *Last modified* date only changes when its contents change.

**Is my browsing sent to anyone?**
No. Your blocker or device only downloads the lists from GitHub; your DNS lookups stay on your own AdGuard Home, Pi-hole,
router or device.

**My problem isn't here.** [Open an issue](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/issues) describing your setup (blocker, router, device) and what happens.

## Something broke?

A site, app or device stopped working after adding a list? Fix it on your own blocker right away, then tell us so it's
fixed for everyone.

1. **Find the blocked name:** open the **Query Log** in AdGuard Home / Pi-hole, filter by the affected device's IP address,
   repeat what broke, and look for the blocked entries that appear.
2. **Allow it:**
   - **AdGuard Home:** click **Unblock** next to the entry in the Query Log (or add `@@||example.com^` under **Filters →
     Custom filtering rules**).
   - **Pi-hole:** click **Allow** next to the entry in the Query Log (or **Domains** → add it as an *allow* domain).
   - **Device scripts** (hosts file): remove the list that contains it and run the script again, or use
     `--remove` / `-Remove`.
   - **Routers:** use your router's allow / whitelist option (e.g. OPNsense *Allowlist Domains*, MikroTik `type=FWD`).
3. **Report it:** [open an issue](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/issues) with the domain name and what broke, so it can be added to the shared
   [`allowlist.txt`](allowlist.txt) and removed from the lists for everyone on the next daily build.

Essential sites (Google, Microsoft, Apple, WhatsApp, PayPal, big CDNs, common link shorteners...) are listed in
[`protected.txt`](protected.txt). Every build removes them from all lists automatically, unless a list is meant to block
them (set with `may_block` in `lists.json`, e.g. `social-media` may block Facebook). This stops a mistake in an upstream
source from breaking those sites.

## Changelog

Latest changes (the full history is in [CHANGELOG.md](CHANGELOG.md); the lists' contents also refresh every day):

- **2026-10-10:**
  - **Added:** a Quick start; guides for routers, NAS systems, TVs, consoles, phones and away from home; device installers
    for macOS, Windows, Linux, Android and EdgeRouter; YouTube browser lists; and 17 more lists, including
    `ads-regional`, `game-consoles`, `youtube`, `messaging` and `security-strict`.
  - **Fixed:** `t.co` and `bit.ly` links being blocked; `chat-strangers` blocking WhatsApp and Discord; and the wrong
    claim that `security` contains `phishing-and-scams`.
- **2026-10-09:** added the parental-control and content lists (`adult`, `gambling`, `dating`, `social-media`,
  `live-streaming`, `vpn-proxy-bypass` and more).
- **2026-10-08:** lists rebuilt from maintained sources with daily updates, in three formats. The old addresses still
  work.

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

## For maintainers

This part is for people running their own copy (fork) of this repository; you don't need it to use the lists.

### Adding your own domains

Put extra domains in `custom/<list>.txt` (in your own copy / fork of this repository), one per line. They are always included in that list.
`custom/mobile-ads.txt` and `custom/mobile-spyware.txt` hold the original 2019 lists.

### How it updates

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

### Adding a new list or source

1. Add the source to [`sources.json`](sources.json) (`name`, `url` or a repo `path`, `home`, `license`, and optionally `exclude` regexes).
2. Add or edit the list in [`lists.json`](lists.json) (`title`, `description`, `sources`).
3. Push. The Action builds the new list in all three formats and adds it to the tables above automatically.
