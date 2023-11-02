-- keybindings
vim.g.mapleader = " " -- set space as leader key
local map = vim.api.nvim_set_keymap

-- nvim
-- map("n", "<leader>qq", ":exit<cr>",
--     {noremap = true, silent = true, desc = "quit"}) -- exit vim
-- map("n", "<leader>qs", ":write<cr>",
--     {noremap = true, silent = true, desc = "write"}) -- write buffer
-- map("n", "<leader>qm", ":Mason<cr>",
--     {noremap = true, silent = true, desc = "Mason"}) -- Mason
-- map("n", "<leader>ql", ":Lazy<cr>",
    -- {noremap = true, silent = true, desc = "Lazy"}) -- Mason
-- bufferline
map("n", "[1", ":BufferLineGoToBuffer 1<cr>",
    {noremap = true, silent = true, desc = "buffer #1"})
map("n", "[2", ":BufferLineGoToBuffer 2<cr>",
    {noremap = true, silent = true, desc = "buffer #2"})
map("n", "[3", ":BufferLineGoToBuffer 3<cr>",
    {noremap = true, silent = true, desc = "buffer #3"})
map("n", "[4", ":BufferLineGoToBuffer 4<cr>",
    {noremap = true, silent = true, desc = "buffer #4"})
map("n", "[5", ":BufferLineGoToBuffer 5<cr>",
    {noremap = true, silent = true, desc = "buffer #5"})
map("n", "[6", ":BufferLineGoToBuffer 6<cr>",
    {noremap = true, silent = true, desc = "buffer #6"})
map("n", "[7", ":BufferLineGoToBuffer 7<cr>",
    {noremap = true, silent = true, desc = "buffer #7"})
map("n", "[8", ":BufferLineGoToBuffer 8<cr>",
    {noremap = true, silent = true, desc = "buffer #8"})
map("n", "[9", ":BufferLineGoToBuffer 9<cr>",
    {noremap = true, silent = true, desc = "buffer #9"})
-- map("n", "[p", ":BufferLineCycleNext<cr>",
--     { noremap = true, silent = true, desc = "next buffer" })
-- map("n", "[b", ":BufferLineCyclePrev<cr>",
--     { noremap = true, silent = true, desc = "previous buffer" })
-- telescope
map("n", "<leader>ff", ":lua project_files()<cr>",
    {noremap = true, desc = "files"}) -- find files
map("n", "<leader>fg", ":Telescope live_grep<cr>",
    {noremap = true, silent = true, desc = "grep"}) -- grep
map("n", "<leader>fb", ":Telescope buffers<cr>",
    {noremap = true, silent = true, desc = "buffers"}) -- buffers
map("n", "<leader>fh", ":Telescope help_tags<cr>",
    {noremap = true, silent = true, desc = "nvim help tags"}) -- help
map("n", "<leader>ft", ":Telescope file_browser<cr>",
    {noremap = true, silent = true, desc = "Tree"}) -- todo
map("n", "<leader>fT", ":TodoTelescope<cr>",
    {noremap = true, silent = true, desc = "todo"}) -- todo
map("n", "<leader>fG", ":Telescope git_commits<cr>",
    {noremap = true, silent = true, desc = "git commits"}) -- git commits
map("n", "<leader>fc", ":Telescope commands<cr>",
    {noremap = true, silent = true, desc = "commands"}) -- git commits
map("n", "<leader>fs", ":Telescope lsp_document_symbols<cr>",
    {noremap = true, silent = true, desc = "symbols"}) -- git commits
-- LSP
map("n", "<leader>lf", ":lua vim.lsp.buf.format({async = true})<cr>",
    {noremap = true, silent = true, desc = "format"}) -- lsp - format
map("n", "<leader>li", ":LspInfo<cr>",
    {noremap = true, silent = true, desc = "LSP info"}) -- lsp - info
map("n", "<leader>ln", ":NullLsInfo<cr>",
    {noremap = true, silent = true, desc = "null-ls info"}) -- lsp - format
map("n", "<leader>ln", ":lua vim.lsp.buf.code_action()<CR>",
    {noremap = true, silent = true, desc = "code actions"}) -- lsp - format
-- trouble - workpace diagnostics
map("n", "<leader>lxx", ":TroubleToggle<cr>",
    {noremap = true, silent = true, desc = "toggle"}) -- trouble - toggle
map("n", "<leader>lxw", ":TroubleToggle workspace_diagnostics<cr>",
    {noremap = true, silent = true, desc = "workspace diagnostics"})
map("n", "<leader>lxd", ":TroubleToggle document_diagnostics<cr>",
    {noremap = true, silent = true, desc = "document diagnostics"}) -- trouble - document diagnostics
map("n", "<leader>lxf", ":TroubleToggle quickfix<cr>",
    {noremap = true, silent = true, desc = "quickfix"}) -- trouble - quickfix
--- git
map("n", "<leader>lgb", ":Gitsigns blame_line<cr>",
    {noremap = true, silent = true, desc = "blameline"}) -- trouble - quickfix
