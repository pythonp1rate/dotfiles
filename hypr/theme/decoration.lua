-- ======================================================================
-- Decoration & General Styling (Catppuccin Macchiato)
-- ======================================================================

local c = require("theme.colors")

hl.config({
    general = {
        border_size      = 2,
        col = {
            active_border   = "rgba(" .. c.lavender .. "B0)",
            inactive_border = "rgba(" .. c.text     .. "40)",
        },
        gaps_in          = 3,
        gaps_out         = 4,
        resize_on_border = true,
    },

    decoration = {
        rounding         = 4,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled           = true,
            size              = 8,
            passes            = 3,
            ignore_opacity    = false,
            new_optimizations = true,
            xray              = false,
            noise             = 0.0,
            popups            = true,
        },

        shadow = {
            enabled        = false,
            range          = 10,
            scale          = 1,
            render_power   = 5,
            color          = "rgb(" .. c.surface0 .. ")",
            color_inactive = "rgb(" .. c.crust    .. ")",
        },

        dim_inactive = false,
        dim_strength = 0.05,
    },

    group = {
        col = {
            border_inactive      = "rgba(" .. c.lavender .. "69)",
            border_active        = {
                colors = {
                    "rgba(" .. c.text     .. "ee)",
                    "rgba(" .. c.lavender .. "69)",
                    "rgba(" .. c.lavender .. "69)",
                    "rgba(" .. c.text     .. "ee)",
                },
                angle = 45,
            },
            border_locked_inactive = "rgba(" .. c.lavender .. "69)",
            border_locked_active   = {
                colors = {
                    "rgba(" .. c.text     .. "ee)",
                    "rgba(" .. c.lavender .. "69)",
                    "rgba(" .. c.lavender .. "69)",
                    "rgba(" .. c.text     .. "ee)",
                },
                angle = 45,
            },
        },

        groupbar = {
            gradients                 = true,
            gradient_rounding         = 7,
            indicator_height          = 0,
            gradient_round_only_edges = true,
            col = {
                active          = "rgba(" .. c.lavender .. "CC)",
                inactive        = "rgba(" .. c.subtext1 .. "99)",
                locked_active   = "rgba(" .. c.maroon   .. "CC)",
                locked_inactive = "rgba(" .. c.subtext1 .. "99)",
            },
            font_family  = "JetBrainsMono Nerd Font",
            font_size    = 15,
            text_color   = "rgb(" .. c.crust .. ")",
            height       = 20,
        },
    },
})
