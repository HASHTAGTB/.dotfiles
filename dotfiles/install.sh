#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/HASHTAGTB/.dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_LOGIC="$DOTFILES_DIR/dotfiles"
BIN_DIR="$HOME/.local/bin"
BIN_NAME="dots"

if [ -d "$DOTFILES_DIR" ]; then
    echo "~/.dotfiles already exists, pulling latest..."
    git -C "$DOTFILES_DIR" pull
else
    echo "Cloning $REPO..."
    git clone "$REPO" "$DOTFILES_DIR"
fi

BIN_PATH="$DOTFILES_LOGIC/$BIN_NAME"

if [ ! -f "$BIN_PATH" ]; then
    echo "Error: binary not found at $BIN_PATH" >&2
    exit 1
fi

mkdir -p "$BIN_DIR"
ln -sf "$BIN_PATH" "$BIN_DIR/$BIN_NAME"
echo "Linked $BIN_PATH -> $BIN_DIR/$BIN_NAME"

if ! echo "$PATH" | grep -q "$BIN_DIR"; then
    echo "Note: $BIN_DIR is not in your PATH. Add this to your shell profile:"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo "Done. Run: $BIN_NAME"
