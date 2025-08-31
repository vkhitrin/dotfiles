require("blink.cmp").setup({
	-- keymap = { preset = "super-tab", ["<F11>"] = require("minuet").make_blink_map() },
	keymap = { preset = "super-tab" },
	-- appearance = { nerd_font_variant = "mono" },
	completion = {
		documentation = { auto_show = true },
		trigger = { prefetch_on_insert = false },
	},
	sources = {
		default = { "git", "lsp", "path", "buffer", "snippets" },
		providers = {
			git = {
				module = "blink-cmp-git",
				name = "Git",
				opts = {},
			},
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
})
