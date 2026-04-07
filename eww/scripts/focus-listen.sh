#!/usr/bin/env bash

while true; do
    sleep 0.1

    # If popup not open, do nothing
    if ! eww list-windows | grep -q "brightness-popup"; then
        continue
    fi

    # If popup loses focus -> close it
    if ! hyprctl activewindow | grep -q "brightness-popup"; then
        eww close brightness-popup
    fi
done
