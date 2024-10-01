require("spectre").setup({
    is_block_ui_break = true,
    replace_engine = {
        ["sed"] = {
            cmd = "gsed",
            args = nil,
            options = {
                ["ignore-case"] = {
                    value = "--ignore-case",
                    icon = "[I]",
                    desc = "ignore case",
                },
            },
        },
    },
})
