vim.api.nvim_create_autocmd("TermOpen", {
    desc = "nvim builtin terminal tweaks",
    callback = function()
        vim.opt_local.number = false
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf", "help" },
    desc = "Quick closing of quickfix and help windows",
    callback = function()
        vim.keymap.set("n", "q", "<cmd>bd<cr>", { silent = true, buffer = true })
    end,
})
