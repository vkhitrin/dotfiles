vim.filetype.add({
	extension = {
		gotmpl = "gotmpl",
	},
	pattern = {
		[vim.fn.expand("~") .. "/.kube/.*config"] = "yaml",
		[".*%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
		[".*/.zshrc.d/xx_functions/.*"] = "zsh",
		[".*/templates/.*%.tpl"] = "helm",
		[".*%.gotmpl"] = "helm", -- custom syntax
		[".*/templates/.*%.ya?ml"] = "helm",
		["helmfile.*%.ya?ml"] = "helm",
		["Brewfile"] = "ruby",
	},
})
