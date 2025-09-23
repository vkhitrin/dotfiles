local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		require("none-ls.formatting.mbake"),
	},
})
require("mason-null-ls").setup({
	handlers = {
		yamllint = function(source_name, methods)
			null_ls.builtins.diagnostics.yamllint.with({
				extra_args = { "-d", "{extends: default, rules: {empty-lines: disable, line-length: disable}}" },
			})
		end,
		function(source_name, methods)
			require("mason-null-ls").default_setup(source_name, methods)
		end,
	},
})
