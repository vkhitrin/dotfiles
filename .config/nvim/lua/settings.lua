-- settings

-- vim.loader.enable() -- experimental loa module loader
vim.opt.showmatch = true                      -- show matching brackets
-- vim.opt.ignorecase = true -- case insensitive matching
vim.opt.hlsearch = true                       -- highlight search results
vim.opt.smartindent = true                    -- enable autoindent
vim.opt.number = true                         -- add line numbers
vim.opt.termguicolors = true                  -- improved colors
vim.opt.wildmode = "longest,list"             -- get bash-like tab completions
-- filetype plugin indent on                  " allows auto-indenting depending on file type
vim.opt.tabstop = 4                           -- number of columns occupied by a tab character
vim.opt.expandtab = true                      -- converts tabs to white space
vim.opt.shiftwidth = 4                        -- width for autoindents
vim.opt.softtabstop = 4                       -- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.updatetime = 250                      -- update sign column every quarter second
vim.opt.signcolumn = "yes:1"                  -- signcolumn displays two columns
vim.opt.hidden = true                         -- keep files open without displaying
vim.opt.completeopt = "menu,menuone,noselect" -- configure completion
vim.opt.laststatus = 2                        -- always display statusline
-- vim.opt.background = "dark"                   -- set background to light
-- vim.opt.clipboard = "unnamedplus" -- copy selection to system clipboard
vim.opt.cursorline = true                     -- display cursorline
vim.opt.mouse = ""                            -- disable mouse
--lsp
