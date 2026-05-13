#!/bin/bash
# Connect "madde boom" Bluetooth speaker with the correct A2DP Sink profile,
# then optionally move Spotify output to it.

DEVICE="80:C5:F2:65:5A:D8"
DEVICE_PATH="/org/bluez/hci0/dev_80_C5_F2_65_5A_D8"
A2DP_SOURCE_UUID="0000110a-0000-1000-8000-00805f9b34fb"
A2DP_SINK_UUID="0000110b-0000-1000-8000-00805f9b34fb"

swaync-client -Ia "connect-madde-boom" 2>/dev/null

echo ">>> Pairing and connecting madde boom..."
bluetoothctl pair "$DEVICE" 2>/dev/null
bluetoothctl trust "$DEVICE" 2>/dev/null
bluetoothctl connect "$DEVICE" 2>/dev/null
sleep 4

echo ">>> Switching to A2DP Sink profile..."
busctl call org.bluez "$DEVICE_PATH" org.bluez.Device1 DisconnectProfile s "$A2DP_SOURCE_UUID" 2>/dev/null
sleep 2
busctl call org.bluez "$DEVICE_PATH" org.bluez.Device1 ConnectProfile s "$A2DP_SINK_UUID" 2>/dev/null
sleep 2

swaync-client -Ir "connect-madde-boom" 2>/dev/null

BT_SINK=$(pactl list sinks short 2>/dev/null | grep "bluez_output.${DEVICE//:/_}" | awk '{print $1}')
if [ -z "$BT_SINK" ]; then
    notify-send -a "Bluetooth" -i bluetooth "madde boom" "Failed to connect. Try restarting bluetooth."
    echo "ERROR: Bluetooth sink not found. The profile switch may have failed."
    echo "Try: sudo systemctl restart bluetooth, then run this script again."
    exit 1
fi
echo ">>> Bluetooth sink found: #$BT_SINK"

SPOTIFY_INPUT=$(pactl list sink-inputs short 2>/dev/null | grep -i spotify | awk '{print $1}' | head -1)
if [ -n "$SPOTIFY_INPUT" ]; then
    pactl move-sink-input "$SPOTIFY_INPUT" "$BT_SINK"
    notify-send -a "Bluetooth" -i bluetooth "madde boom" "Connected · Spotify moved to speaker"
    echo ">>> Moved Spotify (stream #$SPOTIFY_INPUT) to madde boom"
else
    notify-send -a "Bluetooth" -i bluetooth "madde boom" "Connected"
    echo ">>> Spotify not running. You can manually switch in pavucontrol, or run:"
    echo "    pactl move-sink-input <STREAM_ID> $BT_SINK"
fi

echo ">>> Done!"
