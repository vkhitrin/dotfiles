local schemastore = require("schemastore")
return require("schema-companion").setup_client(
	require("schema-companion").adapters.jsonls.setup({
		sources = {
			require("schema-companion").sources.lsp.setup(),
			require("schema-companion").sources.none.setup(),
		},
	}),
	{
		settings = {
			json = {
				schemas = schemastore.json.schemas(),
				validate = { enable = true },
			},
		},
	}
)
