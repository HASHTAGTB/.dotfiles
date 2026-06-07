#!/usr/bin/env bash
# symlink.sh -i <rel>   — link $HOME/<rel> → $DOTFILES_DIR/<rel>
# symlink.sh -x <rel>   — unlink $HOME/<rel> if it points to $DOTFILES_DIR/<rel>
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
cmd=$1
rel=$2

repo_path="$DOTFILES_DIR/$rel"
target_path="$HOME/$rel"

case $cmd in
  -i)
    if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$repo_path" ]; then
      echo "already linked: $target_path"
      exit 0
    fi
    if [ -L "$target_path" ]; then
      echo "conflict: $target_path -> $(readlink "$target_path") (expected $repo_path)" >&2
      exit 1
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
    echo "usage: symlink.sh -i|-x <rel_path>" >&2
    exit 1
    ;;
esac
