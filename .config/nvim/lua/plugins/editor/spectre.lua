local sed_command = vim.loop.os_uname().sysname == "Darwin" and "gsed" or "sed"

require("spectre").setup({
    is_block_ui_break = true,
    replace_engine = {
        ["sed"] = {
            cmd = sed_command,
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
