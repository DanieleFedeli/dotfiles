local wezterm = require("wezterm") -- [[@as Wezterm]]
local act = wezterm.action

local Keybindings = {}

local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

function Keybindings.setup(config)
	config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

	config.keys = {
		-- Move between panes
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),
		-- Resize panes
		split_nav("resize", "h"),
		split_nav("resize", "j"),
		split_nav("resize", "k"),
		split_nav("resize", "l"),
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
		{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
		{ key = "k", mods = "LEADER", action = act.ClearScrollback("ScrollbackAndViewport") },
		{
			key = ",",
			mods = "CMD",
			action = act.SpawnCommandInNewTab({
				args = { "nvim", os.getenv("HOME") .. "/.config/" },
			}),
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
end


return Keybindings
