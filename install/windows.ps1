<#
Pi-Hole-Block-Lists for Windows: block the lists you choose on this PC, without Pi-hole or
AdGuard Home, by adding them to the Windows hosts file.

  powershell -ExecutionPolicy Bypass -File windows.ps1              pick lists in a window
  powershell -ExecutionPolicy Bypass -File windows.ps1 -Lists ads-and-tracking,security
  powershell -ExecutionPolicy Bypass -File windows.ps1 -Update      re-download your lists
  powershell -ExecutionPolicy Bypass -File windows.ps1 -Remove      remove all blocking
  powershell -ExecutionPolicy Bypass -File windows.ps1 -AutoUpdate on|off

Other options: -Yes (don't ask questions), -NoGui (text menu instead of a window),
-HostsFile PATH (use another file, for testing). Your original hosts file is backed up once
to hosts.block-lists-backup next to it.
#>
param(
    [string]$Lists = "",
    [switch]$Update,
    [switch]$Remove,
    [ValidateSet("", "on", "off")][string]$AutoUpdate = "",
    [string]$HostsFile = "$env:SystemRoot\System32\drivers\etc\hosts",
    [switch]$Yes,
    [switch]$NoGui
)
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$RepoRaw = if ($env:BLOCK_LISTS_REPO) { $env:BLOCK_LISTS_REPO } else { "https://raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists/master" }
$Begin = "# >>> Pi-Hole-Block-Lists >>>"
$End = "# <<< Pi-Hole-Block-Lists <<<"
$Recommended = "ads-and-tracking,security"
$WarnEntries = 150000  # very large hosts files make Windows' DNS Client slow
$TaskName = "Pi-Hole-Block-Lists daily update"
$InstallDir = Join-Path $env:ProgramData "block-lists"
$Testing = $PSBoundParameters.ContainsKey("HostsFile")
$Conf = Join-Path (Split-Path $HostsFile) "block-lists.conf"

function Test-Admin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    (New-Object Security.Principal.WindowsPrincipal $id).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not $Testing -and -not (Test-Admin)) {
    Write-Host "Administrator rights are needed to change the hosts file. Windows will ask for permission."
    $argList = @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSCommandPath`"")
    foreach ($k in $PSBoundParameters.Keys) {
        $v = $PSBoundParameters[$k]
        if ($v -is [switch]) { if ($v) { $argList += "-$k" } } else { $argList += "-$k"; $argList += "`"$v`"" }
    }
    Start-Process powershell.exe -Verb RunAs -ArgumentList $argList
    exit
}

$Tmp = Join-Path ([IO.Path]::GetTempPath()) ("block-lists-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $Tmp | Out-Null

function Get-Url([string]$url, [string]$file) {
    if ($url.StartsWith("file://")) { Copy-Item ([Uri]$url).LocalPath $file; return }
    (New-Object Net.WebClient).DownloadFile($url, $file)
}

function Confirm-Choice([string]$question, [bool]$default) {
    if ($Yes -or -not [Environment]::UserInteractive) { return $default }
    $hint = if ($default) { "[Y/n]" } else { "[y/N]" }
    $reply = Read-Host "$question $hint"
    if ([string]::IsNullOrWhiteSpace($reply)) { return $default }
    return $reply.Trim().ToLower().StartsWith("y")
}

function Get-HostsWithoutBlock {
    $out = New-Object Collections.Generic.List[string]
    $skip = $false
    foreach ($line in [IO.File]::ReadAllLines($HostsFile)) {
        if ($line.StartsWith($Begin)) { $skip = $true; continue }
        if ($skip -and $line.StartsWith($End)) { $skip = $false; continue }
        if (-not $skip) { $out.Add($line) }
    }
    return , $out
}

function Clear-Dns { if (-not $Testing) { ipconfig /flushdns | Out-Null } }

function Set-AutoUpdate([string]$state) {
    if ($Testing) { Write-Host "(testing: daily update not changed)"; return }
    if ($state -eq "on") {
        New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
        $target = Join-Path $InstallDir "windows.ps1"
        if ($PSCommandPath) { Copy-Item $PSCommandPath $target -Force } else { Get-Url "$RepoRaw/install/windows.ps1" $target }
        $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$target`" -Update -Yes"
        $trigger = New-ScheduledTaskTrigger -Daily -At 4:30am
        $principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -RunLevel Highest
        $settings = New-ScheduledTaskSettingsSet -StartWhenAvailable
        Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force | Out-Null
        Write-Host "Daily update is ON (Task Scheduler: '$TaskName')."
    } else {
        Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction SilentlyContinue
        Remove-Item $InstallDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Daily update is OFF."
    }
}

function Test-AutoUpdate { [bool](Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) }

try {
    if ($Remove) {
        [IO.File]::WriteAllLines($HostsFile, (Get-HostsWithoutBlock))
        Remove-Item $Conf -ErrorAction SilentlyContinue
        Clear-Dns
        if (-not $Testing -and (Test-AutoUpdate)) { Set-AutoUpdate "off" }
        Write-Host "Blocking removed. Your other hosts entries are untouched."
        return
    }
    if ($AutoUpdate -and -not $Update -and -not $Lists) { Set-AutoUpdate $AutoUpdate; return }

    Write-Host "Downloading the list catalogue..."
    Get-Url "$RepoRaw/install/catalog.tsv" (Join-Path $Tmp "catalog.tsv")
    $catalog = @(Import-Csv -Path (Join-Path $Tmp "catalog.tsv") -Delimiter "`t")
    $names = $catalog | ForEach-Object { $_.name }

    if ($Update) {
        if (-not (Test-Path $Conf)) { throw "Nothing to update: no lists installed yet. Run without -Update first." }
        # @() keeps this an array even when the file has one line (-match on a single string returns True/False).
        $Lists = (@(Get-Content $Conf) | Where-Object { $_ -match "^LISTS=" } | Select-Object -First 1) -replace "^LISTS=", ""
    } elseif (-not $Lists) {
        $useGui = -not $NoGui -and -not $Yes -and (Get-Command Out-GridView -ErrorAction SilentlyContinue)
        if ($useGui) {
            Write-Host "Select one or more lists in the window (hold Ctrl to pick several), then click OK."
            $picked = $catalog | Select-Object @{n = "List"; e = { $_.title } }, @{n = "Domains"; e = { [int]$_.entries } }, @{n = "Name"; e = { $_.name } }, @{n = "What it blocks"; e = { $_.description } } |
                Out-GridView -Title "Pi-Hole-Block-Lists: choose lists to block" -OutputMode Multiple
            $Lists = ($picked | ForEach-Object { $_.Name }) -join ","
        } else {
            Write-Host ""; Write-Host "Available lists (domains in brackets):"
            for ($i = 0; $i -lt $catalog.Count; $i++) {
                $c = $catalog[$i]
                Write-Host ("{0,3}) {1} [{2}] - {3}" -f ($i + 1), $c.title, $c.entries, $c.name)
                $d = $c.description; if ($d.Length -gt 110) { $d = $d.Substring(0, 110) }
                Write-Host "      $d"
            }
            $picks = Read-Host "Type the numbers you want separated by spaces (e.g. 1 9 14), or press Enter for Ads & Tracking + Security"
            if ([string]::IsNullOrWhiteSpace($picks)) { $Lists = $Recommended } else {
                $sel = foreach ($p in ($picks -split "[ ,]+")) {
                    $n = 0
                    if ([int]::TryParse($p, [ref]$n) -and $n -ge 1 -and $n -le $catalog.Count) { $catalog[$n - 1].name }
                    elseif ($p) { Write-Host "Ignoring '$p' (no such list)" }
                }
                $Lists = $sel -join ","
            }
        }
    }
    if (-not $Lists) { throw "No lists selected." }

    $domains = New-Object 'Collections.Generic.HashSet[string]'
    $good = @()
    foreach ($name in ($Lists -split "[ ,]+") | Where-Object { $_ }) {
        if ($names -notcontains $name) { Write-Host "Unknown list: $name (skipped)"; continue }
        $good += $name
        Write-Host "Downloading $name..."
        $file = Join-Path $Tmp "$name.txt"
        Get-Url "$RepoRaw/hosts/$name.txt" $file
        foreach ($line in [IO.File]::ReadLines($file)) {
            if ($line.StartsWith("0.0.0.0 ")) { [void]$domains.Add($line.Substring(8).Trim()) }
        }
    }
    if ($domains.Count -eq 0) { throw "The selected lists are empty; nothing changed." }
    $Lists = $good -join ","
    if ($good -contains "windows-telemetry") {
        Write-Host "Note: Microsoft Defender may report the hosts file as 'SettingsModifier:Win32/HostsFileHijack' because it blocks Microsoft telemetry. That is expected; choose 'Allow on device' if it does."
    }
    if ($domains.Count -gt $WarnEntries -and -not $Update) {
        if (-not (Confirm-Choice "That's $($domains.Count) domains. Very large hosts files can make Windows slow to look up names. Continue?" $false)) { throw "Cancelled." }
    }

    $backup = "$HostsFile.block-lists-backup"
    if (-not (Test-Path $backup)) { Copy-Item $HostsFile $backup }
    $kept = Get-HostsWithoutBlock
    $writer = New-Object IO.StreamWriter($HostsFile, $false, (New-Object Text.ASCIIEncoding))
    try {
        foreach ($line in $kept) { $writer.WriteLine($line) }
        $writer.WriteLine($Begin)
        $writer.WriteLine("# Lists: $Lists | Updated: $((Get-Date).ToUniversalTime().ToString('yyyy-MM-dd HH:mm')) UTC | $($domains.Count) domains")
        $writer.WriteLine("# Remove with: powershell -ExecutionPolicy Bypass -File windows.ps1 -Remove")
        # Windows reads up to 9 names per line; fewer lines keeps the DNS Client faster.
        $sorted = New-Object 'Collections.Generic.List[string]' -ArgumentList (, [string[]]@($domains))
        $sorted.Sort([StringComparer]::Ordinal)
        for ($i = 0; $i -lt $sorted.Count; $i += 9) {
            $writer.WriteLine("0.0.0.0 " + ($sorted.GetRange($i, [Math]::Min(9, $sorted.Count - $i)) -join " "))
        }
        $writer.WriteLine($End)
    } finally { $writer.Close() }
    Set-Content -Path $Conf -Value "LISTS=$Lists" -Encoding ASCII
    Clear-Dns
    Write-Host "Done: $($domains.Count) domains blocked ($Lists)."

    if ($AutoUpdate) { Set-AutoUpdate $AutoUpdate }
    elseif (-not $Update -and -not $Testing -and -not (Test-AutoUpdate) -and (Confirm-Choice "Update these lists automatically every day?" $true)) { Set-AutoUpdate "on" }
    Write-Host "Tip: restart your browser so it forgets cached addresses."
} finally {
    Remove-Item $Tmp -Recurse -Force -ErrorAction SilentlyContinue
}
