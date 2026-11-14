-- Host-specific Hyprland config for mia, deployed as ~/.config/hypr/host.lua
-- Loaded by hyprland.lua before the shared config. Anything host-only can call
-- hl.* directly here; the returned table is read by hyprland.lua and every
-- field in it is optional.

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "", disabled = true })
-- hl.monitor({ output = "DP-1", mode = "1920x1080@165", position = "0x0", scale = 1, vrr = 0, transform = 0 })
hl.monitor({ output = "DP-1", mode = "2560x1440@165", position = "1920x540", scale = 1, vrr = 0, bitdepth = 10 })
hl.monitor({ output = "DP-2", mode = "1920x1080@60",  position = "4480x670", scale = 1 })
hl.monitor({ output = "DP-3", mode = "1920x1080@60",  position = "0x670",    scale = 1 })


----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({ match = { title = "^flameshot$" }, monitor = "DP-3" })


return {
    -- Order in which split-monitor-workspaces hands out workspace ranges
    monitor_priority = { "DP-1", "DP-2", "DP-3", "HDMI-A-1" },

    -- TV that scripts/tv_mode.sh switches to, disabled until then
    tv = { output = "HDMI-A-1", mode = "3840x2160@120", scale = 2, bitdepth = 10 },

    -- Run once on startup
    autostart = {
        "wayvnc --output DP-1",
        "corectrl --minimize-systray",
    },
}
