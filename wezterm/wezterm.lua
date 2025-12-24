local wezterm = require("wezterm")
local palette = require 'palette'
local act = wezterm.action

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Settings
config.default_prog = { "pwsh.exe", "-NoProfileLoadTime", "-NoLogo" }

-- UI
config.front_end = "WebGpu"
config.window_decorations = "RESIZE"
config.colors = palette
config.initial_cols = 80
config.initial_rows = 15
config.window_padding = {
  left = 15,
  right = 15,
  top = 15,
  bottom = 15,
}
config.inactive_pane_hsb = { -- Dim inactive panes
	saturation = 0.8,
	brightness = 0.6,
}
-- performance
config.max_fps = 120
config.animation_fps = 60

-- Font
config.font = wezterm.font("IosevkaTermSlab Nerd Font Mono")
config.font_size = 12
config.cell_width = 0.9
config.freetype_load_flags = "NO_HINTING"
config.front_end = "OpenGL"

-- cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 900
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Tab bar
config.integrated_title_buttons = { "Close" }
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_and_split_indices_are_zero_based = false
config.tab_max_width = 40
config.window_frame = {
		inactive_titlebar_bg = "none",
		active_titlebar_bg = "none",
	}

-- tab colors
config.colors.tab_bar = {
  background = "#f2f1ee",

  active_tab = {
    bg_color = "#4f4642",
    fg_color = "#f2f1ee",
    intensity = "Bold",
  },

  inactive_tab = {
    bg_color = "#e4e2dc",
    fg_color = "#4f4642",
  },

  inactive_tab_hover = {
    bg_color = "#dcd9d2",
    fg_color = "#4f4642",
  },

  new_tab = {
    bg_color = "#e4e2dc",
    fg_color = "#6a5f5a",
  },

  new_tab_hover = {
    bg_color = "#dcd9d2",
    fg_color = "#4f4642",
  },
}
	
	-- Retro
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
wezterm.on("update-status", function(window, pane)

	-- Current command
	local cmd = pane:get_foreground_process_name()
	-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
	cmd = cmd and basename(cmd) or ""

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
	}))
end)

return config