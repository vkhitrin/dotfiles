require("catppuccin").setup({
    flavour = "mocha",
    background = {
        light = "latte",
        dark = "mocha",
    },
    integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mason = true,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        telescope = true,
        illuminate = {
            enabled = true,
            lsp = false
        },
        which_key = true
    }
})

vim.cmd.colorscheme "catppuccin"
