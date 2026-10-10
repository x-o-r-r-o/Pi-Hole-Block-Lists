# Security policy

People run this project's scripts with administrator rights and use its lists to decide what their whole home network can
reach, so security problems are taken seriously.

## What to report here

Report privately, as described below, anything that could harm people using this project, for example:
- **Installer scripts** (`install/`): a flaw that lets someone run commands, change files outside the hosts file, or
  install something unexpected.
- **The build and GitHub Actions** (`scripts/`, `.github/workflows/`): a way to slip unwanted content into the published
  lists or scripts, or to leak secrets.
- **Poisoned lists:** an upstream source, a pull request or the allowlist being used to unblock known malware or
  phishing domains, or to block essential services on purpose.
- **Docker files** (`docker/`): an insecure default that exposes people's systems.

**Not security issues** (please use the normal [issue forms](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/issues/new/choose)
instead):
- A domain blocked by mistake.
- A malware, phishing or scam domain that isn't blocked yet. Reporting it publicly is fine and gets it blocked for
  everyone sooner; write it as `example[.]com`.
- Things DNS blocking can't do, such as removing YouTube video ads.

## How to report

**Please don't post details of a vulnerability in a public issue, discussion or pull request.**

1. [Open an issue](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/issues/new) titled **"Security contact request"**, with
   no details. Mention only which part is affected (e.g. "installer script" or "build").
2. The maintainer will reply and set up a private GitHub security advisory, then invite you to share the details there.
3. Include what's affected, how to reproduce it, and what an attacker could do. A suggested fix is welcome.

We'll reply as soon as we can, keep you updated, fix confirmed problems in the `master` branch, and credit you in the
advisory and [CHANGELOG.md](CHANGELOG.md) unless you'd rather stay anonymous.

## Supported versions

Only the current `master` branch is supported. The lists are rebuilt every day and the scripts are always used from
`master`, so fixes reach everyone through the normal daily update. Re-download a script to get its latest version.

## Built-in safeguards

- **Scripts back up first:** they save the original hosts file, only change their own marked block, and remove it
  completely with `--remove` / `-Remove`.
- **Essential sites are protected:** [`protected.txt`](protected.txt) keeps them out of every list that isn't meant to
  block them, even if an upstream source adds them by mistake.
- **No silent damage from a broken source:** a list that would shrink by more than half, or whose source fails to
  download, keeps its previous version.
- **Tested before release:** installer scripts and Docker files are tested automatically on Windows, macOS and Linux
  for every change.

**Staying safe as a user:**
- Download the scripts only from this repository (`raw.githubusercontent.com/x-o-r-r-o/Pi-Hole-Block-Lists`).
- You can read a script before running it; each is a single, commented file.
