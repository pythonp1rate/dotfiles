# Swaync control center – icons (JetBrains Mono Nerd Font)

All icons use **Font Awesome** codepoints so they work with **JetBrains Mono Nerd Font**.

## Cheat sheet (pick any icon)

**Official Nerd Font cheat sheet:**  
https://www.nerdfonts.com/cheat-sheet  

Search by name (e.g. "cat", "wifi", "pencil"). Click an icon to see its Unicode. Use that character in the config if you want to swap one.

**JetBrains Mono Nerd Font download:**  
https://www.nerdfonts.com/font-downloads (choose JetBrainsMono)  
or: https://github.com/ryanoasis/nerd-fonts/releases

---

## Icons currently used

| Widget        | Font Awesome name | Unicode  | Use              |
|---------------|-------------------|----------|------------------|
| Label         | fa-cat            | U+F008   | Cat before user@host |
| Header button | fa-pencil         | U+F040   | Edit config      |
| Header button | fa-cog            | U+F013   | Settings         |
| Header button | fa-refresh        | U+F021   | Restart swaync   |
| Header button | fa-power-off      | U+F011   | Power / wlogout  |
| Toggle        | fa-wifi           | U+F1EB   | WiFi             |
| Toggle        | fa-bluetooth      | U+F293   | Bluetooth        |
| Toggle        | fa-volume-up       | U+F028   | Audio            |
| Toggle        | fa-plane          | U+F072   | Airplane mode    |

## To change an icon

1. Open https://www.nerdfonts.com/cheat-sheet and find an icon you like (prefer **Font Awesome** for best compatibility).
2. Note the Unicode (e.g. U+F008). In JSON/Python that’s `\uF008` (4-digit) or `\uF1EB` for U+F1EB.
3. Edit `config.json`: in `widget-config` → `label` → `text` for the cat, or `buttons-grid` → `actions` → the entry you want → `label`, and set it to the new character (or run a small script that writes that Unicode into the config).
