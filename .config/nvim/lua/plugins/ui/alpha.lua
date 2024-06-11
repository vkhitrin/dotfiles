local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    "TODO:                                                          ",
    "- Lazy load more plugins                                       ",
    "- Configure keybindings                                        ",
    "- Fix YAML schemastore                                         ",
    "- Fix schema integration with Statusline                       ",
    "- Fix golang LSP                                               ",
    "- Implement DAP (debugger adapter protocol)                    ",
}

-- Set menu
-- dashboard.section.buttons.val = {}
dashboard.section.buttons.val = {
    dashboard.button("n", "🗒️ New file", ":ene <BAR> startinsert <CR>"),
    -- dashboard.button("s", "🛠️ Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button("l", "🦥 Lazy", ":Lazy<CR>"),
    dashboard.button("m", "🏰 Mason", ":Mason<CR>"),
    dashboard.button("q", "🚪 Quit NVIM", ":qa<CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

vim.api.nvim_create_autocmd("User", {
    callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100) / 100
        dashboard.section.footer.val = "Lazy-loaded " .. stats.loaded .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
    end,
})

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
