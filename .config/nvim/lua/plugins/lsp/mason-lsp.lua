local lspconfig = require("lspconfig")
local schemastore = require("schemastore")
require("lspconfig.ui.windows").default_options.border = "rounded"
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities =
    vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
--- Rebind to personal keybindings
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
        vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
        vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    end,
})

local yaml_companion_settings = require("yaml-companion").setup({
    schemas = {
        {
            name = "Kustomization",
            uri = "https://json.schemastore.org/kustomization.json",
        },
        {
            name = "GitHub Workflow",
            uri = "https://json.schemastore.org/github-workflow.json",
        },
    },
    builtin_matches = {
        kubernetes = { enabled = true },
        cloud_init = { enabled = true },
    },
    lspconfig = {
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
    },
})

require("mason-lspconfig").setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({})
    end,
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    telmetry = {
                        enable = false,
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            -- unpack(vim.api.nvim_get_runtime_file("", true)),
                            -- vim.api.nvim_get_proc,
                        },
                    },
                },
            },
        })
    end,
    ["jsonls"] = function()
        lspconfig.jsonls.setup({
            settings = {
                json = {
                    schemas = schemastore.json.schemas(),
                    validate = { enable = true },
                },
            },
        })
    end,
    ["yamlls"] = function()
        lspconfig.yamlls.setup(yaml_companion_settings)
    end,
    ["helm_ls"] = function()
        lspconfig.helm_ls.setup({
            settings = {
                ["helm-ls"] = {
                    yamlls = {
                        path = "yaml-language-server",
                    },
                },
            },
        })
    end,
    ["pyright"] = function()
        lspconfig.pyright.setup({
            settings = {
                pyright = {
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        ignore = { "*" },
                    },
                },
            },
        })
    end,

    -- ["nginx"] = function()
    --     lspconfig.nginx_language_server.setup({
    --         cmd = { "${HOME}/.local/share/nvim/mason/packages/nginx-language-server/venv/bin/nginx-language-server" },
    --     })
    -- end
})

require("lsp_signature").on_attach(vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
        }
        vim.diagnostic.open_float(nil, opts)
    end,
}))

-- Add borders to float windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
