#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) yarn global add "$@" ;;
  -x) yarn global remove "$@" ;;
  -c) yarn global list 2>/dev/null | grep -q " $1@" ;;
  -l) yarn global list --depth=0 2>/dev/null | grep info | sed 's/.*\"//; s/@.*//' ;;
  -q) npm view "$1" 2>/dev/null || echo "(no info available)" ;;
  *) echo "usage: yarn.sh -i|-x|-c|-l|-q [pkg...]" >&2; exit 1 ;;
esac
