local lsp = require("lspconfig")

--- set diagnostics signs
local signs = {
    { name = "DiagnosticSignError", text = "E" },
    { name = "DiagnosticSignWarn",  text = "W" },
    { name = "DiagnosticSignHint",  text = "H" },
    { name = "DiagnosticSignInfo",  text = "I" },
}
for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = false,
})
