local wezterm = require 'wezterm'

local Appearance = {}

function Appearance.setup(config)
  config.color_scheme = "Catppuccin Mocha"
  config.font = wezterm.font "MesloLGS NF"
  config.font_size = 18.0
  config.window_background_opacity = 0.8
  config.macos_window_background_blur = 10
  config.window_decorations = "RESIZE"
  config.use_fancy_tab_bar = false
  config.switch_to_last_active_tab_when_closing_tab = true
  config.window_padding = { top = 0, bottom = 0, left = 0, right = 0 }
  config.front_end = 'WebGpu'
  config.webgpu_power_preference = 'HighPerformance'
  config.underline_thickness = '1.5pt'
  config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.6 }
end

return Appearance
