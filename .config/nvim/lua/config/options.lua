vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt

opt.showmatch = true
opt.hlsearch = true
opt.smartindent = true
opt.number = true
opt.termguicolors = true
opt.wildmode = "longest,list"
opt.tabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.updatetime = 250
opt.signcolumn = "yes:1"
opt.hidden = true
opt.completeopt = "menuone,noselect"
opt.laststatus = 2
opt.background = "dark"
opt.cursorline = true
opt.mouse = ""
opt.wrap = false
opt.showmode = false
opt.foldenable = true
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldcolumn = "0"
opt.conceallevel = 0
opt.winborder = "single"
opt.syntax = "on"

-- LSP Diagnostics
vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})

-- Enable custom LSP servers
vim.lsp.enable("vectorcode_server")

-- Neovide GUI settings
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
