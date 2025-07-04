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
	--     function(server_name)
	--         local capabilities = require("blink.cmp").get_lsp_capabilities()
	--         require("lspconfig")[server_name].setup({ capabilities = capabilities })
	--     end,
	--     ["lua_ls"] = function()
	--         lspconfig.lua_ls.setup({
	--             settings = {
	--                 Lua = {
	--                     runtime = {
	--                         version = "LuaJIT",
	--                     },
	--                     diagnostics = {
	--                         globals = { "vim" },
	--                     },
	--                     telmetry = {
	--                         enable = false,
	--                     },
	--                     workspace = {
	--                         checkThirdParty = false,
	--                         library = {
	--                             -- unpack(vim.api.nvim_get_runtime_file("", true)),
	--                             -- vim.api.nvim_get_proc,
	--                         },
	--                     },
	--                 },
	--             },
	--         })
	--     end,
	--     ["jsonls"] = function()
	--         lspconfig.jsonls.setup({
	--             settings = {
	--                 json = {
	--                     schemas = schemastore.json.schemas(),
	--                     validate = { enable = true },
	--                 },
	--             },
	--         })
	--     end,
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
	--     ["helm_ls"] = function()
	--         lspconfig.helm_ls.setup({
	--             settings = {
	--                 ["helm-ls"] = {
	--                     yamlls = {
	--                         path = "yaml-language-server",
	--                     },
	--                 },
	--             },
	--         })
	--     end,
	--     ["powershell_es"] = function()
	--         lspconfig.powershell_es.setup({
	--             bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
	--         })
	--     end,
	--     ["harper_ls"] = function()
	--         lspconfig.harper_ls.setup({
	--             settings = {
	--                 ["harper-ls"] = {
	--                     userDictPath = "",
	--                 },
	--             },
	--         })
	--     end,
	--     -- NOTE: we will defer this to mrcjkb/rustaceanvim
	--     ["rust_analyzer"] = function() end,
	--     -- ["pyright"] = function()
	--     --     lspconfig.pyright.setup({
	--     --         settings = {
	--     --             pyright = {
	--     --                 disableOrganizeImports = true,
	--     --             },
	--     --             python = {
	--     --                 analysis = {
	--     --                     ignore = { "*" },
	--     --                 },
	--     --             },
	--     --         },
	--     --     })
	--     -- end,
	--     -- ["nginx"] = function()
	--     --     lspconfig.nginx_language_server.setup({
	--     --         cmd = { "${HOME}/.local/share/nvim/mason/packages/nginx-language-server/venv/bin/nginx-language-server" },
	--     --     })
	--     -- end
	-- })
})
