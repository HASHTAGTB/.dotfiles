#!/usr/bin/env bash
set -euo pipefail

BOLD=$'\e[1m'
GREEN=$'\e[32m'
BLUE=$'\e[34m'
RED=$'\e[31m'
RESET=$'\e[0m'

trap 'printf "%s" "${RESET}"' EXIT INT TERM

log_info()    { printf "${BLUE}[INFO]${RESET}    %s\n" "$1"; }
log_success() { printf "${GREEN}[OK]${RESET}      %s\n" "$1"; }
log_err()     { printf "${RED}[ERROR]${RESET}   %s\n" "$1" >&2; }

if [[ -n "${SUDO_USER:-}" ]]; then
    TARGET_USER="$SUDO_USER"
else
    TARGET_USER="$USER"
fi

if ! command -v zsh &>/dev/null; then
    log_err "zsh is not installed."
    exit 1
fi

ZSH_PATH=$(command -v zsh)

if ! grep -Fxq "$ZSH_PATH" /etc/shells; then
    log_err "'$ZSH_PATH' is not listed in /etc/shells."
    exit 1
fi

CURRENT_SHELL=$(getent passwd "$TARGET_USER" | cut -d: -f7)

if [[ "$CURRENT_SHELL" == "$ZSH_PATH" ]]; then
    log_success "User '${BOLD}$TARGET_USER${RESET}' already uses zsh."
    exit 0
fi

log_info "Switching shell for ${BOLD}$TARGET_USER${RESET}: $CURRENT_SHELL → $ZSH_PATH"

if [[ $EUID -eq 0 ]]; then
    chsh -s "$ZSH_PATH" "$TARGET_USER"
else
    chsh -s "$ZSH_PATH"
fi

log_success "Default shell changed to zsh for ${BOLD}$TARGET_USER${RESET}."
