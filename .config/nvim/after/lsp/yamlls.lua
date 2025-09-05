local schemastore = require("schemastore")
return require("schema-companion").setup_client(
	require("schema-companion").adapters.yamlls.setup({
		sources = {
			require("schema-companion").sources.matchers.kubernetes.setup({ version = "master" }),
			require("schema-companion").sources.lsp.setup(),
			require("schema-companion").sources.schemas.setup({
				{
					name = "Kubernetes master",
					uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
				},
			}),
		},
	}),
	{
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
)
