#!/usr/bin/env bash
# mouse_move.sh
# Usage: mouse_move.sh <left|right|up|down> [step] [ticks] [interval]

DIRECTION="$1"
STEP=${2:-10}
TICKS=${3:-10}
INTERVAL=${4:-0.01}

case "$DIRECTION" in
    left)  dx=$((-STEP)); dy=0 ;;
    right) dx=$STEP;      dy=0 ;;
    up)    dx=0;          dy=$((-STEP)) ;;
    down)  dx=0;          dy=$STEP ;;
    *)
        echo "Usage: $0 <left|right|up|down> [step] [ticks] [interval]" >&2
        exit 1
        ;;
esac

for ((i = 0; i < TICKS; i++)); do
    ydotool mousemove -- "$dx" "$dy"
    sleep "$INTERVAL"
done
