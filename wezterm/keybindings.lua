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

-- Workspace tabs configuration for Leader + q
-- Each entry can have: title, cwd (working directory), cmd (shell command)
local workspace_tabs = {
	{ title = "Service editor", cwd = "~/Work/service-editor", cmd = "nvim ." },
	{ title = "Disco GQL", cwd = "~/Work/service-disco-graphql-api", cmd = "nvim ." },
	{ title = "Disco Writer", cwd = "~/Work/service-disco-writer", cmd = "nvim ." },
	{ title = "GH notifications", cmd = "GH_TOKEN=$(gh auth token) gh news" },
	{ title = "GH misc", cmd = "gh dash" },
	{ title = "Posting", cmd = "posting" },
}

-- Shell initialization to set up PATH and fnm for node
local shell_init = 'export PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH" && eval "$(fnm env)"'

-- Build shell command with proper environment
local function build_shell_cmd(cwd, cmd)
	local cd_cmd = cwd and ("cd " .. cwd .. " && ") or ""
	return { "/bin/zsh", "-c", shell_init .. " && " .. cd_cmd .. cmd }
end

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

		-- Open workspace tabs in a new window (Leader + q)
		{
			key = "q",
			mods = "LEADER",
			action = wezterm.action_callback(function(win, pane)
				local mux = wezterm.mux
				local first_tab = workspace_tabs[1]
				local first_cwd = first_tab.cwd and first_tab.cwd:gsub("^~", os.getenv("HOME")) or nil

				-- Spawn a new window with the first tab
				local new_tab, new_pane, new_window = mux.spawn_window({
					args = build_shell_cmd(first_cwd, first_tab.cmd),
				})
				if first_tab.title then
					new_tab:set_title(first_tab.title)
				end

				-- Add remaining tabs to the new window
				for i = 2, #workspace_tabs do
					local tab = workspace_tabs[i]
					local cwd = tab.cwd and tab.cwd:gsub("^~", os.getenv("HOME")) or nil
					local new_tab2 = new_window:spawn_tab({
						args = build_shell_cmd(cwd, tab.cmd),
					})
					if tab.title then
						new_tab2:set_title(tab.title)
					end
				end

				-- Focus the first tab and maximize the window
				new_tab:activate()
				new_window:gui_window():maximize()
			end),
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
