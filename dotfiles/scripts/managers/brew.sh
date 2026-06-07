#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) brew install "$@" ;;
  -x) brew uninstall "$@" ;;
  -c) brew list --formula "$1" &>/dev/null ;;
  -l) brew list --formula ;;
  *) echo "usage: brew.sh -i|-x|-c|-l [pkg...]" >&2; exit 1 ;;
esac
