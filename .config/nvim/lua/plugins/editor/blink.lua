require("blink.cmp").setup({
    -- keymap = { preset = "super-tab", ["<F11>"] = require("minuet").make_blink_map() },
    keymap = { preset = "super-tab" },
    -- appearance = { nerd_font_variant = "mono" },
    completion = {
        documentation = { auto_show = true },
        trigger = { prefetch_on_insert = false },
    },
    sources = {
        -- default = { "lsp", "path", "buffer", "snippets", "minuet" },
        default = { "lsp", "path", "buffer", "snippets" },
        per_filetype = {
            codecompanion = { "codecompanion" },
        },
        -- providers = {
        --     minuet = {
        --         name = "minuet",
        --         module = "minuet.blink",
        --         async = true,
        --         timeout_ms = 3000,
        --         score_offset = 50,
        --     },
        -- },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
})
