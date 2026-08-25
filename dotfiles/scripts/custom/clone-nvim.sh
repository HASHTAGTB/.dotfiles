#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"
CONFIG_DIR="${DOTFILES_DIR}.config"
REPO="git@github.com:HASHTAGTB/nvim.git"

clone_or_update() {
    local url="$1" dir="$2" branch="$3"
    if [ -d "$dir/.git" ]; then
        echo "Updating $(basename "$dir")..."
        git -C "$dir" pull
    else
        echo "Cloning $(basename "$dir") ($branch)..."
        git clone --depth=1 --branch "$branch" "$url" "$dir"
    fi
}

mkdir -p "$CONFIG_DIR"
clone_or_update "$REPO" "$CONFIG_DIR/nvim" "main"
