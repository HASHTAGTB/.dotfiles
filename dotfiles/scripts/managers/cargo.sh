#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) cargo install "$@" ;;
  -x) cargo uninstall "$@" ;;
  -c) cargo install --list 2>/dev/null | grep -q "^$1 " ;;
  -l) cargo install --list 2>/dev/null | grep -E '^[a-zA-Z]' | awk '{print $1}' ;;
  -q) cargo info "$1" 2>/dev/null || echo "(no info available)" ;;
  *) echo "usage: cargo.sh -i|-x|-c|-l|-q [pkg...]" >&2; exit 1 ;;
esac
