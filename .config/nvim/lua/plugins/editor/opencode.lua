require("opencode").setup({
	prefered_picker = "snacks",
	ui = {
		layout = "left",
		icons = {
			preset = "text",
			overrides = {
				header_user = "",
				header_assistant = "",
			},
		},
		input = {
			text = {
				wrap = true,
			},
		},
	},
})
