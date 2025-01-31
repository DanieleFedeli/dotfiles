local wezterm = require 'wezterm';
local act = wezterm.action

local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end

config.set_environment_variables = {
  PATH = '/opt/homebrew/bin:' .. os.getenv 'PATH',
}
-- Appearance
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font "MesloLGS NF"
config.font_size = 18.0
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true
config.window_padding = {
  top = 0,
  bottom = 0,
  left = 0,
  right = 0
}
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'
config.underline_thickness = '1.5pt'
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.6,
}

-- Behavior
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "~/Work/"
config.adjust_window_size_when_changing_font_size = false

-- Keys
config.keys = {
  -- Close current pane, if something is running ask confirmation
  {
    key = 'd',
    mods = 'CMD',
    action = act.CloseCurrentPane { confirm = true },
  },
  -- Close current tab, if something is running ask confirmation
  {
    key = 'w',
    mods = 'CMD',
    action = act.CloseCurrentTab { confirm = true }
  },
  -- Open config in a new tab
  {
    key = ',',
    mods = 'CMD',
    action = act.SpawnCommandInNewTab {
      cwd = os.getenv 'WEZTERM_CONFIG_DIR',
      args = {
        'nvim',
        '~/.config',
      }
    }
  },
  -- Create panes
  {
    key = '/',
    mods = 'CMD',
    action = act.SplitHorizontal
  },
  {
    key = '-',
    mods = 'CMD',
    action = act.SplitVertical
  },
  -- Pane motion
  { key = '[', mods = 'CMD',       action = act.ActivatePaneRelative(1) },
  { key = ']', mods = 'CMD',       action = act.ActivateTabRelative(-1) },
  -- Tab motion
  { key = '[', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1) },
  { key = ']', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(-1) }
}

return config
