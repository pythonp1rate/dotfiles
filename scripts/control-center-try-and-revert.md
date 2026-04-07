# Control center: try new setup / revert to OG

## 1. Backup current state (do this first)

```bash
cd ~/dotfiles
mkdir -p ../dotfiles-backups
./scripts/backup-dotfiles.sh
```

Note the path it prints (e.g. `../dotfiles-backups/dotfiles-YYYYMMDD-HHMM.tar.gz`). That’s your **OG snapshot**.

---

## 2. Try the new setup

```bash
# Restart waybar (Arch logo, no notification trigger, no volume on left)
pkill waybar; waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css &

# Restart eww and open right-side control center
eww kill 2>/dev/null; eww daemon
sleep 2
eww open control-center

# Swaync on the right (notification panel)
killall swaync 2>/dev/null; swaync &
```

If your config lives under `~/dotfiles` and you symlink to `~/.config`, use the same paths (e.g. `~/.config/waybar` → your dotfiles).

---

## 3. Revert to OG if things break

Replace `BACKUP_FILE` with the tar path from step 1 (e.g. `~/dotfiles-backups/dotfiles-20260216-123456.tar.gz`).

```bash
cd ~
# Unpack backup over current dotfiles (overwrites changed files)
tar -xzvf BACKUP_FILE
# If your backup is e.g. ~/dotfiles-backups/dotfiles-20260216-123456.tar.gz:
# tar -xzvf ~/dotfiles-backups/dotfiles-20260216-123456.tar.gz

# Restart services so they use restored config
pkill waybar; waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css &
eww kill 2>/dev/null; eww daemon
killall swaync 2>/dev/null; swaync &
```

Then log out and back in (or restart Hyprland) so `hyprland.conf` is reloaded (it will stop auto-opening the control center once you’ve restored the old file).

---

## Files that were changed (for manual revert)

- `waybar/config.jsonc` – modules-left/right, custom/arch, removed notification + pulseaudio
- `waybar/style.css` – arch logo styles, removed notification styles
- `swaync/config.json` – positionX "right"
- `eww/eww.yuck` – include control-center, defwindow control-center
- `eww/eww.css` – control center styles
- `eww/widgets/control-center.yuck` – new file
- `hypr/hyprland.conf` – exec-once eww open control-center

To revert only one of these, restore that file from the backup tar (e.g. `tar -xzvf BACKUP_FILE dotfiles/waybar/config.jsonc` then move it into place).
