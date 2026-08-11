-- ======================================================================
-- Window Rules
-- ======================================================================

-- ========================
-- Center Float Rules
-- ========================
hl.window_rule({
    match = { class = "^(center-float)$" },
    float = true, center = true, size = { "50%", "50%" },
})
hl.window_rule({
    match = { title = "^(.*Open Folder.*|.*Open File.*|.*Save File.*|.*Save Folder.*|.*Save Image.*|.*Save As.*)$" },
    float = true, center = true, size = { "50%", "50%" },
})

-- ========================
-- Mini Float Rules
-- ========================
hl.window_rule({
    match = { class = "^(center-float-mini)$" },
    float = true, center = true, size = { "30%", "40%" },
})
hl.window_rule({
    match = { title = "^(.*galculator.*|.*yt-dlp-gui.*|.*udiskie.*|.*Calculator.*)$" },
    float = true, center = true, size = { "30%", "40%" },
})

-- ========================
-- System Dialog Floats
-- ========================
hl.window_rule({
    match = { title = "^(xfce-polkit|weave|branchdialog|nm-connection-editor|org.twosheds.wgki|override)$" },
    float = true,
})

-- ========================
-- iwgtk (wifi manager panel)
-- ========================
hl.window_rule({
    name  = "iwgtk",
    match = { class = "^(org\\.twosheds\\.iwgtk)$" },
    float = true, center = true, opacity = "0.68 override",
})

-- ========================
-- Pavucontrol (audio panel, top-right corner)
-- ========================
hl.window_rule({
    name  = "pavucontrol",
    match = { class = "^([Pp]avucontrol|org\\.pulseaudio\\.pavucontrol)$" },
    float = true,
    size  = { 420, 500 },
    move  = { "100%-440", 45 },
    opacity = "0.68 override",
})

-- ========================
-- Scratchpads (Pyprland)
-- ========================
hl.window_rule({
    match = { class = "^(scratchpad-large)$" },
    float = true, center = true, size = { "70%", "70%" },
})
hl.window_rule({
    match = { class = "^(scratchpad)$" },
    float = true, center = true, size = { "50%", "50%" },
})
hl.window_rule({
    match = { class = "^(scratchpad-mini)$" },
    float = true, center = true, size = { "30%", "40%" },
})
-- Side scratchpads (ghostty bluetooth / volume)
hl.window_rule({
    match = { class = "^(.*com%.ghostty%-bluetooth.*|.*com%.ghostty%-volume.*)$" },
    float = true, center = true, size = { "30%", "90%" },
})

-- ========================
-- Specific App Rules
-- ========================

-- xwaylandvideobridge (invisible, for screen sharing)
hl.window_rule({
    name    = "opacity-videobridge",
    match   = { class = "^(.*xwaylandvideobridge.*)$" },
    opacity = "0.0 override",
})

-- zathura
hl.window_rule({
    match = { class = "^(.*zathura.*)$" },
    float = true, center = true, size = { "35%", "90%" },
})

-- scrcpy
hl.window_rule({
    match = { class = "^(.*scrcpy.*)$" },
    float = true, center = true,
})

-- Steam games (immediate rendering)
hl.window_rule({
    match     = { class = "^(.*steam_app.*)$" },
    immediate = true,
})

-- ========================
-- Opacity Rules – Terminals
-- ========================
hl.window_rule({
    name      = "opacity-kitty",
    match     = { class = "^(kitty)$" },
    opacity   = "0.70 override",
    immediate = true,
})
hl.window_rule({
    name    = "opacity-alacritty",
    match   = { class = "^(Alacritty)$" },
    opacity = "0.70 override",
})
hl.window_rule({
    name      = "opacity-ghostty",
    match     = { class = "^(com%.mitchellh%.ghostty)$" },
    opacity   = "0.70 override",
    immediate = true,
})

-- ========================
-- Opacity Rules – Editors
-- ========================
hl.window_rule({
    name      = "opacity-pycharm",
    match     = { class = "^(jetbrains-pycharm)$" },
    opacity   = "0.95 override",
    immediate = true,
})
hl.window_rule({
    name      = "opacity-pycharm-alt",
    match     = { class = "^(PyCharm)$" },
    opacity   = "0.95 override",
    immediate = true,
})
hl.window_rule({
    name      = "opacity-cursor",
    match     = { class = "^([Cc]ursor)$" },
    opacity   = "0.78 override",
    immediate = true,
})
hl.window_rule({
    name      = "opacity-cursor-alt",
    match     = { class = "^(.*[Cc]ursor.*)$" },
    opacity   = "0.78 override",
    immediate = true,
})
hl.window_rule({
    name    = "opacity-code",
    match   = { class = "^(Code)$" },
    opacity = "0.78 override",
})
hl.window_rule({
    name    = "opacity-vscodium",
    match   = { class = "^(VSCodium)$" },
    opacity = "0.78 override",
})
hl.window_rule({
    name      = "opacity-antigravity",
    match     = { class = "^(antigravity)$" },
    opacity   = "0.78 override",
    immediate = true,
})
hl.window_rule({
    name      = "opacity-antigravity-ide",
    match     = { class = "^(antigravity-ide)$" },
    opacity   = "0.78 override",
    immediate = true,
})

-- ========================
-- Opacity Rules – Chat / Media
-- ========================
hl.window_rule({
    name    = "opacity-discord",
    match   = { class = "^(discord)$" },
    opacity = "0.90 override",
})
hl.window_rule({
    name    = "opacity-spotify",
    match   = { class = "^(.*[Ss]potify.*)$" },
    opacity = "0.70 override",
})

-- ========================
-- Opacity Rules – Launchers / Utils
-- ========================
hl.window_rule({
    name    = "opacity-rofi",
    match   = { class = "^(rofi)$" },
    opacity = "0.38 override",
})
hl.window_rule({
    name      = "opacity-nvim",
    match     = { title = "^(nvim.*)$" },
    opacity   = "0.85 override",
    immediate = true,
})
hl.window_rule({
    name      = "opacity-neovim",
    match     = { title = "^(Neovim.*)$" },
    opacity   = "0.85 override",
    immediate = true,
})
hl.window_rule({
    name      = "opacity-wifi-manager",
    match     = { class = "^(wifi-manager)$" },
    opacity   = "0.38 override",
    immediate = true,
})
