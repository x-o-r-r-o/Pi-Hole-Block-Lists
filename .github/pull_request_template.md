## What does this change?

<!-- e.g. "Add example.com to allowlist.txt (breaks sign-in on X)", "Add app Y to apps/dating.json", "Fix OPNsense menu path" -->

## Checklist

- [ ] I edited the source files (`lists.json`, `sources.json`, `custom/`, `allowlist.txt`, `apps/`, `scripts/`, guides), not the generated list files.
- [ ] I didn't edit text between `<!-- ... START -->` and `<!-- ... END -->` markers (the build rewrites it).
- [ ] If I changed lists, sources or scripts: `python3 scripts/build.py` runs without warnings.
- [ ] If I added a source: it's actively maintained and its license allows redistribution.
- [ ] Related issue: #
