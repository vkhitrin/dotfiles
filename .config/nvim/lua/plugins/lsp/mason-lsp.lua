local lspconfig = require("lspconfig")
local schemastore = require("schemastore")
local schemacompanion = require("schema-companion")
require("lspconfig.ui.windows").default_options.border = "none"
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities =
    vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        vim.keymap.set("n", "gE", function()
            vim.diagnostic.open_float({ focusable = true })
        end, { desc = "Expand an Error into a float" })
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
        require("lspconfig").yamlls.setup(require("schema-companion").setup_client({
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
        }))
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
    ["powershell_es"] = function()
        lspconfig.powershell_es.setup({
            bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
        })
    end,
    ["harper_ls"] = function()
        lspconfig.harper_ls.setup({
            settings = {
                ["harper-ls"] = {
                    userDictPath = "",
                },
            },
        })
    end,
    -- ["pyright"] = function()
    --     lspconfig.pyright.setup({
    --         settings = {
    --             pyright = {
    --                 disableOrganizeImports = true,
    --             },
    --             python = {
    --                 analysis = {
    --                     ignore = { "*" },
    --                 },
    --             },
    --         },
    --     })
    -- end,
    -- ["esbonio"] = function()
    --     lspconfig.esbonio.setup({
    --         cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/esbonio") },
    --         init_options = {
    --             server = {
    --                 logLevel = "debug",
    --             },
    --         },
    --     })
    -- end,

    -- ["nginx"] = function()
    --     lspconfig.nginx_language_server.setup({
    --         cmd = { "${HOME}/.local/share/nvim/mason/packages/nginx-language-server/venv/bin/nginx-language-server" },
    --     })
    -- end
})

-- require("lsp_signature").on_attach(vim.api.nvim_create_autocmd("CursorHold", {
--     buffer = bufnr,
--     callback = function()
--         local opts = {
--             focusable = false,
--             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--             border = "none",
--             source = "always",
--             prefix = " ",
--             scope = "cursor",
--         }
--         vim.diagnostic.open_float(nil, opts)
--     end,
-- }))

-- Add borders to float windows
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--     opts = opts or {}
--     opts.border = "none"
--     return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

--- Custom LSP Capabilities Command
vim.api.nvim_create_user_command("LspCapabilities", function()
    local curBuf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_active_clients({ bufnr = curBuf })

    for _, client in pairs(clients) do
        if client.name ~= "null-ls" then
            local capAsList = {}
            for key, value in pairs(client.server_capabilities) do
                if value and key:find("Provider") then
                    local capability = key:gsub("Provider$", "")
                    table.insert(capAsList, "- " .. capability)
                end
            end
            table.sort(capAsList) -- sorts alphabetically
            local msg = "# " .. client.name .. "\n" .. table.concat(capAsList, "\n")
            vim.notify(msg, "trace", {
                on_open = function(win)
                    local buf = vim.api.nvim_win_get_buf(win)
                    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                end,
                timeout = 14000,
            })
            vim.fn.setreg("+", "Capabilities = " .. vim.inspect(client.server_capabilities))
        end
    end
end, {})
