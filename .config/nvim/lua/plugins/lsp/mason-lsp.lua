local lspconfig = require("lspconfig")
local schemastore = require("schemastore")
local schemacompanion = require("schema-companion")
vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})
require("lspconfig.ui.windows").default_options.border = "none"
require("mason-lspconfig").setup({
	automatic_enable = {
		exclude = {
			"rust_analyzer",
		},
	},
	-- require("mason-lspconfig").setup_handlers({
	--     ["yamlls"] = function()
	--         require("lspconfig").yamlls.setup(require("schema-companion").setup_client({
	--             lspconfig = {
	--                 settings = {
	--                     redhat = { telmetry = { enabled = false } },
	--                     yaml = {
	--                         validate = true,
	--                         hover = true,
	--                         schemaStore = {
	--                             enable = false,
	--                             url = "",
	--                         },
	--                         single_file_support = true,
	--                         schemas = schemastore.yaml.schemas({}),
	--                     },
	--                 },
	--             },
	--         }))
	--     end,
	--     ["powershell_es"] = function()
	--         lspconfig.powershell_es.setup({
	--             bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
	--         })
	--     end,
	--     -- ["nginx"] = function()
	--     --     lspconfig.nginx_language_server.setup({
	--     --         cmd = { "${HOME}/.local/share/nvim/mason/packages/nginx-language-server/venv/bin/nginx-language-server" },
	--     --     })
	--     -- end
	-- })
})
