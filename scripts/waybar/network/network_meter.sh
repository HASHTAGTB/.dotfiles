#!/usr/bin/env bash
# Waybar network meter - reads daemon state and outputs JSON

STATE_DIR="${XDG_RUNTIME_DIR:-/run/user/${UID}}/waybar-net"
STATE_FILE="$STATE_DIR/state"
HEARTBEAT_FILE="$STATE_DIR/heartbeat"
PID_FILE="$STATE_DIR/daemon.pid"

UNIT="-" UP="-" DOWN="-" CLASS="network-disconnected"

[[ -r "$STATE_FILE" ]] && read -r UNIT UP DOWN CLASS < "$STATE_FILE" || true

mkdir -p "$STATE_DIR"
touch "$HEARTBEAT_FILE"

if [[ -r "$PID_FILE" ]]; then
    read -r DAEMON_PID < "$PID_FILE"
    [[ -n "$DAEMON_PID" ]] && kill -0 "$DAEMON_PID" 2>/dev/null && kill -USR1 "$DAEMON_PID" 2>/dev/null || true
fi

fmt() {
    local s="${1:--}" len=${#1}
    if   (( len == 1 )); then printf ' %s ' "$s"
    elif (( len == 2 )); then printf ' %s'  "$s"
    else                      printf '%.3s' "$s"
    fi
}

D_UNIT=$(fmt "$UNIT")
D_UP=$(fmt "$UP")
D_DOWN=$(fmt "$DOWN")

if [[ "$CLASS" == "network-disconnected" ]]; then
    TT="Disconnected"
else
    TT="Upload: ${UP} ${UNIT}/s\\nDownload: ${DOWN} ${UNIT}/s"
fi

case "${1:-}" in
    --vertical|vertical)     TEXT="${D_UP}\\n${D_UNIT}\\n${D_DOWN}" ;;
    --horizontal|horizontal) TEXT="${D_UP} ${D_UNIT} ${D_DOWN}" ;;
    unit)                    TEXT="$D_UNIT" ;;
    up|upload)               TEXT="$D_UP" ;;
    down|download)           TEXT="$D_DOWN" ;;
    *)                       printf '{}\n'; exit 0 ;;
esac

printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' "$TEXT" "$CLASS" "$TT"
