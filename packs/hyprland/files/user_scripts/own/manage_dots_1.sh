#!/bin/bash

# --- Configuration ---
REPO_URL="git@github.com:HASHTAGTB/linux-config.git"
DOT_DIR="$HOME/dotfiles"
FILES=(
    ".config/hypr/edit_here"
    "user_scripts/theme_matugen/theme_ctl.sh"
    ".config/waypaper/congig.ini"
    ".config/hypr/shaders/saturation.glsl"
    ".zshrc"
)

# Files to back up as reference only (No symlinks, requires sudo)
SYSTEM_FILES=(
    "/etc/fstab"
    "/etc/pacman.conf"
    "/etc/resolv.conf" # Your DNS settings
)

MAIN=(
    adw-gtk-theme
    awesome-terminal-fonts
    blueman
    btop
    btrfs-assistant
    chezmoi
    cups-pdf
    fastfetch
    flatpak
    gdu
    git-delta
    gnome-calculator
    gnome-clocks
    gnome-disk-utility
    gum
    htop
    hypridle
    hyprlock
    hyprpicker
    hyprpolkitagent
    kopia
    loupe
    mpv-mpris
    nvtop
    imagemagick
    nwg-look
    pavucontrol
    polkit-kde-agent
    protonplus
    qt5-graphicaleffects
    qt5ct
    qt6-wayland
    qt6ct
    reflector
    tesseract-data-eng
    ttf-jetbrains-mono-nerd
    ttf-cascadia-code-nerd
    sddm
    swappy
    swaync
    wavemon
    waybar
    waypaper
    wev
    wlogout
    zen-browser-bin
)

OPTIONAL=(
    cantarell-fonts
    claude-code
    code
    gimp
    github-desktop
    goverlay
    krita
    lazygit
    libreoffice
    lutris
    obsidian
    octopi
    opencode
    quodlibet
    scrypy
    uget
    vesktop-bin
)

AUR=(
    android-studio
    fluent-icon-theme-git
    fsearch
    dragon-drop
    hyprshade
    input-remapper-git
    pacseek-bin
    pinta
    spotify
    twintaillauncher-bin
    xdg-desktop-portal-termfilechooser-hunkyburrito-git
    xdg-terminal-exec
)
mkdir -p "$DOT_DIR/system_reference"

case $1 in
    backup)
        echo "📦 Starting Backup..."
        for item in "${FILES[@]}"; do
            if [ -e "$HOME/$item" ]; then
                mkdir -p "$DOT_DIR/$(dirname "$item")"
                if [ ! -L "$HOME/$item" ]; then
                    mv "$HOME/$item" "$DOT_DIR/$item"
                    ln -s "$DOT_DIR/$item" "$HOME/$item"
                fi
            fi
        done

        echo "📂 Copying system files (DNS/Fstab) for reference..."
        for sys_file in "${SYSTEM_FILES[@]}"; do
            if [ -f "$sys_file" ]; then
                sudo cp "$sys_file" "$DOT_DIR/system_reference/"
                sudo chown $USER:$USER "$DOT_DIR/system_reference/$(basename "$sys_file")"
            fi
        done

        echo "📝 Updating package list..."
        pacman -Qqe > "$DOT_DIR/pkglist.txt"

        cd "$DOT_DIR" || exit
        git add .
        git commit -m "Backup: $(date +'%Y-%m-%d %H:%M')"
        git push -f origin main
        echo "🔥 System state pushed to GitHub."
        ;;

    restore)
        echo "🔗 Restoring symlinks..."
        for item in "${FILES[@]}"; do
            mkdir -p "$(dirname "$HOME/$item")"
            rm -rf "$HOME/$item"
            ln -s "$DOT_DIR/$item" "$HOME/$item"
        done
        chmod +x "$HOME/user_scripts/theme_matugen/theme_ctl.sh"
        echo "✅ Restore complete. Check system_reference/ for manual tweaks."
        ;;
esac
