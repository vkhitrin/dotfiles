local function get_yaml_schema()
	local schema = require("schema-companion.context").get_buffer_schema()
	if schema.name == "none" then
		return ""
	end
	return schema.name
end

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
			get_yaml_schema,
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
