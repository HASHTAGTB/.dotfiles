#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) bun add -g "$@" ;;
  -x) bun remove -g "$@" ;;
  -c) bun pm ls -g 2>/dev/null | grep -q " $1@" ;;
  -l) bun pm ls -g 2>/dev/null | awk -F@ '/[├└]/{gsub(/[^a-zA-Z0-9._-]/, "", $1); if($1 != "") print $1}' ;;
  *) echo "usage: bun.sh -i|-x|-c|-l [pkg...]" >&2; exit 1 ;;
esac
