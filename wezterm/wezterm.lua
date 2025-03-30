local wezterm = require("wezterm") -- [[ @as Wezterm ]]
local Appearance = require("appearance")
local Keybindings = require("keybindings")

local zsh_path = "/bin/zsh"
local config = {}
local home = os.getenv("HOME")

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_prog = { zsh_path, "-l" }
config.default_cwd = home .. "/Work"
config.scrollback_lines = 3000
config.default_workspace = "default"
config.adjust_window_size_when_changing_font_size = false
config.max_fps = 120

Appearance.setup(config)
Keybindings.setup(config)

return config
