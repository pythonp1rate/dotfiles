#!/usr/bin/env bash

# Get real backlight device
DEV="amdgpu_bl2"

# Read current brightness (0-255 or similar)
BRIGHT=$(cat /sys/class/backlight/$DEV/brightness)
MAX=$(cat /sys/class/backlight/$DEV/max_brightness)

# Convert to percent (integer)
PCT=$(( BRIGHT * 100 / MAX ))

# Show slider
VALUE=$(printf "%.0f\n" $(seq 0 100) | wofi --dmenu --prompt "Brightness ($PCT%)")

# Exit if no input
[ -z "$VALUE" ] && exit 0

# Convert percentage back to brightness value
NEW=$(echo "$VALUE * $MAX / 100" | bc | cut -d'.' -f1)

# Apply brightness
brightnessctl --device=$DEV set $NEW

