require("bufferline").setup({
    highlights = {
        fill = { bg = "#0b0e13" },
        tab = { bg = "#0b0e13" },
        background = { bg = "#0b0e13" },
        separator = { bg = "#0b0e13" },
        buffer_visible = { bg = "#0b0e13" },
        buffer_selected = { bg = "#0b0e13" }
    },
    options = {
        mode = "buffers",
        indicator = { style = "none" },
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_tab_indicators = true
    }
})
