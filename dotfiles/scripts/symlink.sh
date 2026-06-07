#!/usr/bin/env bash
# symlink.sh -i <repo_path> <target_path>   — apply (create symlink)
# symlink.sh -x <repo_path> <target_path>   — unapply (remove symlink)
set -euo pipefail

cmd=$1
repo_path=$2   # absolute path to file in dotfiles repo
target_path=$3 # absolute path where symlink should live (in $HOME)

case $cmd in
  -i)
    if [ -L "$target_path" ]; then
      current=$(readlink "$target_path")
      if [ "$current" = "$repo_path" ]; then
        echo "already linked: $target_path"
        exit 0
      else
        echo "conflict: $target_path -> $current (expected $repo_path)" >&2
        exit 1
      fi
    fi
    if [ -e "$target_path" ]; then
      backup="${target_path}.bak.$(date +%s)"
      echo "backing up: $target_path -> $backup"
      mv "$target_path" "$backup"
    fi
    mkdir -p "$(dirname "$target_path")"
    ln -s "$repo_path" "$target_path"
    echo "linked: $target_path -> $repo_path"
    ;;
  -x)
    if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$repo_path" ]; then
      rm "$target_path"
      echo "removed: $target_path"
    else
      echo "not linked by dots, skipping: $target_path" >&2
    fi
    ;;
  *)
    echo "usage: symlink.sh -i|-x <repo_path> <target_path>" >&2
    exit 1
    ;;
esac
