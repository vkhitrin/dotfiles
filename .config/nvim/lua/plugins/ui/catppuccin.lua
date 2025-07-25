require("catppuccin").setup({
	flavour = "mocha",
	background = {
		light = "latte",
		dark = "mocha",
	},
	custom_highlights = function(colors)
		return {
			SnacksPickerMatch = { fg = colors.red },
			BufferLineFill = { bg = colors.mantle, fg = colors.text },
			BufferLineTabSeparator = { bg = colors.mantle, fg = colors.text },
			BufferLineSeparatorVisible = { bg = colors.mantle, fg = colors.text },
			BufferLineSeparatorSelected = { bg = colors.mantle, fg = colors.text },
			Pmenu = {
				bg = colors.mantle,
				fg = colors.overlay2,
			},
			BlinkCmpMenuSelection = { bg = colors.surface0, bold = true },
			BlinkCmpScrollBarGutter = { bg = colors.crust },
			BlinkCmpScrollBarThumb = { bg = colors.surface0 },
		}
	end,
	integrations = {
		blink_cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = false,
		grug_far = true,
		mason = true,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		snacks = { enabled = true, indentscope_color = "" },
		illuminate = {
			enabled = true,
			lsp = false,
		},
		which_key = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			-- underlines = {
			--     errors = {},
			--     hints = {},
			--     warnings = {},
			--     information = {},
			-- },
			inlay_hints = {
				background = true,
			},
		},
	},
})

vim.cmd.colorscheme("catppuccin")
