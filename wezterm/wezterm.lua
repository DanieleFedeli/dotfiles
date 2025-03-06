local wezterm = require 'wezterm'
local Appearance = require 'appearance'
local Keybindings = require 'keybindings'

local zsh_path = '/bin/zsh'
local config = {}
local home = os.getenv('HOME')

if wezterm.config_builder then config = wezterm.config_builder() end

Appearance.setup(config)

config.default_prog = { zsh_path, '-l' }
config.default_cwd = home .. '/Work'
config.scrollback_lines = 3000
config.default_workspace = "default"
config.adjust_window_size_when_changing_font_size = false
config.max_fps = 120

Keybindings.setup(config)

return config
