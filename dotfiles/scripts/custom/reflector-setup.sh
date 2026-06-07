#!/usr/bin/env bash
# Configures reflector and enables the reflector.timer for automatic mirror updates
set -euo pipefail

readonly C_RESET=$'\e[0m'
readonly C_BOLD=$'\e[1m'
readonly C_GREEN=$'\e[32m'
readonly C_YELLOW=$'\e[33m'
readonly C_RED=$'\e[31m'
readonly C_BLUE=$'\e[34m'

readonly CONF_PATH="/etc/xdg/reflector/reflector.conf"

trap 'printf "%s" "${C_RESET}"' EXIT INT TERM

log_info()    { printf "${C_BLUE}[INFO]${C_RESET}  %s\n" "$1"; }
log_success() { printf "${C_GREEN}[OK]${C_RESET}    %s\n" "$1"; }
log_warn()    { printf "${C_YELLOW}[SKIP]${C_RESET}  %s\n" "$1"; }
log_err()     { printf "${C_RED}[FAIL]${C_RESET}  %s\n" "$1"; }

if [[ $EUID -ne 0 ]]; then
    log_info "Escalating to root..."
    exec sudo -E "$0" "$@"
fi

prompt_countries() {
    printf "\n${C_BOLD}Reflector mirror setup${C_RESET}\n"
    printf "Enter one or more countries for mirror selection.\n"
    printf "Examples: ${C_BOLD}United States${C_RESET}, ${C_BOLD}Germany,France${C_RESET}, ${C_BOLD}India${C_RESET}\n"
    printf "Leave blank to use worldwide mirrors.\n\n"
    read -rp "Country/Countries: " countries
    echo "$countries"
}

write_conf() {
    local countries="$1"

    mkdir -p "$(dirname "$CONF_PATH")"

    {
        printf '# Reflector configuration — managed by dotfiles\n'
        printf -- '--save /etc/pacman.d/mirrorlist\n'
        printf -- '--protocol https\n'
        if [[ -n "$countries" ]]; then
            printf -- '--country %s\n' "$countries"
        fi
        printf -- '--latest 10\n'
        printf -- '--sort rate\n'
    } > "$CONF_PATH"
}

main() {
    local countries
    countries=$(prompt_countries)

    write_conf "$countries"
    log_success "Wrote $CONF_PATH"

    if systemctl is-enabled --quiet reflector.timer 2>/dev/null; then
        log_info "reflector.timer already enabled"
    elif systemctl enable --now reflector.timer &>/dev/null; then
        log_success "Enabled reflector.timer (weekly mirror updates)"
    else
        log_err "Failed to enable reflector.timer"
    fi

    log_info "Running reflector now to update mirrorlist..."
    if reflector --save /etc/pacman.d/mirrorlist --protocol https \
        ${countries:+--country "$countries"} --latest 10 --sort rate; then
        log_success "Mirrorlist updated"
    else
        log_err "reflector run failed — mirrorlist unchanged"
    fi

    printf "\n${C_BOLD}Done.${C_RESET}\n"
}

main "$@"
