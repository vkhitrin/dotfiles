local wk = require("which-key")
local mappings = {}
mappings = {
    { "<leader>f",  group = "+Telescope/Utils" },
    { "<leader>l",  group = "+LSP/Diagnostics" },
    { "<leader>lx", group = "+Trouble" },
    { "<leader>y",  '"+y',                     desc = "Copy current selection to clipboard", mode = "x" },
}
wk.add(mappings)
wk.setup({
    win = {
        border = "none",
    },
})
