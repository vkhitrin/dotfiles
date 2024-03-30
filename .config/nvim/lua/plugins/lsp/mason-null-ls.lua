vim.api.nvim_set_hl(0, "NullLsInfoBorder", { link = "FloatBorder" })
local null_ls = require("null-ls")
null_ls.setup({
    border = "rounded",
})
require("mason-null-ls").setup({
	handlers = {
		function(source_name, methods)
			require("mason-null-ls").default_setup(source_name, methods)
		end,
		yamllint = function()
			local yamllint_config_path = vim.fn.expand("~/.config/nvim/linters_config/.yamllint.yaml")
			null_ls.register(null_ls.builtins.diagnostics.yamllint.with({
				args = { "-c", yamllint_config_path, "--format", "parsable", "-" },
			}))
		end,
	},
})
