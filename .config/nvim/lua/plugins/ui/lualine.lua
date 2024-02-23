-- local custom_theme = require'lualine.themes.ayu_dark'
-- -- custom_theme.normal.c.bg =  "#0a0e14"
-- custom_theme.normal.c.bg =  "none"
-- custom_theme.inactive.c.bg =  "none"
-- custom_theme.inactive.c.fg =  "#b3b1ad"
-- custom_theme.normal.c.fg =  "#b3b1ad"
require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "catppuccin-mocha",
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
})
