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
            },
        },
    },
}
