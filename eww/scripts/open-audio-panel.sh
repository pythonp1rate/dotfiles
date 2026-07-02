#!/bin/bash
# Open audio panel on whichever monitor is currently focused
SCREEN=$(hyprctl monitors -j 2>/dev/null | \
  python3 -c "import json,sys; m=json.load(sys.stdin); print(next((i for i,x in enumerate(m) if x.get('focused')), 0))")
eww open --toggle audio-panel --screen "${SCREEN:-0}"
