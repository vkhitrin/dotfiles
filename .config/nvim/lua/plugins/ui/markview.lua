local mv = require("markview")
local presets = require("markview.presets")
require("markview").setup({
    -- highlight_groups = vim.list_extend(mv.configuration.highlight_groups, presets.heading.decorated_hls),
    -- headings = presets.heading.simple,
    markdown = {
        list_items = {
            enable = true,
            shift_amount = 0,

            marker_plus = {
                add_padding = false,
                text = "•",
                hl = "@markup.list",
            },
            marker_minus = {
                add_padding = false,
                text = "•",
                hl = "@markup.list",
            },
            marler_star = {
                add_padding = false,
                text = "•",
                hl = "@markup.list",
            },

            marker_dot = {
                add_padding = false,
                text = "•",
                hl = "@markup.list",
            },
        },
        -- inline_codes = {
        --     hl = "Pmenu",
        -- },
        checkboxes = {
            enable = true,
            checked = {
                text = "",
                hl = "@markup.list.checked",
            },
            unchecked = {
                text = "",
                hl = "@markup.list.checked",
            },
        },
    },
})
