# Dotfiles

My personal dotfiles configuration for Hyprland and Neovim.

## Structure

```
dotfiles/
├─ hypr/              # Hyprland window manager config
│  ├─ config/         # Core configuration files
│  ├─ machine/        # Host-specific settings (gitignored)
│  ├─ theme/          # Visual theming
│  ├─ scripts/        # Utility scripts
│  └─ hyprland.conf   # Main entrypoint
│
├─ nvim/              # Neovim configuration
│  ├─ init.lua        # Entrypoint
│  ├─ lua/            # Lua configuration
│  │  ├─ config/      # Options and keymaps
│  │  └─ plugins/     # Plugin specifications
│  └─ lazyvim.json    # LazyVim configuration
│
└─ scripts/           # System-wide scripts
```

## Features

- **Hyprland**: Window management, keybindings, theming, and automation scripts
- **Neovim**: LazyVim-based setup with custom plugins and configurations
- **Theming**: Catppuccin-based color scheme

## Dependencies

- Hyprland
- Neovim (0.9+)
- Various utilities (see individual config files for details)

## Notes

- Machine-specific configs are gitignored - create them locally as needed
- Database connection files are gitignored for security
- Some paths may need adjustment for your system
