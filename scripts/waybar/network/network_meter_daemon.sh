#!/usr/bin/env bash
set -euo pipefail
export LC_ALL=C

if [[ -f /usr/lib/bash/sleep ]]; then
    enable -f /usr/lib/bash/sleep sleep 2>/dev/null || true
fi

RUNTIME="${XDG_RUNTIME_DIR:-/run/user/${UID:-$(id -u)}}"
STATE_DIR="$RUNTIME/waybar-net"
STATE_FILE="$STATE_DIR/state"
HEARTBEAT_FILE="$STATE_DIR/heartbeat"
PID_FILE="$STATE_DIR/daemon.pid"

mkdir -p "$STATE_DIR"
printf '%s\n' "$$" > "$PID_FILE"

trap 'rm -rf "$STATE_DIR"' EXIT
trap ':' USR1

if [[ -n "${EPOCHREALTIME+x}" ]]; then
    get_time_us() {
        local -n _out=$1
        local s us
        IFS=. read -r s us <<< "$EPOCHREALTIME"
        us="${us}000000"
        _out=$(( s * 1000000 + 10#${us:0:6} ))
    }
else
    get_time_us() {
        local -n _out=$1
        _out=$(( $(printf '%(%s)T' -1) * 1000000 ))
    }
fi

find_active_iface() {
    local -n _iface_out=$1
    local iface dest gateway flags refcnt use metric mask mtu window irtt

    while read -r iface dest gateway flags refcnt use metric mask mtu window irtt; do
        if [[ "$dest" == "00000000" ]] && [[ -r "/sys/class/net/$iface/statistics/rx_bytes" ]]; then
            _iface_out="$iface"
            return 0
        fi
    done < /proc/net/route

    for state_file in /sys/class/net/*/operstate; do
        [[ -r "$state_file" ]] || continue
        local if_name="${state_file%/operstate}"
        if_name="${if_name##*/}"
        [[ "$if_name" == "lo" ]] && continue
        local state
        read -r state < "$state_file" 2>/dev/null || state="unknown"
        [[ "$state" == "up" ]] || continue
        if [[ -r "/sys/class/net/$if_name/statistics/rx_bytes" ]]; then
            _iface_out="$if_name"
            return 0
        fi
    done

    _iface_out=""
    return 1
}

format_speed() {
    local -n _unit=$1 _tx=$2 _rx=$3 _class=$4
    local rx_d=$5 tx_d=$6
    local max=$(( rx_d > tx_d ? rx_d : tx_d ))

    if (( max >= 1048576 )); then
        local tx_x10=$(( tx_d * 10 / 1048576 ))
        local rx_x10=$(( rx_d * 10 / 1048576 ))
        (( tx_x10 < 100 )) && _tx="$((tx_x10 / 10)).$((tx_x10 % 10))" || _tx="$((tx_x10 / 10))"
        (( rx_x10 < 100 )) && _rx="$((rx_x10 / 10)).$((rx_x10 % 10))" || _rx="$((rx_x10 / 10))"
        _unit="MB"
        _class="network-mb"
    else
        _tx=$(( tx_d / 1024 ))
        _rx=$(( rx_d / 1024 ))
        _unit="KB"
        _class="network-kb"
    fi
}

check_heartbeat() {
    local -n _hb_time=$1
    local now=$2
    if [[ -f "$HEARTBEAT_FILE" ]]; then
        _hb_time=$(stat -c %Y "$HEARTBEAT_FILE" 2>/dev/null) || _hb_time=$now
    else
        _hb_time=$now
    fi
}

rx_prev=0 tx_prev=0 iface="" current_iface=""
iface_counter=0 hb_counter=2 hb_time=0
WRAP_LIMIT=4294967296

while :; do
    printf -v now '%(%s)T' -1

    if (( ++hb_counter >= 3 )); then
        hb_counter=0
        check_heartbeat hb_time "$now"
    fi

    if (( now - hb_time > 10 )); then
        sleep 600 &
        wait $! || true
        hb_counter=10
        continue
    fi

    if (( ++iface_counter >= 5 )) || [[ -z "$iface" ]] || [[ ! -r "/sys/class/net/$iface/statistics/rx_bytes" ]]; then
        iface_counter=0
        find_active_iface current_iface || current_iface=""
    else
        current_iface="$iface"
    fi

    if [[ -z "$current_iface" ]]; then
        printf '%s\n' "- - - network-disconnected" > "$STATE_FILE.tmp"
        mv -f "$STATE_FILE.tmp" "$STATE_FILE"
        rx_prev=0; tx_prev=0; iface=""
        sleep 3 || true
        continue
    fi

    get_time_us start_time

    if [[ "$current_iface" != "$iface" ]]; then
        iface="$current_iface"
        rx_prev=0; tx_prev=0
    fi

    read -r rx_now < "/sys/class/net/$iface/statistics/rx_bytes" 2>/dev/null || rx_now=0
    read -r tx_now < "/sys/class/net/$iface/statistics/tx_bytes" 2>/dev/null || tx_now=0

    if (( rx_prev == 0 && tx_prev == 0 )); then
        rx_prev=$rx_now; tx_prev=$tx_now
        sleep 1 || true
        continue
    fi

    rx_delta=$(( rx_now - rx_prev ))
    tx_delta=$(( tx_now - tx_prev ))

    (( rx_delta < 0 )) && rx_delta=$(( rx_delta + WRAP_LIMIT ))
    (( tx_delta < 0 )) && tx_delta=$(( tx_delta + WRAP_LIMIT ))
    (( rx_delta < 0 )) && rx_delta=0
    (( tx_delta < 0 )) && tx_delta=0

    rx_prev=$rx_now
    tx_prev=$tx_now

    format_speed unit tx_fmt rx_fmt class "$rx_delta" "$tx_delta"
    printf '%s %s %s %s\n' "$unit" "$tx_fmt" "$rx_fmt" "$class" > "$STATE_FILE.tmp"
    mv -f "$STATE_FILE.tmp" "$STATE_FILE"

    get_time_us end_time
    sleep_us=$(( 1000000 - (end_time - start_time) ))

    if   (( sleep_us <= 0 ));      then :
    elif (( sleep_us >= 1000000 )); then sleep 1 || true
    else
        printf -v sleep_sec "0.%06d" "$sleep_us"
        sleep "$sleep_sec" || true
    fi
done
