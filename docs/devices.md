# Single devices, phones and browsers

[← README](../README.md) · [Lists explained](lists.md) · [Devices](devices.md) · [Routers](routers.md) · [Servers & NAS](servers.md) · [TVs & consoles](tv-and-consoles.md) · [Troubleshooting](troubleshooting.md)

## Contents

<!-- TOC:START -->
- [Use on one device, without Pi-hole or AdGuard Home](#use-on-one-device-without-pi-hole-or-adguard-home)
  - [macOS](#macos)
  - [Windows 10 / 11](#windows-10--11)
  - [Linux](#linux)
  - [Android](#android)
  - [iPhone and iPad](#iphone-and-ipad)
  - [Chromebook](#chromebook)
- [YouTube ads in the browser](#youtube-ads-in-the-browser)
- [Away from home](#away-from-home)
  - [Option A: Tailscale (easiest, free for personal use)](#option-a-tailscale-easiest-free-for-personal-use)
  - [Option B: encrypted DNS from AdGuard Home](#option-b-encrypted-dns-from-adguard-home)
<!-- TOC:END -->

## Use on one device, without Pi-hole or AdGuard Home

Don't have a Pi-hole or AdGuard Home? These scripts block the lists you choose on a single computer or phone by adding
them to the device's **hosts file** (a built-in system file that maps names to addresses). Each script shows a menu of
every list above, lets you pick one or several, backs up your original hosts file, and can update itself every day.

| System | Script | How it blocks |
|---|---|---|
| macOS | [`install/macos.sh`](../install/macos.sh) | hosts file, daily update via launchd |
| Windows 10/11 | [`install/windows.ps1`](../install/windows.ps1) | hosts file, daily update via Task Scheduler |
| Linux | [`install/linux.sh`](../install/linux.sh) | hosts file, daily update via cron or systemd |
| Android | [`install/android.sh`](../install/android.sh) (in Termux) | rooted: hosts file. Not rooted: sets you up with the free AdAway app |
| Ubiquiti EdgeRouter | [`install/edgerouter.sh`](../install/edgerouter.sh) | the router's DNS (dnsmasq) for every device, daily update via the task scheduler; see [EdgeRouter](routers.md#ubiquiti-edgerouter) |
| iPhone / iPad | no script possible (see [iPhone and iPad](#iphone-and-ipad)) | your AdGuard Home / Pi-hole, the AdGuard app, AdGuard DNS, or Screen Time |

**Good to know before you start**
- Pick only what you need. The hosts file has no wildcards, so every server name is listed one by one.
  - **macOS and Linux** handle big lists fine: `ads-and-tracking` + `security` is a good start.
  - **Windows gets slow above ~150,000 names** (the script warns you), so pick smaller lists there, such as
    `mobile-ads`, `smart-tv`, `youtube-ads`, `live-streaming` or `dating`. For the big ad and security lists on Windows,
    run [AdGuard Home on the PC](servers.md#adguard-home-on-a-windows-or-mac-computer) instead: it handles millions of names and
    can protect just that PC.
- It works in every app. A browser set to its own "secure DNS" may skip it; see [Is it working?](troubleshooting.md#is-it-working), step 3.
- It only protects the device you run it on. To protect every device at home at once, use Pi-hole or AdGuard Home.
- Your original hosts file is saved once as `hosts.block-lists-backup` next to it, and `--remove` / `-Remove` takes out
  only what the script added.
- Afterwards, check it with [Is it working?](troubleshooting.md#is-it-working).

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Linux

```bash
curl -fsSLO https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/install/linux.sh     # or: wget https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/install/linux.sh
sudo bash linux.sh
```
Then follow the same menu as on macOS. The same `--update`, `--remove`, `--lists`, `--auto-update` options work.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Chromebook

ChromeOS doesn't let scripts change its hosts file, so point it at a blocker instead:
- **At home:** **Settings → Network → Wi-Fi** → your network → **Network** → **Name servers** → **Custom name servers** →
  enter your AdGuard Home / Pi-hole IP address. (If your router already hands out the blocker, there's nothing to do.)
- **Away from home:** install the **Tailscale** app from the Play Store and follow [Away from home](#away-from-home), or
  use Chrome's **Settings → Privacy and security → Security → Use secure DNS → With: Custom** with an encrypted
  AdGuard Home address (`https://<your AdGuard Home>/dns-query`).
- School or work Chromebooks are managed by an administrator, who may block these settings.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

## Away from home

Phones and laptops are only protected while they use your home network. To keep the same blocking on mobile data, at
work or while travelling, connect them back to your AdGuard Home / Pi-hole.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Option B: encrypted DNS from AdGuard Home

AdGuard Home can serve encrypted DNS (DNS-over-HTTPS and DNS-over-TLS) to devices anywhere. This needs a domain name, a
certificate (**Settings → Encryption settings**) and ports 443/853 forwarded to it from your router, so it's for more
experienced users. Devices then use:
- **Android:** **Settings → Network & internet → Private DNS** → your AdGuard Home hostname.
- **iPhone / iPad:** the profile from **Setup Guide → DNS Privacy → iOS** (see [iPhone and iPad](#iphone-and-ipad)).
- **Browsers / Chromebooks:** **Use secure DNS** with `https://<your hostname>/dns-query`.

Pi-hole has no encrypted DNS of its own: use Option A.

<div align="right"><a href="#contents">↑ Back to top</a></div>
