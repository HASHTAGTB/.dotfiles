#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) paru --noconfirm -S --needed "$@" ;;
  -x) paru --noconfirm -Rns "$@" ;;
  -c) paru -Q "$1" &>/dev/null ;;
  -l) paru -Qe | awk '{print $1}' ;;
  -q) paru -Qi "$1" 2>/dev/null || paru -Si "$1" 2>/dev/null || echo "(no info available)" ;;
  *) echo "usage: paru.sh -i|-x|-c|-l|-q [pkg...]" >&2; exit 1 ;;
esac
