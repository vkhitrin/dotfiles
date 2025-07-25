local schemastore = require("schemastore")

-- NOTE: Do not enable schema-companion integration on GitLab files, it slows initial open
if vim.bo.filetype == "yaml.gitlab" then
	return {
		settings = {
			redhat = { telmetry = { enabled = false } },
			yaml = {
				validate = true,
				hover = true,
				schemaStore = {
					enable = false,
					url = "",
				},
				single_file_support = true,
				schemas = schemastore.yaml.schemas({}),
				customTags = { "!reference sequence" },
			},
		},
	}
else
	return {
		require("lspconfig").yamlls.setup(require("schema-companion").setup_client({
			settings = {
				redhat = { telmetry = { enabled = false } },
				yaml = {
					validate = true,
					hover = true,
					schemaStore = {
						enable = false,
						url = "",
					},
					single_file_support = true,
					schemas = schemastore.yaml.schemas({}),
				},
			},
		})),
	}
end
