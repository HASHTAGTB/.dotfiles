#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"
NVIM_DIR="${DOTFILES_DIR}/packs/nvim/files/.config"
REPO="https://github.com/HASHTAGTB/kickstart.nvim.git"

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

mkdir -p "$NVIM_DIR"
clone_or_update "$REPO" "$NVIM_DIR/nvim" "master"
clone_or_update "$REPO" "$NVIM_DIR/nvim.own" "own"
