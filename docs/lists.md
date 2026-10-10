# Lists explained

[← README](../README.md) · [Lists explained](lists.md) · [Devices](devices.md) · [Routers](routers.md) · [Servers & NAS](servers.md) · [TVs & consoles](tv-and-consoles.md) · [Troubleshooting](troubleshooting.md)

## Contents

<!-- TOC:START -->
- [What each list blocks (and what it doesn't)](#what-each-list-blocks-and-what-it-doesnt)
- [List notes](#list-notes)
  - [live-streaming](#live-streaming)
  - [security-strict](#security-strict)
  - [adult: Safe Search](#adult-safe-search)
  - [YouTube ads](#youtube-ads)
- [Blocking by IP address (ips/)](#blocking-by-ip-address-ips)
<!-- TOC:END -->

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
| `ads-and-tracking` | Ad and tracking servers on websites and apps | The sites and apps themselves; Google's sponsored search links; [essential sites](troubleshooting.md#something-broke) |
| `ads-and-tracking-extended` | Everything above, plus telemetry, pop-ups and push-notification spam | Same; may block some tracked email or shopping links (fix: [referral allowlist](troubleshooting.md#is-it-working)) |
| `ads-regional` | Ad servers of non-English sites and apps | Non-English sites themselves (Baidu, Yandex, Naver, Trendyol, Shahid... stay reachable) |
| `mobile-ads` | In-app ad networks | The apps themselves |
| `mobile-spyware` | Phone-maker and app telemetry | Phone updates, app stores, sign-in |
| `youtube-ads` | Google/YouTube ad servers | YouTube itself; most video ads still play ([why](../README.md#lists)) |
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

<div align="right"><a href="#contents">↑ Back to top</a></div>

## List notes

<div align="right"><a href="#contents">↑ Back to top</a></div>

### live-streaming

Covers Bigo Live, Likee, MICO, SUGO, Poppo, Chamet and ~45 similar paid live-stream,
video-chat and voice-party apps. App domains were researched from each app's Google Play listing, and their server names
are re-discovered every week from public certificate logs ([`apps/live-streaming.json`](../apps/live-streaming.json)).
Some apps can also connect by IP address, which a DNS blocker can't see. For the strongest block:

| Setup | Add these |
|---|---|
| **AdGuard Home** | `adblock/live-streaming.txt` **and** `ips/live-streaming-adguard.txt` (blocks any server name that points into Bigo's own network, even new ones) |
| **Pi-hole v6** | `adblock/live-streaming.txt` |
| **Pi-hole v5** | `live-streaming.txt` (plain) |
| **Router / firewall** (optional, extra) | the IP lists, see [Blocking by IP address](#blocking-by-ip-address-ips) |

Only Bigo runs its own network. The other apps use shared clouds (Alibaba, Amazon, Cloudflare...), so their IPs are not
listed: blocking them would break normal websites. Pi-hole can't block by IP, which is why the router option exists.
Also block the app installs with your phone's parental controls (Google Family Link / Apple Screen Time).
To add an app, put its domains in `apps/live-streaming.json` and push. `dating`, `gaming-platforms`, `video-streaming` and `messaging` work the same way with their own file in [`apps/`](../apps/).

<div align="right"><a href="#contents">↑ Back to top</a></div>

### security-strict

Besides domains, it blocks whole spam-heavy web-address endings such as `.zip` and `.mov`
(with exceptions for known legitimate sites). Those ending rules only exist in the **adblock** version and are fully
supported by AdGuard Home; Pi-hole may skip them, but the rest of the list still works there.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### adult: Safe Search

A block list can't stop explicit images from appearing in Google/Bing image search.
In AdGuard Home, also turn on **Settings → General settings → Enforce Safe Search** (and Safe Browsing).

<div align="right"><a href="#contents">↑ Back to top</a></div>

### YouTube ads

YouTube serves most video ads from the same servers as the videos (`googlevideo.com`),
so no DNS blocker (Pi-hole or AdGuard Home) can remove them all. `youtube-ads` blocks the separate Google/YouTube ad and
ad-tracking servers (using AdGuard's own DNS rules) and keeps AdGuard's exceptions, so clicking Google's sponsored search
results still works. That stops some ads, mostly in apps, on smart TVs and on other websites. To remove every YouTube ad,
use a browser ad blocker such as uBlock Origin or AdGuard, or YouTube Premium. Those work inside the page: small scripts
remove the ad instructions (`adPlacements`, `playerAds`, `adSlots`) from the video data before YouTube's player reads
them, and hide leftover ad boxes. A DNS blocker only sees server names, so it can't do that.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

**pfSense (pfBlockerNG)** ([full router guide](routers.md#pfsense)): Firewall → pfBlockerNG → **IP → IPv4** → Add → paste the `-ipv4.txt` link as the source,
Action *Deny Both*, Update frequency *Once a day* → Save, then run **Update → Force Update**. Repeat under **IPv6** with
`-ipv6.txt`.

**OPNsense** ([full router guide](routers.md#opnsense)): Firewall → **Aliases** → + → Type *URL Table (IPs)*, Content: the `live-streaming.txt` link, Refresh
frequency 1 day → Save → Apply. Then Firewall → **Rules → LAN** → + → Action *Block*, Destination: the alias → Save →
Apply.

**OpenWrt** ([full router guide](routers.md#openwrt)): with the **banIP** package, add the `-ipv4.txt` / `-ipv6.txt` links as custom feeds (see the banIP docs for
your OpenWrt version).

**MikroTik** ([full router guide](routers.md#mikrotik)): import [`ips/live-streaming-mikrotik.rsc`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-mikrotik.rsc), which fills an address list named `live-streaming`, then block that list in the forward chain.

**Ubiquiti EdgeRouter** ([full router guide](routers.md#ubiquiti-edgerouter)): paste [`ips/live-streaming-edgeos.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/ips/live-streaming-edgeos.txt) in configure mode to create the network group `live-streaming`, then drop it in your `LAN_IN` firewall.

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

<div align="right"><a href="#contents">↑ Back to top</a></div>
