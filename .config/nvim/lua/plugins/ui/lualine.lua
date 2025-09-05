require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_x = {
			{
				function()
					return require("vectorcode.integrations").lualine(opts)[1]()
				end,
				cond = function()
					if package.loaded["vectorcode"] == nil then
						return false
					else
						return require("vectorcode.integrations").lualine(opts).cond()
					end
				end,
			},
			"encoding",
			"fileformat",
			"filetype",
			{
				function()
					return ("%s %s")
						:format(nvim.ui.icons.ui.Table, require("schema-companion").get_current_schemas() or "none")
						:sub(0, 128)
				end,
				cond = function()
					return package.loaded["schema-companion"]
				end,
			},
		},
		-- lualine_y = {
		-- 	{
		-- 		"lsp_status",
		-- 		icon = "",
		-- 		symbols = {
		-- 			spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
		-- 			done = "✓",
		-- 			separator = " ",
		-- 		},
		-- 		ignore_lsp = {},
		-- 	},
		-- },
	},
})
