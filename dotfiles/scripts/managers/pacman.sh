#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) pacman --noconfirm -S --needed "$@" ;;
  -x) pacman --noconfirm -Rns "$@" ;;
  -c) pacman -Q "$1" &>/dev/null ;;
  -l) pacman -Qe | awk '{print $1}' ;;
  *) echo "usage: pacman.sh -i|-x|-c|-l [pkg...]" >&2; exit 1 ;;
esac
