# Smart TVs and game consoles

[← README](../README.md) · [Lists explained](lists.md) · [Devices](devices.md) · [Routers](routers.md) · [Servers & NAS](servers.md) · [TVs & consoles](tv-and-consoles.md) · [Troubleshooting](troubleshooting.md)

## Contents

<!-- TOC:START -->
- [Smart TVs and streaming sticks](#smart-tvs-and-streaming-sticks)
  - [Step 1: block the TV's ad and tracking servers](#step-1-block-the-tvs-ad-and-tracking-servers)
  - [Step 2: turn off viewing data and ad tracking on the TV](#step-2-turn-off-viewing-data-and-ad-tracking-on-the-tv)
  - [Step 3: stop devices that ignore your DNS](#step-3-stop-devices-that-ignore-your-dns)
  - [What to expect](#what-to-expect)
- [Game consoles](#game-consoles)
  - [Step 1: block console ads and telemetry](#step-1-block-console-ads-and-telemetry)
  - [Step 2: turn off tracking and ads in the console's settings](#step-2-turn-off-tracking-and-ads-in-the-consoles-settings)
  - [What to expect](#what-to-expect-1)
<!-- TOC:END -->

## Smart TVs and streaming sticks

Smart TVs (Samsung, LG, Sony, TCL, Hisense, Vizio, Philips) and streaming sticks (Roku, Fire TV, Chromecast / Google TV,
Apple TV) show ads on their home screens and report what you watch. TVs can't run our scripts, so block at the network
and turn off tracking in the TV's own settings. Do both: the settings stop the TV collecting data, the block list stops
what it still tries to send.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 1: block the TV's ad and tracking servers

Add these lists to the DNS blocker your TV uses:
- [`smart-tv`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/smart-tv.txt): tracking and ads of Samsung, LG webOS, Roku, Amazon Fire TV, Android/Google TV
  and game consoles (for consoles see [Game consoles](#game-consoles)).
- [`ads-and-tracking`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking.txt): ads inside free TV apps and ad-supported channels.
- Optional: [`youtube-ads`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/youtube-ads.txt) (blocks some ad tracking; see the YouTube note above).

Where to add them, from best to simplest:
1. **AdGuard Home or Pi-hole on your network** (see [How to add a list](../README.md#how-to-add-a-list)). Every TV, stick and console
   in the house is covered. On UniFi, follow [Option 1](routers.md#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically).
2. **Only the TV:** in the TV's network settings, change DNS from automatic to manual and enter your AdGuard Home /
   Pi-hole IP address. The path is usually **Settings → Network (or General → Network) → Network status / Advanced /
   IP settings → DNS → Manual**.
3. **No blocker at home:** enter AdGuard's free public ad-blocking DNS on the TV (`94.140.14.14` and `94.140.15.15`). It
   doesn't use these lists, but blocks common ads and trackers with no setup.
4. **UniFi without AdGuard Home:** upload [`unifi/smart-tv.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/unifi/smart-tv.txt) as in
   [Option 2](routers.md#option-2-unifi-only-no-extra-device-manual-updates).

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 3: stop devices that ignore your DNS

Some devices use Google's DNS (`8.8.8.8`) directly instead of the one your router gives them; Chromecast and many
Google TV / Android TV models do this. Block outgoing DNS (port 53 and 853) on your router for everything except your
AdGuard Home / Pi-hole: the device then falls back to your blocker. On UniFi this is
[Option 1, step 3](routers.md#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically); on other routers look
for firewall rules or "DNS redirect". Add the `vpn-proxy-bypass` list too, so encrypted-DNS servers are blocked as well.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### What to expect

- **Gone or reduced:** viewing-data reporting, home-screen ad banners and sponsored rows on many models, tracking in
  free apps and ad-supported channels.
- **Not blockable by DNS:** ads inside YouTube, Netflix, Prime Video, Disney+ and similar apps (they come from the same
  servers as the shows), and ads the TV maker serves from the same servers as essential features.
- **If something breaks** (the home screen won't load, an app or a free channel stops working, updates fail): open your
  AdGuard Home / Pi-hole **query log**, filter by the TV's IP address, find the blocked name that appeared when it
  broke, and allow it (in AdGuard Home / Pi-hole; see [Something broke?](troubleshooting.md#something-broke)).
  Samsung TV Plus, LG Channels and The Roku Channel are free channels paid for by ads; they may stop playing when their
  ad servers are blocked.

<div align="right"><a href="#contents">↑ Back to top</a></div>

## Game consoles

PlayStation, Xbox and Nintendo Switch show ads and sponsored tiles in their menus and send play data ("telemetry") back
to Sony, Microsoft and Nintendo. Consoles can't run our scripts either, so the setup is like the smart TV one: block at
the network, then turn tracking off in the console's settings.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 1: block console ads and telemetry

Add these lists to the DNS blocker your console uses:
- [`game-consoles`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/game-consoles.txt): menu ads (PlayStation, Xbox) and telemetry (PlayStation, Nintendo
  Switch, Xbox error reporting). Small on purpose so sign-in, the store, updates and online play keep working.
- [`ads-and-tracking`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/adblock/ads-and-tracking.txt): ads and trackers in the console's web browser, media apps
  and free-to-play games.

Where to add them:
1. **AdGuard Home or Pi-hole on your network** (see [How to add a list](../README.md#how-to-add-a-list)); on UniFi follow
   [Option 1](routers.md#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically). Covers every console at home.
2. **Only the console:** set its DNS to your AdGuard Home / Pi-hole IP address (or AdGuard's free public DNS,
   `94.140.14.14` and `94.140.15.15`, if you have no blocker; it doesn't use these lists):
   - **PlayStation 5:** Settings → Network → Settings → Set Up Internet Connection → highlight your network → press
     Options → Advanced Settings → DNS Settings: **Manual**.
   - **Xbox Series X|S / One:** Settings → General → Network settings → Advanced settings → DNS settings: **Manual**.
   - **Nintendo Switch:** System Settings → Internet → Internet Settings → choose your network → Change Settings →
     DNS Settings: **Manual**.
3. **UniFi without AdGuard Home:** upload [`unifi/game-consoles.txt`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/unifi/game-consoles.txt) as in
   [Option 2](routers.md#option-2-unifi-only-no-extra-device-manual-updates).

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 2: turn off tracking and ads in the console's settings

Menu names change with system updates; if a path doesn't match, look for *privacy*, *data*, *diagnostics* or *ads*.

| Console | What to change |
|---|---|
| **PlayStation 5** | Settings → Users and Accounts → Privacy: set **Data You Provide** to **Limited**, and turn off personalised recommendations and ads under **Personalization** |
| **Xbox** | Settings → Account → Privacy & online safety: share only **required** diagnostic data. Personalised ads are set on your Microsoft account at [account.microsoft.com/privacy/ad-settings](https://account.microsoft.com/privacy/ad-settings) |
| **Nintendo Switch** | Lock-screen eShop ads: System Settings → System → News Channel Settings → Nintendo News → **Unfollow**. Marketing use of your data: your Nintendo Account settings at [accounts.nintendo.com](https://accounts.nintendo.com) |

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
  blocked name from when it broke and allow it (right away in the blocker; see [Something broke?](troubleshooting.md#something-broke)).

<div align="right"><a href="#contents">↑ Back to top</a></div>
