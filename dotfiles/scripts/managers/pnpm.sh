#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) pnpm add -g "$@" ;;
  -x) pnpm remove -g "$@" ;;
  -c) pnpm list -g --depth=0 "$1" &>/dev/null ;;
  -l) pnpm list -g --depth=0 --parseable 2>/dev/null | tail -n +2 | xargs -I{} basename {} ;;
  *) echo "usage: pnpm.sh -i|-x|-c|-l [pkg...]" >&2; exit 1 ;;
esac
