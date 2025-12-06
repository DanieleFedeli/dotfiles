local wezterm = require("wezterm") --[[@as Wezterm]]

local Appearance = {}

function Appearance.setup(config)
	config.colors = require("cyberdream")
	config.font = wezterm.font("MesloLGS NF")
	config.font_size = 18.0
	config.window_background_opacity = 1
	config.macos_window_background_blur = 40
	config.switch_to_last_active_tab_when_closing_tab = true
	config.window_padding = { top = 0, bottom = 0, left = 0, right = 0 }
	config.front_end = "WebGpu"
	-- config.webgpu_power_preference = "HighPerformance"
	config.underline_thickness = "1.5pt"
	config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.6 }
	config.tab_max_width = 40
	config.show_tab_index_in_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = false
end

-- Simple status bar
wezterm.on("update-status", function(window, pane)
	local stat = window:active_workspace()
	local stat_color = "#f7768e"

	-- Show active key table if any
	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = "#7dcfff"
	end
	if window:leader_is_active() then
		stat = "LDR"
		stat_color = "#bb9af7"
	end

	-- Get current directory
	local function basename(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	local cwd = pane:get_current_working_dir()
	if cwd then
		if type(cwd) == "userdata" then
			cwd = basename(cwd.file_path)
		else
			cwd = basename(cwd)
		end
	else
		cwd = ""
	end

	local time = wezterm.strftime("%H:%M")

	-- Left status
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = "  " },
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		{ Text = " |" },
	}))

	-- Right status
	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
	}))
end)

return Appearance
