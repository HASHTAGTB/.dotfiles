#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) pipx install "$@" ;;
  -x) pipx uninstall "$@" ;;
  -c) pipx list 2>/dev/null | grep -q "package $1 " ;;
  -l) pipx list 2>/dev/null | grep 'package ' | awk '{print $2}' ;;
  -q)
    curl -fsSL "https://pypi.org/pypi/$1/json" 2>/dev/null | python3 -c '
import json, re, sys

d = json.load(sys.stdin)["info"]

def field(label, value):
    if value:
        print(f"{label}: {value}")

field("Name", d.get("name"))
field("Version", d.get("version"))
field("Summary", d.get("summary"))
field("Home-page", d.get("home_page") or (d.get("project_urls") or {}).get("Homepage"))
field("Author", d.get("author"))
field("Author-email", d.get("author_email"))
license = d.get("license")
field("License", license.splitlines()[0] if license else None)
field("Requires-Python", d.get("requires_python"))

requires = d.get("requires_dist") or []
names = sorted({re.match(r"[A-Za-z0-9_.-]+", r).group(0) for r in requires if re.match(r"[A-Za-z0-9_.-]+", r)})
field("Requires", ", ".join(names))
' 2>/dev/null || echo "(no info available)"
    ;;
  *) echo "usage: pipx.sh -i|-x|-c|-l|-q [pkg...]" >&2; exit 1 ;;
esac
