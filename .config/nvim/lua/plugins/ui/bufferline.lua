local mocha = require("catppuccin.palettes").get_palette("mocha")
require("bufferline").setup({
    highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "italic", "bold" },
        custom = {
            mocha = {
                fill = { bg = "#181825" },
            },
        },
    }),
    options = {
        mode = "buffers",
        indicator = { style = "none" },
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        -- show_buffer_icons = false,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_tab_indicators = true,
    },
})
