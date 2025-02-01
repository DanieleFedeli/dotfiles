local wezterm = require "wezterm"
local Workspaces = require "workspaces"
local act = wezterm.action

local Keybindings = {}

function Keybindings.setup(config)
  config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

  config.keys = {
    { key = "h",  mods = "LEADER",     action = act.ActivatePaneDirection("Left") },
    { key = "j",  mods = "LEADER",     action = act.ActivatePaneDirection("Down") },
    { key = "k",  mods = "LEADER",     action = act.ActivatePaneDirection("Up") },
    { key = "l",  mods = "LEADER",     action = act.ActivatePaneDirection("Right") },
    { key = "-",  mods = "LEADER",     action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "\\", mods = "LEADER",     action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "r",  mods = "LEADER",     action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },
    { key = "[",  mods = "LEADER",     action = act.ActivateCopyMode },
    { key = "K",  mods = "CTRL|SHIFT", action = act.ClearScrollback 'ScrollbackAndViewport' },
    {
      key = ",",
      mods = "SUPER",
      action = act.SpawnCommandInNewTab { cwd = "~/.config", args = { "/bin/zsh", "-c", "nvim ~/.config" },
      },
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
      wezterm.log_info("Loading LX workspace")
      Workspaces.load_lx()
    end),
  })
end

return Keybindings
