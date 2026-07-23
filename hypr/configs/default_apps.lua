-- ======================================================================
-- Default Apps
-- ======================================================================

local launcher        = "rofi -show drun"
local launcher_windows = "rofi -show window"

local bar             = "waybar"
local bar_toggle      = "killall -SIGUSR1 waybar"
local bar_reload      = "killall waybar; waybar"

local notifications_menu         = "swaync-client"
local notifications_menu_read    = notifications_menu .. " -C"
local notifications_menu_toggle  = notifications_menu .. " -t"
local notifications_menu_disturb = notifications_menu .. " -d"
local notifications_menu_reload  = notifications_menu .. " -R && " .. notifications_menu .. " -rs"

local browser          = "zen-browser"
local notetaking_app   = "obsidian"
local terminal         = "ghostty --gtk-single-instance=true"
local office_suite     = "libreoffice"
local editor           = terminal .. " nvim"
local alter_editor     = "vscodium"
local file_manager     = "yazi"
local alter_file_manager = "nemo"

-- Export so binds.lua can use them
return {
    launcher          = launcher,
    launcher_windows  = launcher_windows,
    bar               = bar,
    bar_toggle        = bar_toggle,
    bar_reload        = bar_reload,
    notifications_menu         = notifications_menu,
    notifications_menu_read    = notifications_menu_read,
    notifications_menu_toggle  = notifications_menu_toggle,
    notifications_menu_disturb = notifications_menu_disturb,
    notifications_menu_reload  = notifications_menu_reload,
    browser           = browser,
    notetaking_app    = notetaking_app,
    terminal          = terminal,
    office_suite      = office_suite,
    editor            = editor,
    alter_editor      = alter_editor,
    file_manager      = file_manager,
    alter_file_manager = alter_file_manager,
}
