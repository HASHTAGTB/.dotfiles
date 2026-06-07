#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) pipx install "$@" ;;
  -x) pipx uninstall "$@" ;;
  -c) pipx list 2>/dev/null | grep -q "package $1 " ;;
  -l) pipx list 2>/dev/null | grep 'package ' | awk '{print $2}' ;;
  *) echo "usage: pipx.sh -i|-x|-c|-l [pkg...]" >&2; exit 1 ;;
esac
