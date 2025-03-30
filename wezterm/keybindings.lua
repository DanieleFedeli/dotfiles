local wezterm = require("wezterm") -- [[@as Wezterm]]
local Workspaces = require("workspaces")
local act = wezterm.action

local Keybindings = {}

function Keybindings.setup(config)
	config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

	config.keys = {
		{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
		{ key = "Z", mods = "LEADER", action = act.TogglePaneZoomState },
		{ key = "K", mods = "LEADER", action = act.ClearScrollback("ScrollbackAndViewport") },
		{
			key = ",",
			mods = "LEADER",
			action = act.SpawnCommandInNewTab({ args = { "/bin/zsh", "-c", "nvim ~/.config" } }),
		},
	}

	-- Leader + Number to Activate Tab
	for i = 0, 8 do
		table.insert(config.keys, {
			key = tostring(i + 1),
			mods = "LEADER",
			action = act.ActivateTab(i),
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
