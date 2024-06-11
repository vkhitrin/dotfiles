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
            lsp = false,
        },
        which_key = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = {},
                hints = {},
                warnings = {},
                information = {},
            },
            inlay_hints = {
                background = true,
            },
        },
    },
})

vim.cmd.colorscheme("catppuccin")
