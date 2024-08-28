require("catppuccin").setup({
    flavour = "mocha",
    background = {
        light = "latte",
        dark = "mocha",
    },
    custom_highlights = function(colors)
        return {
            -- Telescop highlights
            TelescopeMatching = { fg = colors.red, bold = true },
            TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
            TelescopePromptPrefix = { bg = colors.mantle },
            TelescopePromptNormal = { bg = colors.mantle },
            TelescopeResultsNormal = { bg = colors.mantle },
            TelescopePreviewNormal = { bg = colors.mantle },
            TelescopePromptBorder = { bg = colors.mantle, fg = colors.mantle },
            TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
            TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
            TelescopePromptTitle = { bg = colors.blue, fg = colors.mantle, bold = true },
            TelescopeResultsTitle = { fg = colors.mantle },
            TelescopePreviewTitle = { bg = colors.blue, fg = colors.mantle, bold = true },
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
