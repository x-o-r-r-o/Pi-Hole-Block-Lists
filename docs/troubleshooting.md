# Troubleshooting

[← README](../README.md) · [Lists explained](lists.md) · [Devices](devices.md) · [Routers](routers.md) · [Servers & NAS](servers.md) · [TVs & consoles](tv-and-consoles.md) · [Troubleshooting](troubleshooting.md)

## Contents

<!-- TOC:START -->
- [Is it working?](#is-it-working)
- [Troubleshooting FAQ](#troubleshooting-faq)
- [Something broke?](#something-broke)
<!-- TOC:END -->

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
  [Away from home](devices.md#away-from-home)).
- **iPhone iCloud Private Relay:** **Settings → [your name] → iCloud → Private Relay**: off, or switch it off for your
  home Wi-Fi network.
- **VPN apps** and devices with hard-coded DNS: see [Smart TVs, step 3](tv-and-consoles.md#step-3-stop-devices-that-ignore-your-dns) and add
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

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
Use the **raw** links from the [Lists](../README.md#lists) table (they start with `https://raw.githubusercontent.com/`), not the
GitHub page address. Pi-hole v5 needs the **Plain** link; Pi-hole v6 and AdGuard Home take the **Adblock** link. Check
the blocker itself has internet access, then update the lists again.

**Why does the Adblock version have fewer entries than the Plain one?**
That's normal: one adblock rule such as `||example.com^` also covers all its subdomains, so they don't need their own
lines.

**I still see ads on YouTube, Facebook, Instagram, Twitch or Spotify.**
Those services deliver ads from the same servers as their content, so DNS blocking can't separate them. Use a browser ad
blocker for the websites (see [YouTube ads in the browser](devices.md#youtube-ads-in-the-browser)) or the paid ad-free plans for
the apps.

**A site, app, email link or shopping link stopped working.**
See [Is it working?](#is-it-working) step 4 and [Something broke?](#something-broke).

**Children still get around the blocks.**
DNS blocking only works on your network: on **mobile data** or a friend's hotspot it doesn't apply, so also use the
phone's parental controls (Google Family Link, Apple Screen Time). Add `vpn-proxy-bypass` against VPN apps and encrypted
DNS, block outside DNS on the router ([Smart TVs, step 3](tv-and-consoles.md#step-3-stop-devices-that-ignore-your-dns)), and apply the
stricter lists only to the children's devices (AdGuard Home **Settings → Client settings**, Pi-hole **Group
Management**). Private / incognito browser windows don't get around DNS blocking.

**"Port 53 is already in use" when installing.**
Something else answers DNS on that device. See [Docker, step 2](servers.md#step-2-free-port-53-ubuntu-and-debian-servers) (Linux),
[TrueNAS](servers.md#truenas), [Synology, step 1](servers.md#step-1-prepare-the-nas), [QNAP](servers.md#qnap-nas), or
[AdGuard Home on Windows](servers.md#adguard-home-on-a-windows-or-mac-computer).

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

**My problem isn't here.** [Open an issue](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/issues/new/choose) describing your setup (blocker, router, device) and what happens.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
3. **Report it:** [open a "blocked that shouldn't be" issue](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/issues/new?template=false-positive.yml) with the domain name and what broke, so it can be added to the shared
   [`allowlist.txt`](../allowlist.txt) and removed from the lists for everyone on the next daily build.

Essential sites (Google, Microsoft, Apple, WhatsApp, PayPal, big CDNs, common link shorteners...) are listed in
[`protected.txt`](../protected.txt). Every build removes them from all lists automatically, unless a list is meant to block
them (set with `may_block` in `lists.json`, e.g. `social-media` may block Facebook). This stops a mistake in an upstream
source from breaking those sites.

<div align="right"><a href="#contents">↑ Back to top</a></div>
