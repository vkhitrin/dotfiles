return {
	{
		"sudo-tee/opencode.nvim",
		opts = {
			server = {
				url = "localhost",
				port = 51515,
				timeout = 5,
			},
			preferred_picker = "snacks",
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
	-- {
	-- 	"BlinkResearchLabs/blink-edit.nvim",
	-- 	opts = {
	-- 		llm = {
	-- 			provider = "sweep",
	-- 			backend = "openai",
	-- 			url = "http://localhost:1234",
	-- 			model = "sweep",
	-- 		},
	-- 	},
	-- },
}
