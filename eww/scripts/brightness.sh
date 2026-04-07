#!/usr/bin/env bash
DEV="amdgpu_bl2"
CUR=$(cat /sys/class/backlight/$DEV/brightness)
MAX=$(cat /sys/class/backlight/$DEV/max_brightness)
echo $(( CUR * 100 / MAX ))
