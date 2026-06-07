#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) gem install "$@" ;;
  -x) gem uninstall -x "$@" ;;
  -c) gem list -i "^$1$" &>/dev/null ;;
  -l) gem list --local 2>/dev/null | awk '{print $1}' ;;
  *) echo "usage: gem.sh -i|-x|-c|-l [pkg...]" >&2; exit 1 ;;
esac
