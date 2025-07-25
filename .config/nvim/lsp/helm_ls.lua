local schemastore = require("schemastore")
return {
    settings = {
        yamlls = {
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
        },
    },
}
