require("blink.cmp").setup({
    -- keymap = { preset = "super-tab", ["<A-y>"] = require("minuet").make_blink_map() },
    keymap = { preset = "super-tab" },
    appearance = { nerd_font_variant = "mono" },
    completion = { documentation = { auto_show = true }, trigger = { prefetch_on_insert = false } },
    sources = {
        default = { "lsp", "path", "buffer", "snippets" },
        per_filetype = {
            codecompanion = { "codecompanion" },
        },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
})
