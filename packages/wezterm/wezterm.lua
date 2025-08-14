-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
  config.font = wezterm.font_with_fallback { 'JetBrainsMono NF', 'Noto Color Emoji' }

local user = os.getenv("USER")
config.window_padding = {
    left = "0cell",
    right = "0cell",
    top = "0cell",
    bottom = "0cell"
}
-- BG
-- The art is a bit too bright and colorful to be useful as a backdrop
-- for text, so we're going to dim it down to 10% of its normal brightness
local dimmer = {brightness = 0.1}
config.enable_scroll_bar = false
config.background = {
    -- This is the deepest/back-most layer. It will be rendered first
    {
        source = {
            File = "/home/" .. user .. "/.config/wezterm/bg.png"
        },
        -- The texture tiles vertically but not horizontally.
        -- When we repeat it, mirror it so that it appears "more seamless".
        -- An alternative to this is to set `width = "100%"` and have
        -- it stretch across the display
        repeat_x = "Mirror",
        hsb = dimmer,
        -- When the viewport scrolls, move this layer 10% of the number of
        -- pixels moved by the main viewport. This makes it appear to be
        -- further behind the text.
        attachment = {Parallax = 0.1}
    }
}

-- or, changing the font size and color scheme.
config.font_size = 18.5
config.color_scheme = "AdventureTime"
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = {key = "`", timeout_milliseconds = 1000}
config.keys = {
    {
        key = "|",
        mods = "LEADER|SHIFT",
        action = wezterm.action.SplitHorizontal({domain = "CurrentPaneDomain"})
    },
    {
        key = "-",
        mods = "LEADER",
        action = wezterm.action.SplitVertical({domain = "CurrentPaneDomain"})
    },
    {
        key = "t",
        mods = "LEADER",
        action = wezterm.action.SpawnTab("CurrentPaneDomain")
    },
    {key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left")},
    {key = "h", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Left")},
    {key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down")},
    {key = "j", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Down")},
    {key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up")},
    {key = "k", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Up")},
    {key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right")},
    {key = "l", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Right")},
    {
        key = "n",
        mods = "LEADER",
        action = wezterm.action.ToggleFullScreen
    },
    {
        key = "c",
        mods = "LEADER",
        action = wezterm.action.ActivateCopyMode
    },
    {
        key = "`",
        mods = "LEADER",
        action = wezterm.action.SendKey({key = "`"})
    },
    {
        key = "1",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(0),
    },
    {
        key = "2",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(1),
    },
    {
        key = "3",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(2),
    },
    {
        key = "4",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(3),
    },
    {
        key = "5",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(4),
    },
    {
        key = "6",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(5),
    },
    {
        key = "7",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(6),
    },
    {
        key = "8",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(7),
    },

    {
        key = "9",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(8),
    },
    {
        key = "0",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(9),
    },
    {
        key = "Tab",
        mods = "LEADER",
        action = wezterm.action.ActivateLastTab,
    },
{
	key = "LeftArrow",
	mods = "LEADER",
	action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
},
{
	key = "RightArrow",
	mods = "LEADER",
	action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
},
{
	key = "UpArrow",
	mods = "LEADER",
	action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
},
{
	key = "DownArrow",
	mods = "LEADER",
	action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
},
}
local mux = wezterm.mux
-- Fullscreen
wezterm.on(
    "gui-startup",
    function(cmd)
        local tab, pane, window = mux.spawn_window(cmd or {})
        local gui_window = window:gui_window()
        gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
    end
)
return config
