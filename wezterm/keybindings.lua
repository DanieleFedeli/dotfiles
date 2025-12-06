local wezterm = require("wezterm") -- [[@as Wezterm]]
local act = wezterm.action

local Keybindings = {}

-- Check if the current pane is running Neovim
local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

-- Smart navigation that respects Neovim
-- When in Neovim, pass the keys through to vim for vim-tmux-navigator
-- When not in Neovim, handle navigation/resizing in WezTerm
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
	-- Leader key: Ctrl+b (like tmux)
	config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

	config.keys = {
		-- Vim-aware pane navigation with Ctrl+h/j/k/l
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),
		-- Vim-aware pane resizing with Meta+h/j/k/l
		split_nav("resize", "h"),
		split_nav("resize", "j"),
		split_nav("resize", "k"),
		split_nav("resize", "l"),
		-- Pane management
		{ key = "-",  mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "z",  mods = "LEADER", action = act.TogglePaneZoomState },
		{ key = "x",  mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

		-- Copy mode and utilities
		{ key = "[",  mods = "LEADER", action = act.ActivateCopyMode },
		{ key = "k",  mods = "LEADER", action = act.ClearScrollback("ScrollbackAndViewport") },

		-- Quick access to config
		{
			key = ",",
			mods = "CMD",
			action = act.SpawnCommandInNewTab({
				args = { "nvim", os.getenv("HOME") .. "/.config/" },
			}),
		},
	}

	-- Leader + Number to activate specific tab (1-9)
	for i = 0, 8 do
		table.insert(config.keys, {
			key = tostring(i + 1),
			mods = "LEADER",
			action = act.ActivateTab(i),
		})
	end
end

return Keybindings
