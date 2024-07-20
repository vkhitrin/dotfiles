local mocha = require("catppuccin.palettes").get_palette("mocha")
require("bufferline").setup({
    highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "italic", "bold" },
        custom = {
            mocha
        }
        -- custom = {
        --     mocha = {
        --         fill = { bg = "#1e1e2e" },
        --         background = { bg = "#1e1e2e" },
        --         buffer_visible = { bg = "#1e1e2e" },
        --         buffer_selected = { bg = "#1e1e2e" },
        --         duplicate_selected = { bg = "#1e1e2e" },
        --         duplicate_visible = { bg = "#1e1e2e" },
        --         duplicate = { bg = "#1e1e2e" },
        --         separator = { bg = "#1e1e2e", fg = "#1e1e2e" },
        --         separator_visible = { bg = "#1e1e2e" },
        --         separator_selected = { bg = "#1e1e2e" },
        --         tab = { bg = "#1e1e2e" },
        --         tab_close = { bg = "#1e1e2e" },
        --         tab_selected = { bg = "#1e1e2e" },
        --         tab_separator = { bg = "#1e1e2e" },
        --         tab_separator_selected = { bg = "#1e1e2e" },
        --         offset_separator = { bg = "#1e1e2e" },
        --         numbers = { bg = "#1e1e2e" },
        --         numbers_visible = { bg = "#1e1e2e" },
        --         numbers_selected = { bg = "#1e1e2e" },
        --         diagnostic = { bg = "#1e1e2e" },
        --         diagnostic_visible = { bg = "#1e1e2e" },
        --         diagnostic_selected = { bg = "#1e1e2e" },
        --         error = { bg = "#1e1e2e" },
        --         error_visible = { bg = "#1e1e2e" },
        --         error_diagnostic = { bg = "#1e1e2e" },
        --         error_diagnostic_visible = { bg = "#1e1e2e" },
        --         error_diagnostic_selected = { bg = "#1e1e2e" },
        --         warning = { bg = "#1e1e2e" },
        --         warning_visible = { bg = "#1e1e2e" },
        --         warning_diagnostic = { bg = "#1e1e2e" },
        --         warning_diagnostic_visible = { bg = "#1e1e2e" },
        --         warning_diagnostic_selected = { bg = "#1e1e2e" },
        --         info = { bg = "#1e1e2e" },
        --         info_visible = { bg = "#1e1e2e" },
        --         info_diagnostic = { bg = "#1e1e2e" },
        --         info_diagnostic_visible = { bg = "#1e1e2e" },
        --         info_diagnostic_selected = { bg = "#1e1e2e" },
        --         hint = { bg = "#1e1e2e" },
        --         hint_visible = { bg = "#1e1e2e" },
        --         hint_diagnostic = { bg = "#1e1e2e" },
        --         hint_diagnostic_visible = { bg = "#1e1e2e" },
        --         hint_diagnostic_selected = { bg = "#1e1e2e" },
        --         indicator_selected = { bg = "#1e1e2e" },
        --         indicator_visible = { bg = "#1e1e2e" },
        --         pick_selected = { bg = "#1e1e2e" },
        --         pick_visible = { bg = "#1e1e2e" },
        --         pick = { bg = "#1e1e2e" },
        --         close_button_selected = { bg = "#1e1e2e" },
        --         close_button_visible = { bg = "#1e1e2e" },
        --         close_button = { bg = "#1e1e2e" },
        --         modified_selected = { bg = "#1e1e2e" },
        --         modified_visible = { bg = "#1e1e2e" },
        --         modified = { bg = "#1e1e2e" },
        --     },
        -- },
    }),
    options = {
        mode = "buffers",
        indicator = { style = "none" },
        diagnostics = "nvim_lsp",
        update_in_insert = true,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " " or (e == "warning" and " " or "󰌶")
                s = s .. n .. sym
            end
            return s
        end,
        -- show_buffer_icons = false,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
    },
})
