#!/usr/bin/env bash
# Usage: yay.sh -i pkg...  | -x pkg...  | -c pkg  | -l
set -euo pipefail
cmd=$1; shift
case $cmd in
  -i) yay --noconfirm -S --needed "$@" ;;
  -x) yay --noconfirm -Rns "$@" ;;
  -c) yay -Q "$1" &>/dev/null ;;
  -l) yay -Qe | awk '{print $1}' ;;
  *) echo "usage: yay.sh -i|-x|-c|-l [pkg...]" >&2; exit 1 ;;
esac
