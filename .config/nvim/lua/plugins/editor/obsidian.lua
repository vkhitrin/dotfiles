require("obsidian").setup({
    workspaces = {
        {
            name = "Personal",
            path = "~/.iCloudDrive/OperatingSystems/Cross-Platform/Obsidian/Personal",
        },
        {
            name = "Work",
            path = "~/.iCloudDrive/OperatingSystems/Cross-Platform/Obsidian/Work",
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
    legacy_commands = false,
})
