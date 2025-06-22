require("obsidian").setup({
    workspaces = {
        {
            name = "Personal",
            path = "~/.iCloudDrive/OperatingSystems/Cross-Platform/Obsidian/Personal",
        },
    },
    completion = {
        nvim_cmp = false,
        blink = true,
    },
    picker = {
        name = "snacks.pick",
    },
    ui = { enable = false },
})
