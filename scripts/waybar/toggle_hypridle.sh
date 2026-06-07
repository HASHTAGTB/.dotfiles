#!/usr/bin/env bash
set -uo pipefail

WAYBAR_SIGNAL=9

notify() { command -v notify-send &>/dev/null && notify-send -u "$1" -t 2000 "$2" "$3" -i "$4" || true; }

if systemctl --user is-active --quiet hypridle; then
    systemctl --user stop hypridle
    if systemctl --user is-active --quiet hypridle; then
        notify critical "Error" "Failed to stop hypridle" dialog-error
        exit 1
    fi
    notify low "Suspend Inhibited" "Automatic suspend is now OFF (Coffee Mode ☕)." dialog-warning
else
    systemctl --user start hypridle
    if ! systemctl --user is-active --quiet hypridle; then
        notify critical "Error" "Failed to start hypridle" dialog-error
        exit 1
    fi
    notify low "Suspend Enabled" "Automatic suspend is now ON." dialog-information
fi

pkill -RTMIN+"${WAYBAR_SIGNAL}" waybar 2>/dev/null || true
