require("render-markdown").setup({
	anti_conceal = {
		enabled = false,
	},
	file_types = { "markdown", "opencode_output" },
	completions = {
		blink = {
			enabled = true,
		},
	},
	sign = { enabled = false },
	heading = {
		icons = { " ", " ", " ", " ", " ", " " },
	},
})
