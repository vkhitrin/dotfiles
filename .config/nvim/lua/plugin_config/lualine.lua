local custom_theme = require'lualine.themes.ayu_dark'
custom_theme.normal.c.bg =  "#0a0e14"
require("lualine").setup {
    options = {
        icons_enabled = false,
        theme = custom_theme
    }
}
