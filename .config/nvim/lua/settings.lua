vim.opt.showmatch = true                      -- show matching brackets
vim.opt.hlsearch = true                       -- highlight search results
vim.opt.smartindent = true                    -- enable autoindent
vim.opt.number = true                         -- add line numbers
vim.opt.termguicolors = true                  -- improved colors
vim.opt.wildmode = "longest,list"             -- get bash-like tab completions
vim.opt.tabstop = 4                           -- number of columns occupied by a tab character
vim.opt.expandtab = true                      -- converts tabs to white space
vim.opt.shiftwidth = 4                        -- width for autoindents
vim.opt.softtabstop = 4                       -- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.updatetime = 250                      -- update sign column every quarter second
vim.opt.signcolumn = "yes:1"                  -- signcolumn displays two columns
vim.opt.hidden = true                         -- keep files open without displaying
vim.opt.completeopt = "menu,menuone,noselect" -- configure completion
vim.opt.laststatus = 2                        -- always display statusline
vim.opt.background = "dark"                   -- set background to dark
vim.opt.cursorline = true                     -- display cursorline
vim.opt.mouse = ""                            -- disable mouse
vim.opt.wrap = false                          -- diable line wrap
vim.g.mapleader = " "                         -- set space as leader key
--- autocmds
vim.api.nvim_create_autocmd("TermOpen", {
    desc = "nvim builtin terminal tweaks",
    callback = function()
        vim.opt_local.number = false
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf", "help" },
    desc = "Quick closing of quickfix and help windows",
    callback = function()
        vim.keymap.set("n", "q", "<cmd>bd<cr>", { silent = true, buffer = true })
    end,
})
