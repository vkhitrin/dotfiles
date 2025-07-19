return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            telmetry = {
                enable = false,
            },
            workspace = {
                checkThirdParty = false,
                -- library = {
                --     unpack(vim.api.nvim_get_runtime_file("", true)),
                --     vim.api.nvim_get_proc,
                -- },
            },
        },
    },
}
