-- ======================================================================
-- Misc Configuration
-- ======================================================================

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },

    misc = {
        always_follow_on_dnd       = true,
        disable_hyprland_logo      = true,
        disable_splash_rendering   = true,
        vrr                        = 0,
        animate_manual_resizes     = true,
        animate_mouse_windowdragging = false,
        enable_swallow             = true,
        focus_on_activate          = true,
        font_family                = "JetBrainsMono Nerd Font",
    },

    binds = {
        movefocus_cycles_fullscreen = false,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    dwindle = {
        preserve_split = true,
        force_split    = 0,
    },
})
