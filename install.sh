#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/HASHTAGTB/.dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
BIN_DIR="$HOME/.local/bin"
BIN_NAME="dotfiles"

if [ -d "$DOTFILES_DIR" ]; then
    echo "~/.dotfiles already exists, pulling latest..."
    git -C "$DOTFILES_DIR" pull
else
    echo "Cloning $REPO..."
    git clone "$REPO" "$DOTFILES_DIR"
fi

BIN_PATH="$DOTFILES_DIR/$BIN_NAME"

if [ ! -f "$BIN_PATH" ]; then
    echo "Binary not found at $BIN_PATH — building from source..."
    if ! command -v cargo &>/dev/null; then
        echo "Error: cargo not found. Install Rust or add a pre-built binary to the repo." >&2
        exit 1
    fi
    cargo build --release --manifest-path "$DOTFILES_DIR/Cargo.toml"
    BIN_PATH="$DOTFILES_DIR/target/release/$BIN_NAME"
fi

mkdir -p "$BIN_DIR"
ln -sf "$BIN_PATH" "$BIN_DIR/$BIN_NAME"
echo "Linked $BIN_PATH -> $BIN_DIR/$BIN_NAME"

if ! echo "$PATH" | grep -q "$BIN_DIR"; then
    echo "Note: $BIN_DIR is not in your PATH. Add this to your shell profile:"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo "Done. Run: $BIN_NAME"
