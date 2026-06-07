#!/bin/bash
# Audio data provider for eww audio panel

cmd="${1:-volume}"

case "$cmd" in
  volume)
    pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null \
      | grep -oP '\d+(?=%)' | head -1 || echo "0"
    ;;

  muted)
    pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null \
      | grep -q "yes" && echo "true" || echo "false"
    ;;

  streams)
    python3 - << 'EOF'
import subprocess, json, re

def get_default_sink():
    out = subprocess.run(['pactl','info'], capture_output=True, text=True).stdout
    for line in out.splitlines():
        if 'Default Sink:' in line:
            return line.split(':', 1)[1].strip()
    return ''

def get_sink_map():
    out = subprocess.run(['pactl','list','sinks'], capture_output=True, text=True).stdout
    sinks = {}
    idx = None
    for line in out.splitlines():
        m = re.match(r'^Sink #(\d+)', line)
        if m:
            idx = int(m.group(1))
            sinks[idx] = {'name': '', 'description': ''}
        elif idx is not None:
            stripped = line.strip()
            if stripped.startswith('Name:'):
                sinks[idx]['name'] = stripped.split(':', 1)[1].strip()
            elif stripped.startswith('Description:'):
                sinks[idx]['description'] = stripped.split(':', 1)[1].strip()
    return sinks

sink_map = get_sink_map()
raw = subprocess.run(['pactl','list','sink-inputs'], capture_output=True, text=True).stdout
blocks = re.split(r'(?=^Sink Input #)', raw, flags=re.MULTILINE)
result = []

for block in blocks:
    if not block.startswith('Sink Input #'):
        continue
    idx_m = re.search(r'Sink Input #(\d+)', block)
    if not idx_m:
        continue
    idx = int(idx_m.group(1))

    APP_ICONS = {
        'spotify':       '󰓇',
        'firefox':       '󰈹',
        'chromium':      '󰊯',
        'chrome':        '󰊯',
        'google-chrome': '󰊯',
        'vlc':           '󰕼',
        'mpv':           '󰐊',
        'steam':         '󰓓',
        'discord':       '󰙯',
        'telegram':      '󰔤',
        'rhythmbox':     '󰓃',
        'audacity':      '󰒓',
        'obs':           '󰄀',
        'brave':         '󰯌',
        'opera':         '',
    }

    name = 'Unknown'
    binary = ''
    for pat in [r'application\.name = "([^"]+)"', r'media\.name = "([^"]+)"',
                r'application\.process\.binary = "([^"]+)"']:
        m = re.search(pat, block)
        if m:
            if 'binary' in pat and not name != 'Unknown':
                binary = m.group(1)
            else:
                name = m.group(1)
            if name != 'Unknown':
                break
    bin_m = re.search(r'application\.process\.binary = "([^"]+)"', block)
    if bin_m:
        binary = bin_m.group(1)

    icon = '󰕾'
    for key, val in APP_ICONS.items():
        if key in name.lower() or key in binary.lower():
            icon = val
            break

    # Shorten long names
    name = name.strip()
    name = name[0].upper() + name[1:] if name else name
    if len(name) > 22:
        name = name[:20] + '…'

    vol_m = re.search(r'Volume:.*?(\d+)%', block)
    volume = int(vol_m.group(1)) if vol_m else 100

    sink_m = re.search(r'^\s+Sink:\s+(\d+)', block, re.MULTILINE)
    sink_idx = int(sink_m.group(1)) if sink_m else 0

    sink_desc = sink_map.get(sink_idx, {}).get('description', 'Unknown')
    if len(sink_desc) > 18:
        sink_desc = sink_desc[:16] + '…'

    mute_m = re.search(r'Mute:\s+(\w+)', block)
    muted = mute_m.group(1) == 'yes' if mute_m else False

    result.append({
        'index': idx,
        'name': name,
        'icon': icon,
        'volume': volume,
        'sink': sink_desc,
        'sink_index': sink_idx,
        'muted': muted
    })

print(json.dumps(result if result else []))
EOF
    ;;

  cycle-sink)
    INPUT_IDX="$2"
    SINKS=($(pactl list sinks short | awk '{print $1}'))
    N=${#SINKS[@]}
    [ $N -eq 0 ] && exit 0
    CURRENT=$(pactl list sink-inputs 2>/dev/null \
      | awk "/Sink Input #${INPUT_IDX}/{f=1} f && /^\s+Sink:/{print \$2; exit}")
    for i in "${!SINKS[@]}"; do
      if [ "${SINKS[$i]}" = "$CURRENT" ]; then
        NEXT="${SINKS[$(( (i+1) % N ))]}"
        pactl move-sink-input "$INPUT_IDX" "$NEXT"
        exit 0
      fi
    done
    pactl move-sink-input "$INPUT_IDX" "${SINKS[0]}"
    ;;

  toggle-view)
    VIEW="$2"
    CURRENT=$(eww get audio-view 2>/dev/null || echo "master")
    if [ "$CURRENT" = "$VIEW" ]; then
      eww update audio-view=master
    else
      eww update audio-view="$VIEW"
    fi
    ;;

  sinks)
    python3 - << 'EOF'
import subprocess, json, re

info = subprocess.run(['pactl','info'], capture_output=True, text=True).stdout
default_sink = ''
for line in info.splitlines():
    if 'Default Sink:' in line:
        default_sink = line.split(':', 1)[1].strip()

raw = subprocess.run(['pactl','list','sinks'], capture_output=True, text=True).stdout
blocks = re.split(r'(?=^Sink #)', raw, flags=re.MULTILINE)
result = []
seen_devices = set()

for block in blocks:
    if not block.startswith('Sink #'):
        continue
    idx_m = re.search(r'Sink #(\d+)', block)
    if not idx_m:
        continue
    idx = int(idx_m.group(1))

    name_m  = re.search(r'^\s+Name:\s+(.+)$', block, re.MULTILINE)
    desc_m  = re.search(r'Description:\s+(.+)$', block, re.MULTILINE)

    name = name_m.group(1).strip() if name_m else ''
    desc = desc_m.group(1).strip() if desc_m else name

    # Skip duplicate pro-output channels — keep only the default or first per device
    if 'pro-output' in name:
        # Extract device id (pci address) to deduplicate
        dev_m = re.search(r'(pci-[^.]+)', name)
        dev_key = dev_m.group(1) if dev_m else name
        if dev_key in seen_devices and name != default_sink:
            continue
        seen_devices.add(dev_key)

    # Clean up description
    desc = re.sub(r'High Definition Audio Controller', 'HD Audio', desc)
    desc = re.sub(r'Virtual Surround Sound', 'Surround', desc)
    desc = re.sub(r'Analog Stereo', 'Analog', desc)
    desc = re.sub(r'\s+Pro\s*\d*$', '', desc).strip()
    if len(desc) > 26:
        desc = desc[:24] + '…'

    result.append({
        'index': idx,
        'name': name,
        'description': desc,
        'is_default': name == default_sink
    })

print(json.dumps(result if result else []))
EOF
    ;;
esac
