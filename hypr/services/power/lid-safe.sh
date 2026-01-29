#!/usr/bin/env zsh
# Safe lid handler for NVIDIA + Hyprland
# Prevents crashes during hotplug by delaying actions until GPU and EDID are ready.

set -euo pipefail

LID_STATE="$1"   # "open" or "close"

LOG="/tmp/lid-safe.log"
echo "$(date): Lid event: $LID_STATE" >> "$LOG"

# Wait for system stability
sleep 2

# Check if Hyprland is running
if ! pgrep -x "Hyprland" >/dev/null; then
    echo "Hyprland not running, exiting" >> "$LOG"
    exit 0
fi

# Check if monitors are readable
if ! hyprctl -j monitors >/dev/null 2>&1; then
    echo "hyprctl unavailable, exiting" >> "$LOG"
    exit 0
fi

# Monitor names
LAPTOP="eDP-1"
EXTERNAL="HDMI-A-1"

# If lid closed and external is connected → switch to external
if [[ "$LID_STATE" == "close" ]]; then
    if hyprctl -j monitors | jq -e ".[] | select(.name==\"$EXTERNAL\")" >/dev/null; then
        echo "Switching to external only" >> "$LOG"
        hyprctl keyword monitor "$EXTERNAL,preferred,0x0,1"
        hyprctl keyword monitor "$LAPTOP,disable"
    else
        echo "No external connected, ignoring" >> "$LOG"
    fi
fi

# If lid opened → restore laptop display
if [[ "$LID_STATE" == "open" ]]; then
    echo "Restoring laptop display" >> "$LOG"
    hyprctl keyword monitor "$LAPTOP,2560x1600@60,0x0,1"

    # If external exists, keep both
    if hyprctl -j monitors | jq -e ".[] | select(.name==\"$EXTERNAL\")" >/dev/null; then
        hyprctl keyword monitor "$EXTERNAL,preferred,2560x0,1"
    fi
fi

exit 0
