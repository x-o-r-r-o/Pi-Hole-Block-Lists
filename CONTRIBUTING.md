# Contributing

Thanks for helping! Most contributions don't need any coding: reporting a wrong block, a missed domain or an outdated
menu in a guide is just as valuable.

Please follow the [Code of Conduct](CODE_OF_CONDUCT.md). Security problems go through [SECURITY.md](SECURITY.md), not
public issues.

## Report a problem or suggest something

[Open an issue](https://github.com/x-o-r-r-o/Pi-Hole-Block-Lists/issues/new/choose) and pick the form that fits:

| Form | Use it when |
|---|---|
| **Something is blocked that shouldn't be** | A site, app, link or device broke because of a list (a "false positive") |
| **Something should be blocked** | An ad, tracker, scam, malware site or app gets through |
| **Suggest a list, source or app** | A new upstream source, a new list category, or an app for an app-based list |
| **A setup guide doesn't match my device** | A menu, step or command in a guide is wrong or outdated |
| **Script or build problem** | An installer script, Docker file, list file or the daily build fails |

Tips for a quick fix:
- **Give the exact server name from your blocker's query log** (e.g. `cdn.example.com`), not the page address you
  typed. [Something broke?](docs/troubleshooting.md#something-broke) explains how to find it.
- **Search the existing issues first.**
- **Don't paste live phishing or malware links as clickable links.** Write them as `example[.]com`.

## Make a change yourself (pull request)

1. Fork the repository and create a branch.
2. Edit the **source files**, never the generated ones:

   | To... | Edit |
   |---|---|
   | Stop a domain being blocked by any list | [`allowlist.txt`](allowlist.txt) (one domain per line) |
   | Always add a domain to one list | `custom/<list>.txt` |
   | Add an upstream source | [`sources.json`](sources.json), then add its id to the list in [`lists.json`](lists.json) |
   | Add or change a list | [`lists.json`](lists.json) (`title`, `description`, `sources`, optional `includes`, `may_block`) |
   | Add an app to an app-based list | `apps/<list>.json` (official domains from the app's store listing or website) |
   | Protect an essential site from every list | [`protected.txt`](protected.txt) |
   | Fix a guide | the page in [`docs/`](docs/) or [`README.md`](README.md) |
   | Change how lists are built | [`scripts/build.py`](scripts/build.py) (Python standard library only) |

   **Don't edit (the build rewrites them):**
   - the generated list files: `*.txt` in the repository root, plus `adblock/`, `hosts/`, `unifi/`, `ips/`, `browser/`,
     `data/` and `install/catalog.tsv`
   - any text between `<!-- ... START -->` and `<!-- ... END -->` markers in the README or guides
3. Test locally:
   ```bash
   python3 scripts/build.py              # builds every list, updates the guides' tables and checks all links
   python3 scripts/build_browser.py      # only if you changed the YouTube browser lists
   python3 scripts/discover_apps.py apps/<list>.json   # only if you changed an apps/ file (slow)
   ```
   The build must finish without `WARNING` lines. It reports broken links between guide pages, lists that shrink too
   much, and failed downloads.
4. Installer scripts: test against a throwaway hosts file, never your real one:
   ```bash
   cp /etc/hosts /tmp/test-hosts
   bash install/macos.sh --hosts-file /tmp/test-hosts --lists youtube-ads --yes
   bash install/macos.sh --hosts-file /tmp/test-hosts --remove
   ```
   Pull requests that change `install/` or `docker/` are tested automatically on Windows, macOS and Linux.
5. Open the pull request and fill in the checklist.

## What gets accepted

- **New sources:**
  - Actively maintained (updated within the last few months).
  - Freely redistributable: say which license.
  - Low false positives: a source that blocks major sites will be rejected or filtered.
- **New lists:** a clear purpose that isn't already covered by an existing list (see
  [What each list blocks](docs/lists.md#what-each-list-blocks-and-what-it-doesnt)).
- **App domains:** only the app's own domains, never shared services (cloud providers, CDNs, Google, Facebook...).
- **Guides:** plain language for non-technical readers, exact menu names, and the version you checked.

## License

By contributing, you agree that your contribution is licensed under the repository's [GPL-3.0 license](LICENSE).
Sources you add keep their own licenses; list them correctly in `sources.json`.
