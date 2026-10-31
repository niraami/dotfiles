-- Hyprland Lua config
-- Ported from hyprland.conf (hyprlang) -- the original hyprland.conf is left untouched
-- alongside this file for reference/diffing.
-- Refer to the wiki for more information: https://wiki.hypr.land/Configuring/Start/

-- A few notes on things that could not be ported 1:1, flagged inline with "PORTING NOTE":
--  - `split-monitor-workspaces` is no longer a compiled hyprpm plugin -- as of its Lua
--    rewrite (https://github.com/zjeffer/split-monitor-workspaces) it's a plain Lua
--    package you `require()` and configure with `smw.setup({...})`. It needs to be
--    cloned to ~/.config/hypr/plugins/split-monitor-workspaces (see the note near the
--    `require` call below for how this repo does that).
--  - `fullscreenstate, 3` (single legacy arg) has been translated to
--    `hl.dsp.window.fullscreen_state({ internal = 3, client = 3 })`; please double check
--    this is the behavior you want.
--  - The qBittorrent title-negation rule used a non-RE2 lookahead
--    (`^(?!qBittorrent).*$`), which RE2 cannot evaluate. It's been rewritten using the
--    documented `negative:` prefix instead.


------------------------
---- ENV VARIABLES ----
------------------------

hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")


------------------
---- MONITORS ----
------------------

-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "", disabled = true })
-- hl.monitor({ output = "DP-1", mode = "1920x1080@165", position = "0x0", scale = 1, vrr = 0, transform = 0 })
hl.monitor({ output = "DP-1", mode = "2560x1440@165", position = "1920x540", scale = 1, vrr = 0, bitdepth = 10 })
hl.monitor({ output = "DP-2", mode = "1920x1080@60",  position = "4480x670", scale = 1 })
hl.monitor({ output = "DP-3", mode = "1920x1080@60",  position = "0x670",    scale = 1 })

-- TV (disabled by default, scripts/tv_mode.sh switches to it at runtime -- keep in sync)
-- hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@120", position = "0x0", scale = 2, vrr = 0, bitdepth = 10 })
hl.monitor({ output = "HDMI-A-1", disabled = true })


-------------------
---- VARIABLES ----
-------------------

local mainMod   = "SUPER"
local scriptDir = os.getenv("HOME") .. "/.config/hypr/scripts"

local term        = "kitty"
local menu        = "ulauncher-toggle"
local files       = "thunar"
local browser     = "brave"
local browser2    = "firefox"
local music       = "tidal-hifi"
local colorpicker = scriptDir .. "/colorpicker.sh"

local lock   = "hyprlock"
local logout = "true" -- archlinux-logout


---------------
---- DEBUG ----
---------------

hl.config({
    debug = {
        enable_stdout_logs = true,
        disable_logs       = false,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us,sk",
        kb_variant = ",qwerty",
        kb_model   = "pc104",
        kb_options = "grp:alt_shift_toggle",
        kb_rules   = "",

        follow_mouse = 1,

        touchpad = {
            natural_scroll = false,
        },

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    },
})


--------------
---- MISC ----
--------------

hl.config({
    misc = {
        -- Runtime monitor changes (scripts/tv_mode.sh) are reverted by a reload, so
        -- never reload on save; use SUPER + SHIFT + R instead.
        disable_autoreload = true,

        allow_session_lock_restore = true,

        disable_hyprland_logo   = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms  = true,
        key_press_enables_dpms   = true,

        enable_swallow = false,
        swallow_regex  = "^(kitty)$",

        focus_on_activate = false,

        -- vfr = true,
        vrr = 1,
    },
})


----------------
---- CURSOR ----
----------------

hl.config({
    cursor = {
        inactive_timeout = 8,
    },
})


----------------
---- BINDS -----
----------------

hl.config({
    binds = {
        workspace_back_and_forth = true,
    },
})


-----------------
---- GENERAL ----
-----------------

hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 5,
        border_size = 1,

        col = {
            active_border   = { colors = { "rgba(7e57c2ff)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(3a3a3aff)",
        },

        layout = "dwindle",
    },
})


--------------------
---- DECORATION ----
--------------------

hl.config({
    decoration = {
        rounding = 4,

        blur = {
            enabled            = true,
            size               = 5,
            passes             = 1,
            new_optimizations  = true,
        },

        active_opacity     = 1.0,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
    },

    animations = {
        enabled = true,
    },
})


--------------------
---- ANIMATIONS ----
--------------------

-- Beziers
hl.curve("simple",    { type = "bezier", points = { {0.16, 1},    {0.3, 1}     } })
hl.curve("tehtarik",  { type = "bezier", points = { {0.68, -0.55}, {0.265, 1.55} } })
hl.curve("overshot",  { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05}  } })
hl.curve("smoothOut", { type = "bezier", points = { {0.36, 0},    {0.66, -0.56} } })
hl.curve("smoothIn",  { type = "bezier", points = { {0.25, 1},    {0.5, 1}     } })

hl.animation({ leaf = "windows",          enabled = true, speed = 5,  bezier = "simple", style = "slide" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 4,  bezier = "simple", style = "slide" })
hl.animation({ leaf = "fade",             enabled = true, speed = 10, bezier = "simple" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 6,  bezier = "simple", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 6,  bezier = "simple", style = "slidevert" })


----------------
---- LAYOUT ----
----------------

hl.config({
    dwindle = {
        preserve_split       = true,
        special_scale_factor = 0.8,
    },

    master = {
        new_status           = "master",
        mfact                = 0.6,
        special_scale_factor = 0.8,
    },
})


-----------------
---- PLUGINS ----
-----------------

-- split-monitor-workspaces (https://github.com/zjeffer/split-monitor-workspaces) is a
-- plain Lua package now, not a compiled hyprpm plugin. It's tracked as a git submodule
-- at user/config/hypr/plugins/split-monitor-workspaces (dotdrop-deployed via the
-- existing whole-directory `d_hypr` entry), and require()'d here.
package.path = package.path .. ";" .. scriptDir .. "/../plugins/split-monitor-workspaces/lua/?.lua"
local smw = require("split-monitor-workspaces")

smw.setup({
    workspace_count = 10,

    monitor_priority = { "DP-1", "DP-2", "DP-3", "HDMI-A-1" },

    keep_focused                 = true,
    enable_notifications         = false,
    enable_persistent_workspaces = false,
    enable_wrapping              = false,
})


----------------------
---- WINDOW RULES ----
----------------------

-- Floating windows
hl.window_rule({ match = { class = "^([yY]ad)$" },                float = true })
hl.window_rule({ match = { class = "^(nm-connection-editor)$" },  float = true })
hl.window_rule({ match = { class = "^(pavucontrol)$" },           float = true })
hl.window_rule({ match = { class = "^(Rofi)$" },                  float = true })
hl.window_rule({ match = { class = "^(file-roller)$" },           float = true })
hl.window_rule({ match = { class = "^(thunar)$", title = "^(.*Progress.*)$" }, float = true })
-- PORTING NOTE: original used a non-RE2 negative lookahead (`^(?!qBittorrent).*$`);
-- rewritten with the documented `negative:` prefix. NOTE: rule props are
-- full-matched (RE2 FullMatch), so the pattern must consume the whole title --
-- `negative:^qBittorrent` alone would negate "exactly qBittorrent" and float the
-- main window ("qBittorrent vX.Y.Z") too.
hl.window_rule({ match = { class = "^(.*qBittorrent.*)$", title = "negative:^qBittorrent.*" }, float = true })

-- Force thunderbird to tile (systray fix)
hl.window_rule({ match = { class = "^(thunderbird)$", title = "^(.*Mozilla Thunderbird)$", float = true }, tile = true })

-- Fix borders around modal windows with blur or shadows
hl.window_rule({ match = { class = "^(ulauncher)$" },               float = true })
hl.window_rule({ match = { class = "^([xX]dg-desktop-portal-.*)$" }, float = true })

hl.window_rule({ match = { class = "^(ulauncher)$" },               no_blur = true })
hl.window_rule({ match = { class = "^([xX]dg-desktop-portal-.*)$" }, no_blur = true })

hl.window_rule({ match = { class = "^(ulauncher)$" },               border_size = 0 })
hl.window_rule({ match = { class = "^([xX]dg-desktop-portal-.*)$" }, border_size = 0 })

hl.window_rule({ match = { class = "^(ulauncher)$" },               no_shadow = true })
hl.window_rule({ match = { class = "^([xX]dg-desktop-portal-.*)$" }, no_shadow = true })

hl.window_rule({ match = { class = "^(ulauncher)$" },               suppress_event = "fullscreen maximize" })
hl.window_rule({ match = { class = "^([xX]dg-desktop-portal-.*)$" }, suppress_event = "fullscreen maximize" })

-- Fix for Ulauncher closing when mouse leaves it
hl.window_rule({ match = { class = "^(ulauncher)$" }, stay_focused = true })

-- Fix MEGASync tray popout window
hl.window_rule({ match = { class = "^(megasync)$" }, float = true })

-- kitty -1 (single-instance): new OS windows inherit the maximized state of an
-- existing window via remember_window_size -- block client maximize requests.
-- SUPER+F still works, as it's a compositor-side dispatcher.
hl.window_rule({ match = { class = "^(kitty|ranger)$" }, suppress_event = "maximize" })

-- Pip rules
hl.window_rule({ match = { title = "^(Picture in picture)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture in picture)$" }, max_size = { 800, 450 } })
hl.window_rule({ match = { title = "^(Picture in picture)$" }, move = { "monitor_w-840", "40" } })

-- Screen sharing fixes (xwayland video bridge)
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, move = { 0, -7680 } })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, pin = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, opacity = "0.0 override 0.0 override" })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_anim = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_focus = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_initial_focus = true })

-- TV mode confirmation dialog (scripts/tv_mode.sh): pinned so it shows on whichever
-- workspace ends up active on the TV after the other monitors are disabled
hl.window_rule({ match = { title = "^(TV mode)$" }, float = true })
hl.window_rule({ match = { title = "^(TV mode)$" }, pin = true })
hl.window_rule({ match = { title = "^(TV mode)$" }, monitor = "HDMI-A-1" })
hl.window_rule({ match = { title = "^(TV mode)$" }, center = true })

-- Flameshot fixes
-- PORTING NOTE: original had "activate_focus" (with an underscore); the documented
-- token is "activatefocus" (no underscore) -- looks like a pre-existing typo, kept
-- as-is below but worth double-checking against your intent.
hl.window_rule({ match = { title = "^flameshot$" }, suppress_event = "fullscreen maximize activate activate_focus" })
hl.window_rule({ match = { title = "^flameshot$" }, float = true })
hl.window_rule({ match = { title = "^flameshot$" }, monitor = "DP-3" })


-------------------
---- KEYBINDS -----
-------------------

-- Main binds
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term .. " -1"))
hl.bind(mainMod .. " + W",         hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(browser2))

hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(scriptDir .. "/exit_dialog.sh"))

hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + CTRL + F",  hl.dsp.window.fullscreen_state({ internal = 3, client = 3 }))

hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(term .. " -1 --class ranger ranger"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(files))

hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())              -- dwindle
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))        -- dwindle

hl.bind(mainMod .. " + R",     hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind("ALT + SPACE",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd(lock))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(logout))

hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(colorpicker))

-- Reload all settings
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(scriptDir .. "/reload.sh"))

-- Toggle TV-only (HDMI) display mode
hl.bind(mainMod .. " + CTRL + ALT + T", hl.dsp.exec_cmd(scriptDir .. "/tv_mode.sh"))

-- Night mode (blue light filter)
-- hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(scriptDir .. "/night_light.sh --action toggle"))

-- Multimedia keys
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl --player playerctld play-pause"))
hl.bind("XF86AudioStop",         hl.dsp.exec_cmd("playerctl --player playerctld stop"))
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl --player playerctld pause"))
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl --player playerctld next"))
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl --player playerctld previous"))
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("xf86-audio-control vol-up"))
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("xf86-audio-control vol-down"))
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("xf86-audio-control mute-toggle"))
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("xf86-audio-control mic-toggle"))

-- Screen capture keys
hl.bind("Print",                hl.dsp.exec_cmd(scriptDir .. "/hypr_capture.py --action image --mode region"))
hl.bind("CTRL + Print",         hl.dsp.exec_cmd(scriptDir .. "/hypr_capture.py --action image --mode output"))
hl.bind("ALT + Print",          hl.dsp.exec_cmd(scriptDir .. "/hypr_capture.py --action image --mode window"))
hl.bind("SHIFT + Print",        hl.dsp.exec_cmd(scriptDir .. "/hypr_capture.py --action video --mode region"))
hl.bind("SHIFT + CTRL + Print", hl.dsp.exec_cmd(scriptDir .. "/hypr_capture.py --action video --mode output"))
hl.bind("SHIFT + ALT + Print",  hl.dsp.exec_cmd(scriptDir .. "/hypr_capture.py --action video --mode window"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
-- Move focus with mainMod + hjkl
-- hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
-- hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
-- hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
-- hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move window with mainMod + Shift + arrow keys
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))
-- Move window with mainMod + Shift + hjkl
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9] (per-monitor, via split-monitor-workspaces)
for i = 1, 10 do
    local n = tostring(i)
    if n == "10" then n = "0" end -- bind workspace 10 to SUPER + 0
    hl.bind(mainMod .. " + " .. n, smw.workspace(tostring(i)))
end

-- PORTING NOTE: the original unnamed/default special workspace (`togglespecialworkspace`
-- with no args) doesn't have a clearly documented Lua equivalent -- `toggle_special()`
-- always takes a name and applies the `special:` prefix itself. Passing "" is a guess;
-- please verify this actually toggles the same "default" special workspace you expect.
hl.bind(mainMod .. " + F1", hl.dsp.workspace.toggle_special(""))
hl.bind(mainMod .. " + F2", hl.dsp.workspace.toggle_special("discord"))
hl.bind(mainMod .. " + F3", hl.dsp.workspace.toggle_special("music"))

-- Move active window to a workspace with mainMod + SHIFT + [0-9] (per-monitor, silent)
for i = 1, 10 do
    local n = tostring(i)
    if n == "10" then n = "0" end
    hl.bind(mainMod .. " + SHIFT + " .. n, smw.move_to_workspace_silent(tostring(i)))
end
hl.bind(mainMod .. " + SHIFT + F1", hl.dsp.window.move({ workspace = "special",         follow = false }))
hl.bind(mainMod .. " + SHIFT + F2", hl.dsp.window.move({ workspace = "special:discord", follow = false }))
hl.bind(mainMod .. " + SHIFT + F3", hl.dsp.window.move({ workspace = "special:music",   follow = false }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


---------------------
---- AUTOSTART -------
---------------------

-- exec = hyprpm reload -- runs on every reload, unlike exec-once
hl.exec_cmd("hyprpm reload")

hl.on("hyprland.start", function()
    -- Screen sharing fixes (xwayland video bridge)
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("xwaylandvideobridge")

    -- Daemons
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("swaync")
    hl.exec_cmd("killall -eqw hypridle; hypridle")
    hl.exec_cmd("playerctld daemon")
    hl.exec_cmd("wayvnc --output DP-1")
    hl.exec_cmd("corectrl --minimize-systray")
    -- hl.exec_cmd("sunsetr")

    -- Set background
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd(scriptDir .. "/auto_bg.py --per-output ~/.wallpapers/Landscape")

    -- Start waybar & applet tools
    hl.exec_cmd("waybar")
    hl.exec_cmd("nm-applet --indicator")

    -- Background thunar instance
    hl.exec_cmd("thunar --daemon")

    -- Background flameshot instance
    -- hl.exec_cmd("flameshot")

    -- Disk automount via udisks2
    hl.exec_cmd("udiskie --automount --notify --smart-tray")

    -- XDG Autostart
    hl.exec_cmd("dex --autostart --environment wayland --term kitty")
end)
