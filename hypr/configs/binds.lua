-- ======================================================================
-- Keybindings
-- ======================================================================

local apps    = require("configs.default_apps")
local mainMod = "SUPER"
local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"
local rofi_scripts = os.getenv("HOME") .. "/.config/rofi/scripts"

-- ========================
-- APPLICATIONS
-- ========================
hl.bind(mainMod .. " + RETURN",      hl.dsp.exec_cmd(scripts .. "/launch_app " .. apps.terminal))
hl.bind(mainMod .. " + W",           hl.dsp.exec_cmd(scripts .. "/launch_app " .. apps.browser))
hl.bind(mainMod .. " + E",           hl.dsp.exec_cmd(scripts .. "/launch_app " .. apps.alter_file_manager))
hl.bind(mainMod .. " SHIFT + O",     hl.dsp.exec_cmd(scripts .. "/launch_app " .. apps.office_suite))
hl.bind(mainMod .. " + K",           hl.dsp.exec_cmd("kitty"))

-- ========================
-- LAUNCHERS & MENUS
-- ========================
hl.bind(mainMod .. " + TAB",         hl.dsp.exec_cmd(apps.launcher))
hl.bind(mainMod .. " + ESCAPE",      hl.dsp.exec_cmd(apps.launcher_windows))
hl.bind(mainMod .. " + 61",          hl.dsp.exec_cmd(rofi_scripts .. "/keybindings/keybindings"))
hl.bind(mainMod .. " + Y",           hl.dsp.exec_cmd(rofi_scripts .. "/clipboard/clipboard"))
hl.bind(mainMod .. " CTRL + E",      hl.dsp.exec_cmd(rofi_scripts .. "/emoji/emoji"))
hl.bind(mainMod .. " + P",           hl.dsp.exec_cmd("rofi-rbw --action=copy --clear-after 10"))
hl.bind(mainMod .. " SHIFT + W",     hl.dsp.exec_cmd(rofi_scripts .. "/wallpaper/wallpaper"))
hl.bind("ALT + ESCAPE",              hl.dsp.exec_cmd(rofi_scripts .. "/powermenu/powermenu"))
hl.bind(",148",                       hl.dsp.exec_cmd(apps.launcher))

-- ========================
-- WINDOW MANAGEMENT
-- ========================
hl.bind(mainMod .. " + Q",           hl.dsp.window.close())
hl.bind(mainMod .. " + A",           hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F",           hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + S",           hl.dsp.exec_cmd("hyprctl dispatch layoutmsg togglesplit"))
hl.bind(mainMod .. " + C",           hl.dsp.window.center())
hl.bind("ALT + TAB",                 hl.dsp.exec_cmd("hyprctl dispatch cyclenext"))

-- ========================
-- MOUSE DRAGGING & RESIZING
-- ========================
hl.bind(mainMod .. " + mouse:272",   hl.dsp.window.move({}),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",   hl.dsp.window.resize({}), { mouse = true })

-- ========================
-- WINDOW FOCUS
-- ========================
hl.bind(mainMod .. " + left",        hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + right",       hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",          hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + down",        hl.dsp.focus({ direction = "down"  }))
hl.bind(mainMod .. " + H",           hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + J",           hl.dsp.focus({ direction = "down"  }))
-- Note: SUPER+K conflicts with kitty launch above; K used for focus up here
hl.bind(mainMod .. " + L",           hl.dsp.focus({ direction = "right" }))

-- ========================
-- WINDOW MOVEMENT
-- ========================
hl.bind(mainMod .. " SHIFT + left",  hl.dsp.window.move({ direction = "left"  }))
hl.bind(mainMod .. " SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " SHIFT + up",    hl.dsp.window.move({ direction = "up"    }))
hl.bind(mainMod .. " SHIFT + down",  hl.dsp.window.move({ direction = "down"  }))
hl.bind(mainMod .. " SHIFT + H",     hl.dsp.window.move({ direction = "left"  }))
hl.bind(mainMod .. " SHIFT + J",     hl.dsp.window.move({ direction = "down"  }))
hl.bind(mainMod .. " SHIFT + K",     hl.dsp.window.move({ direction = "up"    }))
hl.bind(mainMod .. " SHIFT + L",     hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " SHIFT + backslash", hl.dsp.exec_cmd(scripts .. "/window_move_by_rules"))

-- ========================
-- WINDOW RESIZING (submap)
-- ========================
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
    hl.bind("left",   hl.dsp.window.resize({ x = -50, y = 0   }), { repeat = true })
    hl.bind("right",  hl.dsp.window.resize({ x = 50,  y = 0   }), { repeat = true })
    hl.bind("up",     hl.dsp.window.resize({ x = 0,   y = -50 }), { repeat = true })
    hl.bind("down",   hl.dsp.window.resize({ x = 0,   y = 50  }), { repeat = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + left",        hl.dsp.window.resize({ x = -50, y = 0   }), { repeat = true })
hl.bind(mainMod .. " + right",       hl.dsp.window.resize({ x = 50,  y = 0   }), { repeat = true })
hl.bind(mainMod .. " + up",          hl.dsp.window.resize({ x = 0,   y = -50 }), { repeat = true })
hl.bind(mainMod .. " + down",        hl.dsp.window.resize({ x = 0,   y = 50  }), { repeat = true })

hl.bind(mainMod .. " CTRL + left",   hl.dsp.window.resize({ x = -10, y = 0   }), { repeat = true })
hl.bind(mainMod .. " CTRL + right",  hl.dsp.window.resize({ x = 10,  y = 0   }), { repeat = true })
hl.bind(mainMod .. " CTRL + up",     hl.dsp.window.resize({ x = 0,   y = -10 }), { repeat = true })
hl.bind(mainMod .. " CTRL + down",   hl.dsp.window.resize({ x = 0,   y = 10  }), { repeat = true })

-- ========================
-- WORKSPACES
-- ========================
-- Smart per-monitor workspace switching
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = "r~1" }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = "r~2" }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = "r~3" }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = "r~4" }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = "r~5" }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = "r~6" }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = "r~7" }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = "r~8" }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = "r~9" }))

-- Move windows to workspaces
hl.bind(mainMod .. " SHIFT + 1", hl.dsp.window.move_to_workspace({ workspace = "r~1" }))
hl.bind(mainMod .. " SHIFT + 2", hl.dsp.window.move_to_workspace({ workspace = "r~2" }))
hl.bind(mainMod .. " SHIFT + 3", hl.dsp.window.move_to_workspace({ workspace = "r~3" }))
hl.bind(mainMod .. " SHIFT + 4", hl.dsp.window.move_to_workspace({ workspace = "r~4" }))
hl.bind(mainMod .. " SHIFT + 5", hl.dsp.window.move_to_workspace({ workspace = "r~5" }))
hl.bind(mainMod .. " SHIFT + 6", hl.dsp.window.move_to_workspace({ workspace = "r~6" }))
hl.bind(mainMod .. " SHIFT + 7", hl.dsp.window.move_to_workspace({ workspace = "r~7" }))
hl.bind(mainMod .. " SHIFT + 8", hl.dsp.window.move_to_workspace({ workspace = "r~8" }))
hl.bind(mainMod .. " SHIFT + 9", hl.dsp.window.move_to_workspace({ workspace = "r~9" }))

-- Smart per-monitor cycling
hl.bind(mainMod .. " CTRL + left",  hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " CTRL + right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " CTRL + H",     hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " CTRL + L",     hl.dsp.focus({ workspace = "m+1" }))

-- ========================
-- MONITORS
-- ========================
hl.bind(mainMod .. " + comma",  hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ monitor = "r" }))

-- ========================
-- BAR & NOTIFICATIONS
-- ========================
hl.bind(mainMod .. " + SPACE",       hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(mainMod .. " + T",           hl.dsp.exec_cmd(apps.bar_toggle))
hl.bind(mainMod .. " CTRL + R",      hl.dsp.exec_cmd(apps.bar_reload))
hl.bind(mainMod .. " + N",           hl.dsp.exec_cmd(apps.notifications_menu_toggle))
hl.bind(mainMod .. " SHIFT + N",     hl.dsp.exec_cmd(apps.notifications_menu_read))
hl.bind(mainMod .. " CTRL + N",      hl.dsp.exec_cmd(apps.notifications_menu_disturb))

-- ========================
-- MEDIA CONTROLS
-- ========================
hl.bind(",XF86AudioPlay",            hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(",XF86AudioNext",            hl.dsp.exec_cmd("playerctl next"))
hl.bind(",XF86AudioPrev",            hl.dsp.exec_cmd("playerctl previous"))
hl.bind(",XF86AudioMute",            hl.dsp.exec_cmd("pamixer -t"))
hl.bind(",XF86AudioRaiseVolume",     hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind(",XF86AudioLowerVolume",     hl.dsp.exec_cmd("pamixer -d 5"))

hl.bind(mainMod .. " CTRL + RETURN",     hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(mainMod .. " CTRL + KPADD",      hl.dsp.exec_cmd("playerctl next"))
hl.bind(mainMod .. " CTRL + KPSUBTRACT", hl.dsp.exec_cmd("playerctl previous"))
hl.bind(mainMod .. " + KPADD",           hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind(mainMod .. " + KPSUBTRACT",      hl.dsp.exec_cmd("pamixer -d 5"))
hl.bind(mainMod .. " SHIFT + KPADD",     hl.dsp.exec_cmd("pamixer --default-source -i 5"))
hl.bind(mainMod .. " SHIFT + KPSUBTRACT",hl.dsp.exec_cmd("pamixer --default-source -d 5"))

-- ========================
-- BRIGHTNESS
-- ========================
hl.bind(",XF86MonBrightnessUp",      hl.dsp.exec_cmd("brightnessctl -d amdgpu_bl1 set +5%"))
hl.bind(",XF86MonBrightnessDown",    hl.dsp.exec_cmd("brightnessctl -d amdgpu_bl1 set 5%-"))

-- ========================
-- SCRATCHPADS (Pyprland)
-- ========================
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pypr toggle volume"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pypr toggle bluetooth"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("pypr toggle zoom"))

-- ========================
-- GROUPS
-- ========================
hl.bind(mainMod .. " + G",           hl.dsp.group.toggle())
hl.bind(mainMod .. " CTRL + G",      hl.dsp.exec_cmd("hyprctl dispatch lockgroups toggle"))
hl.bind("CTRL ALT + TAB",            hl.dsp.exec_cmd("hyprctl dispatch changegroupactive"))

-- ========================
-- SCREENSHOTS
-- ========================
hl.bind(mainMod .. " + X",           hl.dsp.exec_cmd("hyprshot -m output -o ~/Pictures/Screenshots"))
hl.bind(mainMod .. " SHIFT + X",     hl.dsp.exec_cmd("grim -g \"$(slurp -d)\" - | tee ~/Pictures/Screenshots/$(date +'%F_%T').png | wl-copy"))
hl.bind(mainMod .. " CTRL + X",      hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/Screenshots"))

-- ========================
-- EXTRA
-- ========================
hl.bind(mainMod .. " + INSERT",      hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + F10",         hl.dsp.exec_cmd(apps.bar_toggle))
hl.bind(mainMod .. " + F11",         hl.dsp.exec_cmd(apps.launcher_windows))
hl.bind(mainMod .. " + F12",         hl.dsp.exec_cmd(apps.launcher))
hl.bind(mainMod .. " SHIFT + ESCAPE",hl.dsp.exec_cmd("hyprctl dispatch freezeactive"))

-- ========================
-- MONITOR SAFETY & MANUAL CONTROL
-- ========================
hl.bind(mainMod .. " + F1",          hl.dsp.focus({ monitor = "eDP-1" }))
hl.bind(mainMod .. " + M",           hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/wayscripts/enable-hdmi.sh"))
hl.bind(mainMod .. " SHIFT + M",     hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/wayscripts/disable-hdmi.sh"))
