local wk = require("which-key")
local opts
opts = {}
local mappings = {}
mappings = {
	["<leader>q"] = { name = "+nvim" },
	["<leader>f"] = { name = "+find" },
	["<leader>l"] = { name = "+lsp/code actions" },
	["<leader>lx"] = { name = "+trouble" },
	["<leader>lg"] = { name = "+git" },
}
wk.register(mappings, opts)
wk.setup({
	window = {
		border = "rounded",
	},
})
