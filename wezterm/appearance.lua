local wezterm = require("wezterm") --[[@as Wezterm]]

local Appearance = {}

function Appearance.setup(config)
	config.color_scheme = "Catppuccin Macchiato"
	config.font = wezterm.font("MesloLGS NF")
	config.font_size = 18.0
	config.window_background_opacity = 1
	config.macos_window_background_blur = 40
	config.window_decorations = "RESIZE"
	config.use_fancy_tab_bar = false
	config.switch_to_last_active_tab_when_closing_tab = true
	config.window_padding = { top = 0, bottom = 0, left = 0, right = 0 }
	config.front_end = "WebGpu"
	config.webgpu_power_preference = "HighPerformance"
	config.underline_thickness = "1.5pt"
	config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.6 }
	config.tab_max_width = 40
	config.show_tab_index_in_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = false
end

local cached_cpu = "N/A"
local last_cpu_update = 0

wezterm.on("update-status", function(window, pane)
	local stat = window:active_workspace()
	local stat_color = "#f7768e"
	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = "#7dcfff"
	end
	if window:leader_is_active() then
		stat = "LDR"
		stat_color = "#bb9af7"
	end

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

	local cmd = pane:get_foreground_process_name()
	cmd = cmd and basename(cmd) or ""

	local time = wezterm.strftime("%H:%M")
	local os_name = wezterm.target_triple

	local function run(cmd)
		local ok, result = pcall(function()
			local pipe = io.popen(cmd)
			if not pipe then
				return nil
			end
			local output = pipe:read("*a")
			pipe:close()
			return output and output:gsub("\n", ""):gsub("^%s+", "") or nil
		end)
		return ok and result or nil
	end

	-- ⚙️ CPU (macOS only, refresh every 30 sec)
	local cpu = "N/A"
	local now = os.clock()
	if now - last_cpu_update > 30 then
		local raw = run("ps -A -o %cpu | awk '{s+=$1} END {print s}'")
		local usage = tonumber(raw)
		if usage then
			local core_raw = run("sysctl -n hw.ncpu")
			local cores = tonumber(core_raw) or 1
			cached_cpu = string.format("%.1f%%", usage / cores)
			last_cpu_update = now
		end
	end
	cpu = cached_cpu

	-- Set status bars
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = "  " },
		{ Text = wezterm.nerdfonts.fa_table .. "  " .. stat },
		{ Text = " |" },
	}))

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_speedometer .. " " .. cpu },
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
	}))
end)

return Appearance
