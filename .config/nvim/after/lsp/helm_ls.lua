return require("schema-companion").setup_client(
	require("schema-companion").adapters.helmls.setup({
		sources = {
			require("schema-companion").sources.matchers.kubernetes.setup({ version = "master" }),
		},
	}),
	{}
)
