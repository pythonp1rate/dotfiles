-- ======================================================================
-- Hyprland Main Config
-- ======================================================================

-- ========================
-- Config Modules
-- ========================
require("configs.env")
require("machine.monitors")
require("configs.workspaces")
require("configs.binds")
require("configs.input")
require("configs.misc")
require("configs.plugins")
require("theme.theme")

-- ========================
-- Autostart
-- ========================
hl.on("hyprland.start", function()
    local home = os.getenv("HOME")

    hl.exec_cmd("swaync")
    hl.exec_cmd("wifi-manager")
    hl.exec_cmd(home .. "/.config/wayscripts/swaync-autoopen.sh")
    hl.exec_cmd("eww daemon")
    hl.exec_cmd("waybar -c " .. home .. "/.config/waybar/config.jsonc -s " .. home .. "/.config/waybar/style.css")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("sh -c 'sleep 2 && awww img -o eDP-1 " .. home .. "/Pictures/wallpapers/forrest.jpg && awww img -o HDMI-A-1 " .. home .. "/Pictures/wallpapers/forrest.jpg'")
end)
