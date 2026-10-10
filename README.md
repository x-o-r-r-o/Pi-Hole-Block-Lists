# Pi-Hole-Block-Lists

[![Update block lists](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/actions/workflows/update.yml/badge.svg)](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/actions/workflows/update.yml)

Ready-to-use DNS block lists for **Pi-hole** and **AdGuard Home**, rebuilt **every day**
from well-maintained upstream sources, merged and de-duplicated.

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
| `gambling` | Online casinos, sports betting, poker, lotteries and other gambling sites. | ~586k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/gambling.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/gambling.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/gambling.txt) |
| `adult` | Porn and other adult (NSFW) sites (see Safe Search tip below). | ~526k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/adult.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adult.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/adult.txt) |
| `social-media` | Social networks: Facebook, Instagram, TikTok, X/Twitter, Snapchat, Reddit, LinkedIn, Pinterest, Tumblr, Threads, Bluesky, Discord and more. WhatsApp is not blocked. | ~4.5k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/social-media.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/social-media.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/social-media.txt) |
| `smart-tv` | Tracking and ads on smart TVs, streaming sticks and game consoles (Samsung, LG webOS, Roku, Amazon Fire, PlayStation, Xbox, Nintendo). | ~1.4k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/smart-tv.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/smart-tv.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/smart-tv.txt) |
| `security` | Malware, phishing, scams and fake shops from threat-intelligence feeds. Recommended for everyone. | ~772k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/security.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/security.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/security.txt) |
| `stalkerware` | Spy and monitoring apps that can be secretly installed on a phone to track messages and location. Also blocks parental-control apps such as Bark, so don't use it if you rely on one. | 949 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/stalkerware.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/stalkerware.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/stalkerware.txt) |
| `crypto-mining` | Hidden crypto-mining scripts and mining pools (cryptojacking). Exchanges like Coinbase/Binance are not blocked. | ~12k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/crypto-mining.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/crypto-mining.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/crypto-mining.txt) |
| `phishing-and-scams` | Phishing sites (fake bank, PayPal, Microsoft and delivery logins), scams and fake shops. Already included in `security`; use this if you only want phishing/scam protection. | ~564k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/phishing-and-scams.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/phishing-and-scams.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/phishing-and-scams.txt) |
| `live-streaming` | Bigo Live, Likee, MICO, SUGO, Poppo, Chamet, Tango, StreamKar, LiveMe, 17LIVE, Uplive, Hago, Yalla, SoulChill, Azar, HOLLA, Mango, GOGO LIVE, SuperLive, Kumu, Ahlan, Ola Party, Hiya, Nimo TV and ~30 more paid live/video-chat apps (see note below). | ~2.3k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/live-streaming.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/live-streaming.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/live-streaming.txt) |
| `dating` | Dating sites and apps: Tinder, Bumble, Badoo, Hinge, OkCupid, Plenty of Fish, Match, Grindr, Tantan, happn, Hily, Boo, Taimi, Muzz, Coffee Meets Bagel and ~10,000 dating websites. | ~13k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/dating.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/dating.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/dating.txt) |
| `vpn-proxy-bypass` | VPNs, web proxies and encrypted-DNS services that people use to get around blocking. Use with the other lists to stop bypassing (may block a work VPN). | ~23k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/vpn-proxy-bypass.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/vpn-proxy-bypass.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/vpn-proxy-bypass.txt) |
| `piracy` | Illegal movie, TV, music and software download and streaming sites (torrents, warez). | ~55k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/piracy.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/piracy.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/piracy.txt) |
| `drugs` | Sites selling or promoting illegal drugs. | 436 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/drugs.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/drugs.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/drugs.txt) |
| `online-games` | Online and browser gaming sites, including Steam, Roblox and Epic Games. | ~34k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/online-games.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/online-games.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/online-games.txt) |
| `violence-hate` | Violent, aggressive and hate-speech sites. | 267 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/violence-hate.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/violence-hate.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/violence-hate.txt) |
| `ai-chatbots` | AI chatbots and writing tools (ChatGPT, Claude, Gemini, Copilot, DeepSeek, Character.AI...). Useful for schools and homework time. | 93 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ai-chatbots.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ai-chatbots.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/ai-chatbots.txt) |
| `safesearch-bypass` | Search engines that can't enforce SafeSearch. Use with `adult` so explicit results can't be reached through other search engines. | 203 | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/safesearch-bypass.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/safesearch-bypass.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/safesearch-bypass.txt) |
| `gaming-platforms` | Roblox, Fortnite/Epic, Free Fire, PUBG/BGMI, Minecraft, Steam, Xbox, PlayStation, Nintendo, EA, Riot (League, Valorant), Battle.net, Ubisoft, Call of Duty, Clash of Clans, Mobile Legends, Genshin Impact, Candy Crush, Among Us. | ~1.5k | [Adblock](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/gaming-platforms.txt) · [Plain](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/gaming-platforms.txt) · [Hosts](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/hosts/gaming-platforms.txt) |
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
| [`ips/live-streaming.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming.txt) | Same, IPv4 and IPv6 together |

**AdGuard Home:** Filters → DNS blocklists → Add blocklist → Add a custom list → paste the `-adguard.txt` link → Save.
AdGuard Home then refuses any DNS answer that points into Bigo's network, which also catches new Bigo server names.
Use it together with `adblock/live-streaming.txt`. (Pi-hole can't block by IP; use your router for that.)

**pfSense (pfBlockerNG):** Firewall → pfBlockerNG → **IP → IPv4** → Add → paste the `-ipv4.txt` link as the source,
Action *Deny Both*, Update frequency *Once a day* → Save, then run **Update → Force Update**. Repeat under **IPv6** with
`-ipv6.txt`.

**OPNsense:** Firewall → **Aliases** → + → Type *URL Table (IPs)*, Content: the `live-streaming.txt` link, Refresh
frequency 1 day → Save → Apply. Then Firewall → **Rules → LAN** → + → Action *Block*, Destination: the alias → Save →
Apply.

**OpenWrt:** with the **banIP** package, add the `-ipv4.txt` / `-ipv6.txt` links as custom feeds (see the banIP docs for
your OpenWrt version).

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
| [Dandelion Sprout's Game Console Adblock List](https://github.com/DandelionSprout/adfilt) | `smart-tv` | Dandelicence (see repo) |
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
