local cmp = require("cmp")

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local lspkind = require("lspkind")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    completion = { compleopt = "menu,menuone,noinsert,popup" },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "async_path" },
        { name = "git" },
        -- { name = "rg" },
    }, { { name = "buffer" } }),

    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            symbol_map = { Copilot = "" },
            menu = {
                luasnip = "[Snippets]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                buffer = "[Buffer]",
                async_path = "[Path]",
                git = "[Git]",
                rg = "[Ripgrep]",
                copilot = "[Copilot]",
            },
        }),
        -- window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
        -- },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "git" },
    }, { { name = "buffer" } }),
})

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "async_path" } }, { { name = "cmdline" } }),
})

local format = require("cmp_git.format")
local sort = require("cmp_git.sort")
require("cmp_git").setup({
    github = {
        hosts = { "github.com" },
        issues = {
            fields = { "title", "number", "body", "updatedAt", "state" },
            filter = "all",
            limit = 100,
            state = "all",
            sort_by = sort.github.issues,
            format = format.github.issues,
        },
        mentions = {
            limit = 100,
            sort_by = sort.github.mentions,
            format = format.github.mentions,
        },
        pull_requests = {
            fields = { "title", "number", "body", "updatedAt", "state" },
            limit = 100,
            state = "all",
            sort_by = sort.github.pull_requests,
            format = format.github.pull_requests,
        },
    },
    gitlab = {
        hosts = { "gitlab.com" },
        issues = {
            limit = 100,
            state = "opened", -- opened, closed, all
            sort_by = sort.gitlab.issues,
            format = format.gitlab.issues,
        },
        mentions = {
            limit = 100,
            sort_by = sort.gitlab.mentions,
            format = format.gitlab.mentions,
        },
        merge_requests = {
            limit = 100,
            state = "opened", -- opened, closed, locked, merged
            sort_by = sort.gitlab.merge_requests,
            format = format.gitlab.merge_requests,
        },
    },
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
-- vim.keymap.set("i", "<c-G>", function()
--     require("cmp").complete({
--         config = {
--             sources = {
--                 {
--                     name = "rg",
--                 },
--             },
--         },
--     })
-- end)
