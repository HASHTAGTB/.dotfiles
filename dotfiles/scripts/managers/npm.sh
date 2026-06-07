#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) npm install -g "$@" ;;
  -x) npm uninstall -g "$@" ;;
  -c) npm list -g --depth=0 "$1" &>/dev/null ;;
  -l) npm list -g --depth=0 --parseable 2>/dev/null | tail -n +2 | xargs -I{} basename {} ;;
  *) echo "usage: npm.sh -i|-x|-c|-l [pkg...]" >&2; exit 1 ;;
esac
