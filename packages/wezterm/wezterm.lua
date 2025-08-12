-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 18
config.color_scheme = "AdventureTime"
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = "`", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "`",
		mods = "LEADER",
		action = wezterm.action.SendKey({ key = "`" }),
	},
}
config.key_tables = {
	copy_mode = {
		-- Fix
		-- { key = "/", mods = "NONE", action = wezterm.action.SearchForward },
		-- { key = "?", mods = "NONE", action = wezterm.action.SearchBackward },
		-- { key = "n", mods = "NONE", action = wezterm.action.NextMatch },
		-- { key = "N", mods = "NONE", action = wezterm.action.PriorMatch },
	},
}

local mux = wezterm.mux
-- Fullscreen
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)
return config
