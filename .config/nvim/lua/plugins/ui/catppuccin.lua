require("catppuccin").setup({
    flavour = "mocha",
    background = {
        light = "latte",
        dark = "mocha",
    },
    custom_highlights = function(colors)
        return {
            -- Snacks highlights
            SnacksPicker = { link = "Normal" },
            SnacksPickerMatch = { fg = colors.red },
            -- Bufferline highlights
            BufferLineFill = { bg = colors.mantle, fg = colors.text },
            BufferLineTabSeparator = { bg = colors.mantle, fg = colors.text },
            BufferLineSeparatorVisible = { bg = colors.mantle, fg = colors.text },
            BufferLineSeparatorSelected = { bg = colors.mantle, fg = colors.text },
            -- Pmenu highlights
            Pmenu = {
                bg = colors.mantle,
                fg = colors.overlay2,
            },
            PmenuSel = { bg = colors.surface1, bold = true },
            PmenuSbar = { bg = colors.surface1 },
            PmenuThumb = { bg = colors.overlay0 },
        }
    end,
    integrations = {
        blink_cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        grug_far = true,
        mason = true,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        snacks = { enabled = true, indentscope_color = "" },
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
            -- underlines = {
            --     errors = {},
            --     hints = {},
            --     warnings = {},
            --     information = {},
            -- },
            inlay_hints = {
                background = true,
            },
        },
    },
})

vim.cmd.colorscheme("catppuccin")
