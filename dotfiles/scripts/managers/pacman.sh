#!/usr/bin/env bash
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) pacman --noconfirm -S --needed "$@" ;;
  -x) pacman --noconfirm -Rns "$@" ;;
  -c) pacman -Q "$1" &>/dev/null ;;
  -l) pacman -Qe | awk '{print $1}' ;;
  -q) pacman -Qi "$1" 2>/dev/null || pacman -Si "$1" 2>/dev/null || echo "(no info available)" ;;
  *) echo "usage: pacman.sh -i|-x|-c|-l|-q [pkg...]" >&2; exit 1 ;;
esac
