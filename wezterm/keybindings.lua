local wezterm = require "wezterm"
local Workspaces = require "workspaces"
local act = wezterm.action

local Keybindings = {}

function Keybindings.setup(config)
  config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

  config.keys = {
    { key = "h",  mods = "CMD",        action = act.ActivatePaneDirection("Left") },
    { key = "j",  mods = "CMD",        action = act.ActivatePaneDirection("Down") },
    { key = "k",  mods = "CMD",        action = act.ActivatePaneDirection("Up") },
    { key = "l",  mods = "CMD",        action = act.ActivatePaneDirection("Right") },
    { key = "-",  mods = "CMD",        action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "\\", mods = "CMD",        action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "[",  mods = "CMD",        action = act.ActivateCopyMode },
    { key = "Z",  mods = "CMD",        action = act.TogglePaneZoomState },
    { key = "K",  mods = "CTRL|SHIFT", action = act.ClearScrollback 'ScrollbackAndViewport' },
    {
      key = ",",
      mods = "CMD",
      action = act.SpawnCommandInNewTab { args = { "/bin/zsh", "-c", "nvim ~/.config" } },
    }
  }

  -- Leader + Number to Activate Tab
  for i = 0, 8 do
    table.insert(config.keys, {
      key = tostring(i + 1),
      mods = "LEADER",
      action = wezterm.action.ActivateTab(i),
    })
  end

  -- Keybinding to Load "LX" Workspace
  table.insert(config.keys, {
    key = "q",
    mods = "LEADER",
    action = wezterm.action_callback(function()
      Workspaces.load_lx()
    end),
  })
end

return Keybindings
