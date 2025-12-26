return {
	{
		"sudo-tee/opencode.nvim",
		opts = {
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
				output = {
					always_scroll_to_bottom = true,
				},
			},
		},
	},
}
