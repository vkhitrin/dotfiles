require("codecompanion").setup({
    strategies = {
        chat = {
            adapter = "ollama",
            slash_commands = {
                codebase = require("vectorcode.integrations").codecompanion.chat.make_slash_command(),
            },
            tools = {
                vectorcode = {
                    description = "Run VectorCode to retrieve the project context.",
                    callback = require("vectorcode.integrations").codecompanion.chat.make_tool(),
                },
            },
        },
        inline = {
            adapter = "ollama",
        },
    },
    display = {
        diff = {
            provider = "mini_diff",
        },
    },
})
