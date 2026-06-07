#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) paru --noconfirm -S --needed "$@" ;;
  -x) paru --noconfirm -Rns "$@" ;;
  -c) paru -Q "$1" &>/dev/null ;;
  -l) paru -Qe | awk '{print $1}' ;;
  *) echo "usage: paru.sh -i|-x|-c|-l [pkg...]" >&2; exit 1 ;;
esac
