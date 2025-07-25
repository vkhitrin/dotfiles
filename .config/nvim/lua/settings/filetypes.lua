vim.filetype.add({
	pattern = {
		[".*%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
		[".*/.zshrc.d/xx_functions/.*"] = "zsh",
	},
})
