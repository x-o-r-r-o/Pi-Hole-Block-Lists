# Raspberry Pi, Docker, NAS and servers

[← README](../README.md) · [Lists explained](lists.md) · [Devices](devices.md) · [Routers](routers.md) · [Servers & NAS](servers.md) · [TVs & consoles](tv-and-consoles.md) · [Troubleshooting](troubleshooting.md)

## Contents

<!-- TOC:START -->
- [Raspberry Pi](#raspberry-pi)
  - [Step 1: set up the Pi](#step-1-set-up-the-pi)
  - [Step 2: install AdGuard Home or Pi-hole](#step-2-install-adguard-home-or-pi-hole)
  - [Step 3: use it for the whole home](#step-3-use-it-for-the-whole-home)
- [Docker](#docker)
  - [Step 1: install Docker and download AdGuard Home or Pi-hole](#step-1-install-docker-and-download-adguard-home-or-pi-hole)
  - [Step 2: free port 53 (Ubuntu and Debian servers)](#step-2-free-port-53-ubuntu-and-debian-servers)
  - [Step 3: start it](#step-3-start-it)
  - [Step 4: use it for the whole home](#step-4-use-it-for-the-whole-home)
- [Synology NAS](#synology-nas)
  - [Step 1: prepare the NAS](#step-1-prepare-the-nas)
  - [Step 2: run AdGuard Home](#step-2-run-adguard-home)
  - [Step 3: use it for the whole home](#step-3-use-it-for-the-whole-home-1)
- [QNAP NAS](#qnap-nas)
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
- [Proxmox VE](#proxmox-ve)
  - [Step 1: create the container](#step-1-create-the-container)
  - [Step 2: install AdGuard Home or Pi-hole](#step-2-install-adguard-home-or-pi-hole-1)
  - [Step 3: use it for the whole home, and keep it safe](#step-3-use-it-for-the-whole-home-and-keep-it-safe)
- [Home Assistant](#home-assistant)
- [AdGuard Home on a Windows or Mac computer](#adguard-home-on-a-windows-or-mac-computer)
- [Technitium DNS Server](#technitium-dns-server)
<!-- TOC:END -->

## Raspberry Pi

A Raspberry Pi is the classic way to run **Pi-hole** or **AdGuard Home** for the whole home: small, quiet and cheap to
leave on. Any Pi 3, 4, 5 or Zero 2 W works. Use a wired network cable if you can.

**How many lists fit:** a Zero 2 W (512 MB) is fine with a few lists (roughly 500,000 names in total, e.g.
`ads-and-tracking` + `mobile-ads` + `smart-tv`); a Pi 3 (1 GB) handles about a million (e.g. `ads-and-tracking` +
`security`); a Pi 4 or 5 with 2 GB or more handles the big combinations such as `ads-and-tracking-extended` + `security`
+ `adult`.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 2: install AdGuard Home or Pi-hole

Pick one.

**AdGuard Home** (official installer):
```bash
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
```
Then open `http://192.168.1.2:3000` (your Pi's address) and follow the setup wizard: keep the DNS server on port 53,
choose the admin web port (80 is fine on a Pi) and create your username and password. Add lists under **Filters → DNS
blocklists** with the adblock links ([How to add a list](../README.md#how-to-add-a-list)).

**Pi-hole** (official installer):
```bash
curl -sSL https://install.pi-hole.net | bash
```
Answer the questions (the defaults are fine; choose any upstream DNS provider). Set the web password with
`sudo pihole setpassword`, then open `http://192.168.1.2/admin`. Add lists under **Lists** with the adblock links
(Pi-hole v6) and run **Tools → Update Gravity**.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 3: use it for the whole home

1. In your router's DHCP / LAN settings, set the **DNS server** to the Pi's address, save, and reconnect your devices
   (turn Wi-Fi off and on, or restart them; otherwise they can take up to a day to pick up the change). Find your
   router's menu in [Routers](routers.md#routers); UniFi users:
   [Option 1](routers.md#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically).
   - If the router asks for a **second DNS server**, enter the same address again or a second blocker. **Don't** put a
     public DNS server (8.8.8.8, 1.1.1.1...) there: devices use both at random, and would skip the blocking part of the
     time.
2. **Router won't let you change DNS** (common on internet-provider routers)? Let the Pi hand out addresses instead:
   turn **off** DHCP on the router, then turn it **on** in AdGuard Home (**Settings → DHCP settings**) or Pi-hole
   (**Settings → DHCP**). Every device then gets the Pi as its DNS server automatically.
3. Stop devices from going around it with your router's firewall if it can (see the [router guides](routers.md#routers))
   and the `vpn-proxy-bypass` list.
4. Check it works: the dashboard should show queries and blocked requests within a few minutes; then run the checks in
   [Is it working?](troubleshooting.md#is-it-working).

**Keeping it updated:** the lists update by themselves. Update the Pi now and then with
`sudo apt update && sudo apt full-upgrade -y`; update AdGuard Home from its web page when it offers a new version, or
Pi-hole with `pihole -up`.

**Good to know:** if the Pi is off, DNS stops working at home unless there's a second DNS server. A public DNS server as
backup would let some lookups skip the lists, so a second Pi (or the [Synology NAS](#synology-nas) setup) is the better
backup. To use the same blocking away from home on phones, see [iPhone and iPad](devices.md#iphone-and-ipad) and
[Android](devices.md#android).

<div align="right"><a href="#contents">↑ Back to top</a></div>

## Docker

Run AdGuard Home or Pi-hole in Docker on any always-on computer: a Linux server or mini PC, or a NAS / home server with
Docker. OpenMediaVault, QNAP and Unraid users: see [OpenMediaVault](#openmediavault), [QNAP NAS](#qnap-nas) and [Unraid](#unraid); Proxmox users: see [Proxmox VE](#proxmox-ve); TrueNAS users: see [TrueNAS](#truenas). Ready-made files are in [`docker/`](../docker/); they're tested
automatically on every change. (Synology users: see [Synology NAS](#synology-nas).)

Commands below use `sudo docker`; you can leave out `sudo` if your user is in the `docker` group.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 3: start it

In the folder from step 1 run `sudo docker compose up -d`. Then:
- **AdGuard Home:** open `http://<server IP>:3000` and follow the setup wizard (keep the admin web interface on port
  **3000** and the DNS server on port **53**), then add the lists ([How to add a list](../README.md#how-to-add-a-list)).
- **Pi-hole:** open `http://<server IP>:8081/admin`, sign in with the password from `.env`, add the lists under **Lists**,
  then **Tools → Update Gravity**.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 4: use it for the whole home

Follow [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home): set the server's IP as the DNS server in your router
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

<div align="right"><a href="#contents">↑ Back to top</a></div>

## Synology NAS

A Synology NAS is on all the time, which makes it a good home for **AdGuard Home** (or Pi-hole): it filters DNS for every
device in the house, and you then add these lists to it. This uses Synology's **Container Manager** (DSM 7.2 or newer, on
models that support it; older DSM calls it *Docker*).

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 1: prepare the NAS

1. Give the NAS a fixed IP address, so devices can always find it: **Control Panel → Network → Network Interface** →
   select your LAN → **Edit** → **IPv4** → *Use manual configuration* (or reserve its address in your router).
2. **Package Center** → install **Container Manager**.
3. **File Station** → open the `docker` shared folder (Container Manager creates it; otherwise **Control Panel → Shared
   Folder → Create** → `docker`) → create a folder `adguardhome`, and inside it `work` and `conf`.
4. Make sure nothing else uses port 53: if the **DNS Server** package is installed, stop or uninstall it.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
3. Add the lists you want ([How to add a list](../README.md#how-to-add-a-list)), using the adblock links.

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 3: use it for the whole home

1. If the NAS firewall is on (**Control Panel → Security → Firewall**), allow **port 53 (TCP and UDP)** and the admin port
   (3000, or 8081 for Pi-hole) from your local network.
2. In your router's DHCP settings, set the **DNS server** to the NAS's IP address (UniFi:
   [Option 1](routers.md#option-1-recommended-unifi--adguard-home-or-pi-hole-updates-automatically); other routers: look for
   *DHCP* or *LAN* settings). Then reconnect your devices.
3. Stop devices from going around it with your router's firewall (see your router's section above) and the
   `vpn-proxy-bypass` list.
4. Updates: AdGuard Home / Pi-hole refresh the lists by themselves. To update AdGuard Home or Pi-hole itself, go to
   **Container Manager → Project** → select it → **Action → Build** (it pulls the latest image).

**Good to know:** while the NAS is off or restarting, DNS stops working at home unless your router has a second DNS
server; adding a public one as backup means some lookups will skip the block lists, so a second AdGuard Home / Pi-hole
(for example on a Raspberry Pi) is the better backup.

<div align="right"><a href="#contents">↑ Back to top</a></div>

## QNAP NAS

On a QNAP NAS, use **Container Station** (version 3) with our ready-made Compose files.

1. **App Center** → install **Container Station** and open it.
2. **Applications → Create**: application name `adguardhome` (or `pihole`), paste
   [`docker/adguardhome/compose.yaml`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/adguardhome/compose.yaml)
   (or [`docker/pihole/compose.yaml`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/pihole/compose.yaml): replace `${PIHOLE_PASSWORD:-change-me}` with
   your own password and `${TZ:-UTC}` with your time zone) → **Validate YAML**
   → **Create**. Container Station keeps the files under `/share/Container/container-station-data/application/<name>`.
3. Open `http://<NAS IP>:3000` (AdGuard Home setup wizard: keep the admin port 3000 and DNS on 53) or
   `http://<NAS IP>:8081/admin` (Pi-hole), and add the lists ([How to add a list](../README.md#how-to-add-a-list)).
4. If the container won't start because **port 53** is in use (another app or QNAP service on the NAS uses it), give the
   container its own IP address on your network instead of publishing ports: in Container Station's network settings use
   a **bridge / qnet** network with a fixed IP, and remove the `ports:` lines.
5. Give the NAS (or the container) a fixed IP, then follow [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home).
   Update later from **Applications** → the app → **Update** (or recreate it, which pulls the latest image).

<div align="right"><a href="#contents">↑ Back to top</a></div>

## TrueNAS

For **TrueNAS Community Edition / SCALE 24.10 or newer** (the Linux-based TrueNAS, whose Apps run on Docker). TrueNAS CORE
(FreeBSD) isn't covered: use another device or a VM. Menu names below are from 25.04 / 25.10 and may move between
releases.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 1: prepare TrueNAS

1. Make sure TrueNAS has a fixed IP address (it usually does; check **Network → Interfaces**, or reserve its address in
   your router). Below it's `192.168.1.4`.
2. Apps need a pool: open **Apps**; if asked, **Configure → Choose Pool**.
3. Optional, to keep the settings in your own dataset: **Datasets → Add Dataset** → e.g. `apps/adguardhome` (or
   `apps/pihole`).

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
4. Add the lists with the adblock links ([How to add a list](../README.md#how-to-add-a-list)).

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 3: use it for the whole home

1. Point your network at it: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home) (router DNS or AdGuard Home /
   Pi-hole as DHCP server, stopping devices going around it). Then from a computer run
   `nslookup example.com 192.168.1.4` to confirm it answers.
2. **Updates:** the lists update themselves; when **Apps → Installed** shows *Update available* for the app, click
   **Update**.
3. **Backups:** take snapshots of the app's dataset (**Data Protection → Periodic Snapshot Tasks**), and keep a second
   DNS server (a Raspberry Pi or another NAS) so home DNS keeps working when TrueNAS restarts for updates.

<div align="right"><a href="#contents">↑ Back to top</a></div>

## Unraid

On Unraid, install AdGuard Home or Pi-hole as a Docker container from **Community Applications** and give it its own IP
address on your network, so it doesn't clash with Unraid's web interface. (Unraid 6.12 or newer; menu names may differ
slightly between versions.)

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 2: set it up

- **AdGuard Home:** open `http://192.168.1.5:3000` (its own address) and follow the setup wizard: DNS server on port
  **53**, admin web interface on port **80** (fine, because the container has its own IP), then create your username
  and password.
- **Pi-hole:** open `http://192.168.1.5/admin` and sign in.
- Add the lists with the adblock links ([How to add a list](../README.md#how-to-add-a-list)).

Unraid itself can't reach containers on `br0` unless you allow it: **Settings → Docker** → stop Docker → **Host access
to custom networks: Enabled** → Apply → start Docker. Keep Unraid's own DNS (**Settings → Network Settings**) pointing at
your router or a public DNS server, so Unraid can still download updates while the container is stopped.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 3: use it for the whole home

1. Point your network at it: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home) (router DNS or AdGuard Home /
   Pi-hole as DHCP server, stopping devices going around it).
2. **Updates:** the lists update themselves. Update the container from the **Docker** tab (**Check for Updates** →
   **apply update**), or automatically with the *CA Auto Update Applications* plugin.
3. **Backups:** the *Appdata Backup* plugin (from Apps) backs up the container's settings on a schedule.
4. If the array is stopped or Unraid restarts, the container stops too: give your router a second DNS server running
   the same lists (a Raspberry Pi or another NAS) to keep home DNS working.

<div align="right"><a href="#contents">↑ Back to top</a></div>

## OpenMediaVault

On an OpenMediaVault NAS (OMV 7), run AdGuard Home or Pi-hole with the **Compose** plugin from omv-extras, using our
ready-made files.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 2: add AdGuard Home or Pi-hole

1. Check port 53 is free (OMV's own web interface uses port 80 and doesn't need it): over SSH run
   `sudo ss -lunp | grep ':53 '`; if `systemd-resolved` shows up, apply [Docker, step 2](#step-2-free-port-53-ubuntu-and-debian-servers).
2. **Services → Compose → Files → Create (+)**: name it `adguardhome` (or `pihole`) and paste
   [`docker/adguardhome/compose.yaml`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/adguardhome/compose.yaml)
   (or [`docker/pihole/compose.yaml`](https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master/docker/pihole/compose.yaml): replace `${PIHOLE_PASSWORD:-change-me}` with
   your own password and `${TZ:-UTC}` with your time zone, e.g. `Europe/London`) → **Save**.
3. Select the file → **Up** (▲). Then open `http://<NAS IP>:3000` (AdGuard Home setup wizard: keep the admin port
   3000 and DNS on 53) or `http://<NAS IP>:8081/admin` (Pi-hole), and add the lists ([How to add a list](../README.md#how-to-add-a-list)).

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 3: use it for the whole home

Follow [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home). To update AdGuard Home / Pi-hole later: select the
file in **Services → Compose → Files** → **Pull** → **Up**.

<div align="right"><a href="#contents">↑ Back to top</a></div>

## Proxmox VE

On a Proxmox server, run AdGuard Home or Pi-hole in a small **LXC container**: it uses about 512 MB of RAM and a few GB of
disk, starts in seconds and is easy to back up. Don't install them on the Proxmox host itself.

<div align="right"><a href="#contents">↑ Back to top</a></div>

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

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
([How to add a list](../README.md#how-to-add-a-list)).

**Prefer Docker?** Create a Debian VM (or a container with **Options → Features → nesting** turned on), install Docker and
follow the [Docker](#docker) guide. **Prefer a one-click script?** The community
[Proxmox VE Helper-Scripts](https://community-scripts.github.io/ProxmoxVE/) can create an AdGuard Home or Pi-hole container
for you; they're not official, so read a script before running it on your host.

<div align="right"><a href="#contents">↑ Back to top</a></div>

### Step 3: use it for the whole home, and keep it safe

1. Point your network at it: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home) (router DNS or AdGuard Home /
   Pi-hole as DHCP server, stopping devices going around it, checking the dashboard).
2. **Backups:** **Datacenter → Backup → Add**: select the container, schedule daily or weekly. Before updating, take a
   **Snapshot** (container → *Snapshots*) so you can roll back in one click.
3. **Updates:** the lists update themselves. Update the container now and then with
   `apt update && apt full-upgrade -y`; update AdGuard Home from its web page, or Pi-hole with `pihole -up`.
4. **No single point of failure:** if the Proxmox server is off, home DNS stops. Create a second container (ideally on
   another Proxmox node, a Raspberry Pi or a NAS) with the same lists and give its address to your router as the second
   DNS server. AdGuard Home can copy settings between the two with community sync tools; with Pi-hole, use
   *Settings → Teleporter* to export and import.

<div align="right"><a href="#contents">↑ Back to top</a></div>

## Home Assistant

Running Home Assistant OS? Its **AdGuard Home** app (add-on) turns the same box into the blocker for your whole home.

1. **Give Home Assistant a static IP and fixed DNS servers first** (the add-on's own instructions insist on this): **Settings
   → System → Network → Configure network interfaces** → your interface → **IPv4** → **Static**: set the address (e.g.
   `192.168.1.6`), gateway (your router) and DNS servers (e.g. `1.1.1.1`) → **Save**. A reservation in your router is not
   enough.
2. **Settings → Add-ons** (called **Apps** in newer versions) → **Add-on Store** → search **AdGuard Home** → **Install** →
   **Start**, and turn on **Start on boot** and **Show in sidebar**. Check its **Log** tab for errors.
3. Click **Open Web UI** (you're signed in with your Home Assistant account) → **Filters → DNS blocklists → Add blocklist →
   Add a custom list** → paste the adblock links ([How to add a list](../README.md#how-to-add-a-list)).
4. Point your network at Home Assistant's IP: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home). Keep Home
   Assistant's own DNS (step 1) on a public server, so it still works when the add-on restarts.
5. Updates: the lists update themselves; Home Assistant offers add-on updates under **Settings → Updates**. Include the
   add-on in your Home Assistant backups.

If Home Assistant runs as a VM or container on another system (Proxmox, a NAS), you can instead follow that system's
section ([Proxmox VE](#proxmox-ve), [Docker](#docker)...).

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
   ([How to add a list](../README.md#how-to-add-a-list)). If it reports port 53 in use, check with `netstat -ano | findstr ":53 "`
   (Windows *Internet Connection Sharing* is a common cause).

**macOS**
```bash
curl -s -S -L https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v
```
The official script installs it into `/Applications/AdGuardHome` as a service. Open `http://127.0.0.1:3000`, finish
the wizard and add the lists. Allow incoming connections if macOS asks.

Then either:
- **Protect the whole home:** point your network at the computer: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home).
- **Protect only this computer:** set its own DNS server to `127.0.0.1`. Windows 11: **Settings → Network & internet →
  Wi-Fi** (or Ethernet) → your network → **DNS server assignment → Edit → Manual** → IPv4 on → Preferred DNS `127.0.0.1` →
  Save. macOS: **System Settings → Network** → your network → **Details → DNS** → **+** `127.0.0.1` (remove the others).

Manage the service later with `AdGuardHome -s stop|start|uninstall` (as administrator / with `sudo`).

<div align="right"><a href="#contents">↑ Back to top</a></div>

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
4. Point your network at it: [Raspberry Pi, step 3](#step-3-use-it-for-the-whole-home).

<div align="right"><a href="#contents">↑ Back to top</a></div>
