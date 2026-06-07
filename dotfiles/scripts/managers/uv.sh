#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) uv tool install "$@" ;;
  -x) uv tool uninstall "$@" ;;
  -c) uv tool list 2>/dev/null | grep -qE "^$1[[:space:]]" ;;
  -l) uv tool list 2>/dev/null | grep -E '^[a-z]' | awk '{print $1}' ;;
  *) echo "usage: uv.sh -i|-x|-c|-l [pkg...]" >&2; exit 1 ;;
esac
