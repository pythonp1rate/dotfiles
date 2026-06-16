#!/bin/bash
# Watch for madde boom to connect and automatically run the A2DP fix script.

DEVICE_MAC="80:C5:F2:65:5A:D8"
DEVICE_NAME="madde boom"

echo "Watching for $DEVICE_NAME ($DEVICE_MAC)..."

bluetoothctl monitor | while read -r line; do
    if echo "$line" | grep -q "$DEVICE_MAC" && echo "$line" | grep -q "Connected: yes"; then
        echo "$(date): $DEVICE_NAME connected — running fix script..."
        sleep 2
        bash /home/mads/dotfiles/scripts/connect-madde-boom.sh
    fi
done
