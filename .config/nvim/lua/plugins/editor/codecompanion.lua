require("codecompanion").setup({
    strategies = {
        chat = {
            adapter = "ollama",
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



