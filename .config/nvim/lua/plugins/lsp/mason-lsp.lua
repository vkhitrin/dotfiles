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
})
