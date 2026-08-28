#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"
ICONS_PATH="/tmp/Fluent-icon-theme"
REPO="https://github.com/vinceliuice/Fluent-icon-theme.git"

if [[ -d "$ICONS_PATH"/.git ]]; then 
    git -C "$ICONS_PATH" pull
else
    git clone "$REPO" "$ICONS_PATH"
fi
/tmp/Fluent-icon-theme/install.sh teal
