local wk = require("which-key")
local opts
opts = {}
local mappings = {}
mappings = {
    ["<leader>f"] = { name = "+Telescope/Utils" },
    ["<leader>l"] = { name = "+LSP/Diagnostics" },
    ["<leader>lx"] = { name = "+Trouble" },
    ["<leader>y"] = {
        { '"+y', "Copy current selection to clipboard", mode = "x" },
    },
}
wk.register(mappings, opts)
wk.setup({
    window = {
        border = "rounded",
    },
})
