-- keybindings
-- -

vim.g.mapleader = " " -- set space as leader key
local map = vim.api.nvim_set_keymap

-- nvim
map("n", "<leader>qq", ":exit<cr>", { noremap = true, silent = true, desc = "quit" })                          -- exit vim
map("n", "<leader>qs", ":write<cr>", { noremap = true, silent = true, desc = "write" })                        -- write buffer
map("n", "<leader>qm", ":Mason<cr>", { noremap = true, silent = true, desc = "Mason" })                        -- Mason
map("n", "<leader>ql", ":Lazy<cr>", { noremap = true, silent = true, desc = "Lazy" })                        -- Mason
-- find
map("n", "<leader>ff", ":Telescope find_files hidden=true<cr>", { noremap = true, desc = "files" })            -- telescope - find files
map("n", "<leader>fg", ":Telescope live_grep<cr>", { noremap = true, silent = true, desc = "grep" })           -- telescope - grep
map("n", "<leader>fb", ":Telescope buffers<cr>", { noremap = true, silent = true, desc = "buffers" })          -- telescope - buffers
map("n", "<leader>fh", ":Telescope help_tags<cr>", { noremap = true, silent = true, desc = "nvim help tags" }) -- telescope - help tags
map("n", "<leader>ft", ":TodoTelescope<cr>", { noremap = true, silent = true, desc = "todo" })                 -- telescope - todo
-- LSP
map("n", "<leader>lf", ":lua vim.lsp.buf.format()<cr>", { noremap = true, silent = true, desc = "format" })    -- lsp - format
map("n", "<leader>li", ":LspInfo<cr>", { noremap = true, silent = true, desc = "LSP info" })    -- lsp - format
map("n", "<leader>ln", ":NullLsInfo<cr>", { noremap = true, silent = true, desc = "null-ls info" })    -- lsp - format
map("n", "<leader>lxx", ":TroubleToggle<cr>", { noremap = true, silent = true, desc = "toggle" })              -- trouble - toggle
map("n", "<leader>lxw", ":TroubleToggle workspace_diagnostics<cr>",
    { noremap = true, silent = true, desc = "workspace diagnostics" })                                         -- trouble - workpace diagnostics
map("n", "<leader>lxd", ":TroubleToggle document_diagnostics<cr>",
    { noremap = true, silent = true, desc = "document diagnostics" })                                          -- trouble - document diagnostics
map("n", "<leader>lxf", ":TroubleToggle quickfix<cr>",
    { noremap = true, silent = true, desc = "quickfix" })                                                      -- trouble - quickfix
--- git
map("n", "<leader>lgb", ":Gitsigns blameline<cr>",
    { noremap = true, silent = true, desc = "blameline" })                                                      -- trouble - quickfix

-- nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
-- nnoremap gR <cmd>TroubleToggle lsp_references<cr>
-- nmap <silent> <F8> :TagbarToggle<CR>
-- nnoremap <silent> <F11> :set spell!<cr>
