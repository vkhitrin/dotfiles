local lsp = require("lspconfig")

--- set diagnostics signs
-- local signs = {
--     { name = "DiagnosticSignError", text = "" },
--     { name = "DiagnosticSignWarn",  text = "" },
--     { name = "DiagnosticSignHint",  text = "󰌶" },
--     { name = "DiagnosticSignInfo",  text = "" },
-- }
-- for _, sign in ipairs(signs) do
--     vim.diagnostic.config(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
-- end

vim.diagnostic.config({
    virtual_text = false,
})
