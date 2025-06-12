local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Paleta CoolNight estilo del video
-- config.colors = {
-- foreground = "#CBE0F0",
-- background = "#011423",
-- cursor_bg = "#47FF9C",
-- cursor_border = "#47FF9C",
-- cursor_fg = "#011423",
-- selection_bg = "#033259",
-- selection_fg = "#CBE0F0",
-- ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }
config.color_scheme = "GruvboxDarkHard"
config.default_prog = { "wsl.exe", "~" }
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 14
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.90
-- macos_window_background_blur eliminado porque estás en Windows
config.window_padding = {
	left = 10,
	right = 5,
	top = 5,
	bottom = 5,
}
return config
