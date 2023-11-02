-- local custom_theme = require'lualine.themes.ayu_dark'
-- -- custom_theme.normal.c.bg =  "#0a0e14"
-- custom_theme.normal.c.bg =  "none"
-- custom_theme.inactive.c.bg =  "none"
-- custom_theme.inactive.c.fg =  "#b3b1ad"
-- custom_theme.normal.c.fg =  "#b3b1ad"
require("lualine").setup({
	options = {
		icons_enabled = false,
		-- theme = custom_theme
	},
})
vim.cmd([[highlight! lualine_c_normal guibg=trasnparent ctermbg=none]])
