#!/usr/bin/env bash
set -euo pipefail

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

declare -A PLUGINS=(
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    ["zsh-completions"]="https://github.com/zsh-users/zsh-completions.git"
    ["zsh-history-substring-search"]="https://github.com/zsh-users/zsh-history-substring-search.git"
)

for plugin in "${!PLUGINS[@]}"; do
    url="${PLUGINS[$plugin]}"
    dir="$ZSH_CUSTOM/plugins/$plugin"
    if [ -d "$dir" ]; then
        echo "Updating $plugin..."
        git -C "$dir" pull
    else
        echo "Cloning $plugin..."
        git clone --depth=1 "$url" "$dir"
    fi
done
