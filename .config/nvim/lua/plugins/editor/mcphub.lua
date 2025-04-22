require("mcphub").setup({
    auto_approve = true,
    use_bundled_binary = true,
    extensions = {
        codecompanion = {
            show_result_in_chat = false,
            make_vars = true,
            make_slash_commands = true,
        },
    },
})
