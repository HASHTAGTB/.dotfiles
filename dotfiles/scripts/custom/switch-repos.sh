#!/usr/bin/env bash
# Interactively switch pacman.conf between CachyOS and standard Arch repos
set -euo pipefail

readonly C_RESET=$'\e[0m'
readonly C_BOLD=$'\e[1m'
readonly C_GREEN=$'\e[32m'
readonly C_YELLOW=$'\e[33m'
readonly C_RED=$'\e[31m'
readonly C_BLUE=$'\e[34m'
readonly C_CYAN=$'\e[36m'

readonly CACHYOS_REPO_URL="https://mirror.cachyos.org/cachyos-repo.tar.xz"

trap 'printf "%s" "${C_RESET}"' EXIT INT TERM

log_info()    { printf "${C_BLUE}[INFO]${C_RESET}  %s\n" "$1"; }
log_success() { printf "${C_GREEN}[OK]${C_RESET}    %s\n" "$1"; }
log_warn()    { printf "${C_YELLOW}[WARN]${C_RESET}  %s\n" "$1"; }
log_err()     { printf "${C_RED}[FAIL]${C_RESET}  %s\n" "$1"; }

if [[ $EUID -ne 0 ]]; then
    log_info "Escalating to root..."
    exec sudo -E "$0" "$@"
fi

# ── Helpers ──────────────────────────────────────────────────────────────────

is_cachyos_enabled() {
    grep -qE '^\[cachyos\]' /etc/pacman.conf
}

run_official_script() {
    local args=("$@")
    local tmpdir
    tmpdir=$(mktemp -d)
    trap "rm -rf '$tmpdir'" RETURN

    log_info "Downloading CachyOS repo script..."
    curl -fsSL "$CACHYOS_REPO_URL" -o "$tmpdir/cachyos-repo.tar.xz"
    tar xf "$tmpdir/cachyos-repo.tar.xz" -C "$tmpdir"
    bash "$tmpdir/cachyos-repo/cachyos-repo.sh" "${args[@]}"
}

# ── Actions ───────────────────────────────────────────────────────────────────

enable_cachyos() {
    run_official_script
    log_success "CachyOS repos installed"
}

disable_cachyos() {
    run_official_script --remove
    log_success "CachyOS repos removed"
}

# ── UI ────────────────────────────────────────────────────────────────────────

show_status() {
    if is_cachyos_enabled; then
        printf "  Current repos: ${C_GREEN}${C_BOLD}CachyOS${C_RESET}\n"
    else
        printf "  Current repos: ${C_CYAN}${C_BOLD}Arch${C_RESET}\n"
    fi
}

main() {
    printf "\n${C_BOLD}Pacman Repo Switcher${C_RESET}\n"
    show_status
    printf "\n"
    printf "  ${C_BOLD}[1]${C_RESET}  Switch to CachyOS repos\n"
    printf "  ${C_BOLD}[2]${C_RESET}  Switch to Arch repos\n"
    printf "  ${C_BOLD}[q]${C_RESET}  Quit\n"
    printf "\n"

    local choice
    read -rp "Choice: " choice

    case "$choice" in
        1)
            if is_cachyos_enabled; then
                log_warn "CachyOS repos are already enabled — nothing to do."
            else
                enable_cachyos
            fi
            ;;
        2)
            if ! is_cachyos_enabled; then
                log_warn "CachyOS repos are not present — nothing to do."
            else
                disable_cachyos
            fi
            ;;
        q|Q|"")
            log_info "Aborted."
            exit 0
            ;;
        *)
            log_err "Invalid choice: $choice"
            exit 1
            ;;
    esac

    printf "\n${C_BOLD}Done.${C_RESET}\n"
}

main "$@"
