local wezterm = require("wezterm") -- [[ @as Wezterm ]]
local Appearance = require("appearance")
local Keybindings = require("keybindings")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.scrollback_lines = 3000
config.default_workspace = "default"
config.adjust_window_size_when_changing_font_size = false
config.max_fps = 240
config.animation_fps = 120

Appearance.setup(config)
Keybindings.setup(config)

return config
