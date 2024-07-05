local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("SFMono Nerd Font Mono")
config.font_size = 15.0
config.color_scheme = "catppuccin-mocha"
config.window_decorations = "NONE|RESIZE|MACOS_FORCE_DISABLE_SHADOW"
config.enable_tab_bar = false

return config
