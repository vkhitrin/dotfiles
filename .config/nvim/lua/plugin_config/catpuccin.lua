require("catppuccin").setup({
    flavour = "latte", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = function(colors)
        return {
            -- SignColumn = { bg = transparent },
            BufTabLineCurrent = { bg = "#bcc0cc", fg = "#4c4f69" },
            BufTabLineActive = { bg = "#dce0e8", fg = "#4c4f69" },
            BufTabLineHidden = { bg = "#dce0e8", fg = "#4c4f69" },
            BufTabLineFill = { bg = "#dce0e8", fg = "#4c4f69" },
        }
    end,
    integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        fern = true,
        treesitter = true,
        lsp_trouble = true
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
