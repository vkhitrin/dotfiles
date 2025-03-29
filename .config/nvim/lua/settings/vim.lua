vim.opt.showmatch = true                 -- show matching brackets
vim.opt.hlsearch = true                  -- highlight search results
vim.opt.smartindent = true               -- enable autoindent
vim.opt.number = true                    -- add line numbers
vim.opt.termguicolors = true             -- improved colors
vim.opt.wildmode = "longest,list"        -- get bash-like tab completions
vim.opt.tabstop = 4                      -- number of columns occupied by a tab character
vim.opt.expandtab = true                 -- converts tabs to white space
vim.opt.shiftwidth = 4                   -- width for autoindents
vim.opt.softtabstop = 4                  -- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.updatetime = 250                 -- update sign column every quarter second
vim.opt.signcolumn = "yes:1"             -- signcolumn displays two columns
vim.opt.hidden = true                    -- keep files open without displaying
vim.opt.completeopt = "menuone,noselect" -- configure completion
vim.opt.laststatus = 2                   -- always display statusline
vim.opt.background = "dark"              -- set background to dark
vim.opt.cursorline = true                -- display cursorline
vim.opt.mouse = ""                       -- disable mouse
vim.opt.wrap = false                     -- diable line wrap
vim.opt.showmode = false                 -- Do not display mode below statusline
vim.g.mapleader = " "                    -- set space as leader key

-- Neovide
if vim.g.neovide then
    vim.g.neovide_floating_shadow = false
    vim.g.neovide_cursor_vfx_mode = ""
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_input_use_logo = 1
    vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.g.neovide_text_gamma = 0.8
    vim.g.neovide_text_contrast = 0.1
end
