vim.api.nvim_create_autocmd("TermOpen", {
    desc = "nvim builtin terminal tweaks",
    callback = function()
        vim.opt_local.number = false
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf", "help", "grug-far" },
    desc = "Quick closing of quickfix, help windows, and grug-far",
    callback = function()
        vim.keymap.set("n", "q", "<cmd>bd<cr>", { silent = true, buffer = true })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }
        -- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        vim.keymap.set("n", "gE", function()
            vim.diagnostic.open_float({ focusable = true })
        end, { desc = "Expand an Error into a float" })
        vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
        vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})
