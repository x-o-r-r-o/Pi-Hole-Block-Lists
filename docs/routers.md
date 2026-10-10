# Routers

[← README](../README.md) · [Lists explained](lists.md) · [Devices](devices.md) · [Routers](routers.md) · [Servers & NAS](servers.md) · [TVs & consoles](tv-and-consoles.md) · [Troubleshooting](troubleshooting.md)

## Contents

<!-- TOC:START -->
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
<!-- TOC:END -->

## UniFi Cloud Gateway (UCG Ultra / Max / Fiber, UDM, UDR)

UniFi's built-in **Ad Blocking** uses Ubiquiti's own list only, and its **Content Filter** block list can't subscribe to a
list by link (you paste or upload entries, and they don't update themselves). So there are two ways to use these lists:

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Option 1 (recommended): UniFi + AdGuard Home or Pi-hole, updates automatically

Run AdGuard Home or Pi-hole on any always-on device (a Raspberry Pi, a NAS, a mini PC or Docker), add the lists you want
(see [How to add a list](../README.md#how-to-add-a-list)), then make UniFi hand it out as the DNS server:

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Option 2: UniFi only, no extra device (manual updates)

The [`unifi/`](../unifi/) folder has every list in the format UniFi's content filter expects: one domain per line, no
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

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
7. Optional, block by IP: add the [IP lists](lists.md#blocking-by-ip-address-ips) under **pfBlockerNG → IP → IPv4 / IPv6**.

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
   If a site breaks, add it under **Allowlist Domains** (and [report it](troubleshooting.md#something-broke)).

**Option B: AdGuard Home on another device.** Add the adblock links in AdGuard Home, then set your LAN's DHCP service
(**Services → ISC DHCPv4 → LAN**, or **Dnsmasq DNS & DHCP** / **Kea DHCP** on newer versions) to hand out the AdGuard
Home IP address as the DNS server, and reconnect your devices. (Community plugins can run AdGuard Home on OPNsense
itself, but they're not official.)

**Stop devices from going around it (both options):** **Firewall → NAT → Port Forward → +**: Interface *LAN*, Protocol
*TCP/UDP*, Destination tick **Destination / Invert** and choose *This Firewall*, Destination port *DNS*, Redirect target
IP *127.0.0.1* (Option B: the AdGuard Home IP, and set **Source** to *Invert* + the AdGuard Home IP so it can still
reach the internet), Redirect target port *DNS*, Filter rule association *Add associated filter rule* → Save → Apply. Then **Firewall → Rules → LAN → +**: Action *Block*, Protocol *TCP/UDP*, Destination port
*853* → Save → Apply. Also add the `vpn-proxy-bypass` list.

**Block by IP (optional):** see the OPNsense steps under [Blocking by IP address](lists.md#blocking-by-ip-address-ips).

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
[How to add a list](../README.md#how-to-add-a-list)). Follow the OpenWrt wiki's *AdGuard Home* page to make the router's DNS (dnsmasq)
forward to it, so every device is covered.

**Stop devices from going around it:** with adblock-fast, *Force Router DNS* (step 4) redirects normal DNS. For both
options, also add the `vpn-proxy-bypass` list: encrypted DNS (DoH/DoT) can't be redirected, only blocked.

**Block by IP (optional):** install **luci-app-banip** and add the [IP list](lists.md#blocking-by-ip-address-ips) links as
custom feeds.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
   (and [report it](troubleshooting.md#something-broke)).

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Ubiquiti EdgeRouter

For EdgeRouters running **EdgeOS 2.x** (ER-X, ER-X-SFP, ER-4, ER-6P, ER-8, ER-12...). For UniFi gateways, see
[UniFi Cloud Gateway](#unifi-cloud-gateway-ucg-ultra--max--fiber-udm-udr) instead. EdgeOS has no block-list feature of its
own, so [`install/edgerouter.sh`](../install/edgerouter.sh) adds one: it downloads the lists you pick into `/config` (kept
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

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Asus

- **Asus "AI" routers** (e.g. GT-BE19000AI) have AdGuard Home built in: install it from the AI Board section of the web
  interface, open `http://<AI Board hostname>:3000`, add the adblock links under **Filters → DNS blocklists**, then set
  **LAN → DHCP Server → DNS and WINS Server Setting** to its address (see Asus's
  [AdGuard Home guide](https://www.asus.com/support/faq/1055942)).
- **Other Asus routers (stock firmware):** they can't load lists. Run AdGuard Home or Pi-hole on another device
  ([Raspberry Pi](servers.md#raspberry-pi), [Docker](servers.md#docker), a NAS...) and set **LAN → DHCP Server → DNS and WINS Server Setting
  → DNS Server** to its IP address → **Apply**. Asus's built-in *AiProtection* uses Asus's own filters, not these lists.
- **Asuswrt-Merlin** (community firmware): the **Diversion** add-on (installed through `amtm` over SSH) brings dnsmasq-based
  ad blocking to the router itself; see [diversion.ch](https://diversion.ch).

After changing DNS, reach the router by its IP address (e.g. `http://192.168.50.1`) if `www.asusrouter.com` stops loading.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Any other router (TP-Link, Netgear, Fritz!Box, internet-provider routers)

These can't load block lists, but you can make every device use your blocker (AdGuard Home or Pi-hole on a
[Raspberry Pi](servers.md#raspberry-pi), [Docker](servers.md#docker), a NAS or [Home Assistant](servers.md#home-assistant)). Look in the router's
**LAN / DHCP** settings for a **DNS server** field and enter the blocker's IP address. If there's a second DNS field, leave
it empty or repeat the same address; a public DNS server there lets devices skip the blocking. Typical places:

| Router | Where |
|---|---|
| **TP-Link** (Archer, Deco) | Archer: **Advanced → Network → DHCP Server → Primary DNS**. Deco app: **More → Advanced → DHCP Server → DNS** (newer models) |
| **Netgear** (Nighthawk, Orbi) | Usually no LAN DNS field: use **Advanced → Setup → Internet Setup → Domain Name Server (DNS) Address → Use These DNS Servers** and enter the blocker's IP (all queries then appear to come from the router) |
| **Fritz!Box** | **Home Network → Network → Network Settings → IP Addresses → IPv4 Settings → Local DNS server** |
| **Internet-provider routers** | Often locked. If there's no DNS field, turn **off** the router's DHCP and turn it **on** in AdGuard Home (**Settings → DHCP settings**) or Pi-hole (**Settings → DHCP**) |

Save, then reconnect your devices (turn Wi-Fi off and on). Menu names vary by model and firmware.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Starlink, 4G and 5G home routers

- **Starlink:** check the Starlink app for a **Custom DNS** option first (Settings) and enter the blocker's IP there. If
  your router doesn't offer it, turn on **Bypass mode** (Starlink app → Settings → Router) and use your own router behind
  it, then follow that router's section. Gen 2 kits need Starlink's Ethernet adapter for this; undoing bypass mode
  requires a factory reset of the Starlink router.
- **4G / 5G home routers** (Huawei, ZTE, Netgear Nighthawk M-series, provider-branded): look for DNS under **DHCP** /
  **LAN** settings. If there's none, either turn off the router's DHCP and let AdGuard Home / Pi-hole hand out addresses,
  or put the router in **bridge / IP passthrough** mode and use your own router behind it.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### TP-Link Omada and other business gateways

Omada gateways can't load these lists, but they can hand out your blocker as the DNS server: in the Omada controller
(software, OC200/OC300 or cloud) → **Settings → Wired & Wireless Networks → LAN** → edit your network → **DHCP Server**
(under advanced settings) → **DNS Server: Manual** → enter the AdGuard Home / Pi-hole IP → **Save**. Repeat for each
network (VLAN). To stop devices going around it, add an ACL (**Settings → Network Security → ACL**) blocking LAN → WAN
traffic to ports 53 and 853 except from the blocker. Other business gateways (Sophos, Fortinet, Cisco...) work the same
way: set the DNS server their DHCP hands out, and block outgoing DNS from everything else.

<div align="right"><a href="#contents">↑ Back to top</a></div>
