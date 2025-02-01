local wezterm = require 'wezterm';
local act = wezterm.action

local zsh_path = '/bin/zsh'
local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end

config.default_prog = { zsh_path, '-l' }

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
config.default_workspace = "Disco"
config.adjust_window_size_when_changing_font_size = false

-- Keys
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  -- Rename tab
  {
    key = "e",
    mods = "LEADER",
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Renaming Tab Title...:" },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end)
    }
  },
  { key = "-",  mods = "LEADER",     action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "\\", mods = "LEADER",     action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "r",  mods = "LEADER",     action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },
  { key = "[",  mods = "LEADER",     action = act.ActivateCopyMode },
  { key = "K",  mods = "CTRL|SHIFT", action = act.ClearScrollback 'ScrollbackAndViewport' }
}

for i = 0, 8 do
  -- leader + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i + 1),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i),
  })
end

wezterm.on("update-status", function(window, pane)
  -- Workspace name
  local stat = window:active_workspace()
  local stat_color = "#f7768e"
  -- It's a little silly to have workspace name all the time
  -- Utilize this to display LDR or current key table name
  if window:active_key_table() then
    stat = window:active_key_table()
    stat_color = "#7dcfff"
  end
  if window:leader_is_active() then
    stat = "LDR"
    stat_color = "#bb9af7"
  end

  local basename = function(s)
    -- Nothing a little regex can't fix
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  end

  -- Current working directory
  local cwd = pane:get_current_working_dir()
  if cwd then
    if type(cwd) == "userdata" then
      -- Wezterm introduced the URL object in 20240127-113634-bbcac864
      cwd = basename(cwd.file_path)
    else
      -- 20230712-072601-f4abf8fd or earlier version
      cwd = basename(cwd)
    end
  else
    cwd = ""
  end

  -- Current command
  local cmd = pane:get_foreground_process_name()
  -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
  cmd = cmd and basename(cmd) or ""

  -- Time
  local time = wezterm.strftime("%H:%M")

  -- Left status (left of the tab line)
  window:set_left_status(wezterm.format({
    { Foreground = { Color = stat_color } },
    { Text = "  " },
    { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
    { Text = " |" },
  }))

  -- Right status
  window:set_right_status(wezterm.format({
    -- Wezterm has a built-in nerd fonts
    -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
    { Text = " | " },
    { Foreground = { Color = "#e0af68" } },
    { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
    "ResetAttributes",
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
    { Text = "  " },
  }))
end)

return config
