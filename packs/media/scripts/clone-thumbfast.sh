#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"
SCRIPTS_DIR="${DOTFILES_DIR}/packs/media/files/.config/mpv/scripts"
REPO="https://github.com/po5/thumbfast.git"
DEST="${SCRIPTS_DIR}/thumbfast_repo"

mkdir -p "$SCRIPTS_DIR"
if [ -d "$DEST/.git" ]; then
    echo "Updating thumbfast..."
    git -C "$DEST" pull
else
    echo "Cloning thumbfast..."
    git clone --depth=1 "$REPO" "$DEST"
fi
