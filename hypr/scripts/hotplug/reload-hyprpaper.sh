#!/usr/bin/env bash

# Kill any running hyprpaper cleanly
pkill -x hyprpaper 2>/dev/null
sleep 0.3

# Start hyprpaper fully detached (so fish doesn't track it)
nohup hyprpaper >/dev/null 2>&1 &
disown

sleep 0.5

# Your wallpaper path
WALL="/home/mads/Pictures/wallpapers/terpinedream_scaled.png"

# Apply wallpaper to all currently active monitors
hyprctl monitors -j | jq -r '.[].name' | while read -r MON; do
    hyprctl hyprpaper wallpaper "$MON,$WALL"
done
