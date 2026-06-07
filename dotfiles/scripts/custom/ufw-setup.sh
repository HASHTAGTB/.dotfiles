#!/usr/bin/env bash
# Configures and enables UFW firewall rules
set -euo pipefail

readonly C_RESET=$'\e[0m'
readonly C_BOLD=$'\e[1m'
readonly C_GREEN=$'\e[32m'
readonly C_RED=$'\e[31m'
readonly C_BLUE=$'\e[34m'

trap 'printf "%s" "${C_RESET}"' EXIT INT TERM

log_info()    { printf "${C_BLUE}[INFO]${C_RESET}  %s\n" "$1"; }
log_success() { printf "${C_GREEN}[OK]${C_RESET}    %s\n" "$1"; }
log_err()     { printf "${C_RED}[FAIL]${C_RESET}  %s\n" "$1"; }

if [[ $EUID -ne 0 ]]; then
    log_info "Escalating to root..."
    exec sudo -E "$0" "$@"
fi

main() {
    printf "\n${C_BOLD}Configuring UFW...${C_RESET}\n"

    ufw limit 22/tcp        && log_success "Rate-limited SSH (22/tcp)"
    ufw allow 80/tcp        && log_success "Allowed HTTP (80/tcp)"
    ufw allow 443/tcp       && log_success "Allowed HTTPS (443/tcp)"
    ufw default deny incoming  && log_success "Default: deny incoming"
    ufw default allow outgoing && log_success "Default: allow outgoing"
    ufw --force enable      && log_success "UFW enabled"

    printf "\n${C_BOLD}Done.${C_RESET}\n"
}

main "$@"
