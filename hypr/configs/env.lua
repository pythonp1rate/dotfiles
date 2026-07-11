-- ======================================================================
-- Environment Variables
-- ======================================================================

-- Workaround NVIDIA cursor bugs
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

hl.env("GBM_BACKEND",               "nvidia_drm")
hl.env("LIBVA_DRIVER_NAME",          "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME",  "nvidia")

-- XDG
hl.env("XDG_CURRENT_DESKTOP",  "Hyprland")
hl.env("XDG_SESSION_TYPE",      "wayland")
hl.env("XDG_SESSION_DESKTOP",   "Hyprland")

-- QT
hl.env("QT_QPA_PLATFORM",                  "wayland")
hl.env("QT_QPA_PLATFORMTHEME",             "qt5ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- Themes
hl.env("GTK_THEME",          "catppuccin-macchiato-lavender-standard+default")
hl.env("XCURSOR_THEME",      "catppuccin-macchiato-dark-cursors")
hl.env("XCURSOR_SIZE",       "22")
hl.env("HYPRCURSOR_THEME",   "catppuccin-macchiato-dark-cursors")
hl.env("HYPRCURSOR_SIZE",    "22")
