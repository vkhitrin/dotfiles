require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	dim = { enabled = false },
	explorer = { enabled = true },
	indent = { enabled = true, animate = { enabled = false } },
	input = { enabled = true },
	lazygit = { enabled = true },
	notifier = { enabled = false },
	picker = {
		enabled = true,
		styles = {
			backdrop = false,
		},
		sources = {
			files = { hidden = true, ignored = true },
			explorer = { hidden = true, ignored = true },
		},
	},
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = false },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	win = {
		backdrop = false,
	},
})
