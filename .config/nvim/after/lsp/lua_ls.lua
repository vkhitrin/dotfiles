return {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim", "Snacks" },
			},
			telmetry = {
				enable = false,
			},
			workspace = {
				checkThrdParty = true,
			},
		},
	},
}
