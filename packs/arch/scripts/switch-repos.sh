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

readonly PACMAN_CONF="/etc/pacman.conf"
readonly BACKUP_DIR="/etc/pacman.d/repo-backups"

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
    grep -qE '^\[cachyos\]' "$PACMAN_CONF"
}

detect_cpu_level() {
    local flags
    flags=$(grep -m1 '^flags' /proc/cpuinfo 2>/dev/null || echo "")
    if echo "$flags" | grep -qw 'avx512f'; then
        echo "v4"
    elif echo "$flags" | grep -qw 'avx2'; then
        echo "v3"
    else
        echo "v2"
    fi
}

backup_conf() {
    mkdir -p "$BACKUP_DIR"
    local backup="${BACKUP_DIR}/pacman.conf.$(date +%Y%m%d-%H%M%S)"
    cp "$PACMAN_CONF" "$backup"
    log_info "Backup saved: $backup"
}

# ── Repo block builders ───────────────────────────────────────────────────────

cachyos_repos_v3() {
    cat <<'EOF'

# >>> CachyOS repos >>>
[cachyos-core-v3]
Include = /etc/pacman.d/cachyos-mirrorlist

[cachyos-extra-v3]
Include = /etc/pacman.d/cachyos-mirrorlist

[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
# <<< CachyOS repos <<<
EOF
}

cachyos_repos_v4() {
    cat <<'EOF'

# >>> CachyOS repos >>>
[cachyos-core-v4]
Include = /etc/pacman.d/cachyos-mirrorlist

[cachyos-extra-v4]
Include = /etc/pacman.d/cachyos-mirrorlist

[cachyos-core-v3]
Include = /etc/pacman.d/cachyos-mirrorlist

[cachyos-extra-v3]
Include = /etc/pacman.d/cachyos-mirrorlist

[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist
# <<< CachyOS repos <<<
EOF
}

# ── Actions ───────────────────────────────────────────────────────────────────

enable_cachyos() {
    local cpu_level
    cpu_level=$(detect_cpu_level)
    log_info "Detected CPU level: x86-64-${cpu_level}"

    if ! [[ -f /etc/pacman.d/cachyos-mirrorlist ]]; then
        log_err "CachyOS mirrorlist not found at /etc/pacman.d/cachyos-mirrorlist"
        log_err "Install cachyos-mirrorlist first, then re-run this script."
        exit 1
    fi

    backup_conf

    if [[ "$cpu_level" == "v4" ]]; then
        cachyos_repos_v4 >> "$PACMAN_CONF"
    else
        cachyos_repos_v3 >> "$PACMAN_CONF"
    fi

    log_success "CachyOS repos (x86-64-${cpu_level}) added to $PACMAN_CONF"
    pacman -Syy && log_success "Package databases synced"
}

disable_cachyos() {
    backup_conf

    # Remove everything between the marker comments (inclusive)
    sed -i '/^# >>> CachyOS repos >>>/,/^# <<< CachyOS repos <<</d' "$PACMAN_CONF"

    # Fallback: strip any remaining [cachyos*] repo blocks (no markers)
    python3 - "$PACMAN_CONF" <<'PYEOF'
import sys, re

path = sys.argv[1]
text = open(path).read()

# Remove any [cachyos*] section block (header + its lines until next section or EOF)
cleaned = re.sub(
    r'\n\[cachyos[^\]]*\][^\[]*',
    '',
    text,
    flags=re.DOTALL,
)
# Collapse excessive blank lines
cleaned = re.sub(r'\n{3,}', '\n\n', cleaned)
open(path, 'w').write(cleaned)
PYEOF

    log_success "CachyOS repos removed from $PACMAN_CONF"
    pacman -Syy && log_success "Package databases synced"
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
