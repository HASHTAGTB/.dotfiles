#!/usr/bin/env bash
# Enables system (root-level) services
set -euo pipefail

readonly C_RESET=$'\e[0m'
readonly C_BOLD=$'\e[1m'
readonly C_GREEN=$'\e[32m'
readonly C_YELLOW=$'\e[33m'
readonly C_RED=$'\e[31m'
readonly C_BLUE=$'\e[34m'

trap 'printf "%s" "${C_RESET}"' EXIT INT TERM

log_info()    { printf "${C_BLUE}[INFO]${C_RESET}  %s\n" "$1"; }
log_success() { printf "${C_GREEN}[OK]${C_RESET}    %s\n" "$1"; }
log_warn()    { printf "${C_YELLOW}[SKIP]${C_RESET}  %s\n" "$1"; }
log_err()     { printf "${C_RED}[FAIL]${C_RESET}  %s\n" "$1"; }

if [[ $EUID -ne 0 ]]; then
    log_info "Escalating to root..."
    exec sudo -E "$0" "$@"
fi

readonly TARGET_SERVICES=(
    "NetworkManager.service"
    # "udisks2.service"
    "bluetooth.service"
    "cups.socket"
    "sddm.service"
    "fstrim.timer"
    "systemd-timesyncd.service"
    "systemd-resolved.service"
)

main() {
    printf "\n${C_BOLD}Enabling system services...${C_RESET}\n"

    for svc in "${TARGET_SERVICES[@]}"; do
        if ! systemctl list-unit-files "$svc" &>/dev/null; then
            log_warn "Not found: ${C_BOLD}$svc${C_RESET}"
            continue
        fi
        if systemctl is-enabled --quiet "$svc" 2>/dev/null; then
            log_info "Already enabled: ${C_BOLD}$svc${C_RESET}"
        elif systemctl enable --now "$svc" &>/dev/null; then
            log_success "Enabled: ${C_BOLD}$svc${C_RESET}"
        else
            log_err "Failed: ${C_BOLD}$svc${C_RESET}"
        fi
    done

    printf "\n${C_BOLD}Done.${C_RESET}\n"
}

main "$@"
