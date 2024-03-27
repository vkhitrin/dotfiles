vim.api.nvim_set_hl(0, "NormalFloat", { background = "#1e1e2d" })
require("lsp_signature").setup({
   fixed_pos = true,
   handler_opts = {
       border = "rounded",
   },
   hi_parameter = "TelescopeSelection",
   hint_enable = false
})
