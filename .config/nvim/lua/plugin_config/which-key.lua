local wk = require("which-key")
local opts = {}
local mappings = {}
opts = {}
mappings = {
    ["<leader>q"] = { name = "+nvim" },
    ["<leader>f"] = { name = "+find" },
    ["<leader>l"] = { name = "+lsp/code actions" },
    ["<leader>lx"] = { name = "+trouble" },
    ["<leader>lg"] = { name = "+git" },
}
wk.register(mappings, opts)
