local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local plugins = {
	--- theme
	{
		"catppuccin/nvim",
		priority = 1000,
		config = function()
			require("plugins.ui.catppuccin")
		end,
	}, --- dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			require("plugins.ui.alpha")
		end,
	},
	{
		--- buffer
		{
			"akinsho/bufferline.nvim",
			config = function()
				require("plugins.ui.bufferline")
			end,
		},
		}, --- treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require("plugins.editor.treesitter")
			end,
			dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		}, --- telescope
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-ui-select.nvim",
				"nvim-telescope/telescope-file-browser.nvim",
				"BurntSushi/ripgrep",
			},
			config = function()
				require("plugins.editor.telescope")
			end,
		}, --- gitsigns
		{
			"lewis6991/gitsigns.nvim",
			config = function()
				require("plugins.ui.gitsigns")
			end,
		}, --- mason + lsp
		{
			"williamboman/mason.nvim",
			dependencies = {
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				"williamboman/mason-lspconfig.nvim",
				"neovim/nvim-lspconfig",
			},
			build = ":MasonUpdate",
			config = function()
				require("plugins.editor.mason")
				require("plugins.lsp.mason-lsp")
				require("plugins.lsp.lsp")
			end,
		},
		{
			"jay-babu/mason-null-ls.nvim",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = { "nvimtools/none-ls.nvim" },
			config = function()
				require("plugins.lsp.mason-null-ls")
			end,
		}, -- misc
		{
			"folke/trouble.nvim",
			branch = "dev",
			config = function()
				require("plugins.lsp.trouble")
			end,
			keys = {
				{
					"<leader>xx",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Diagnostics (Trouble)",
				},
				{
					"<leader>xX",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},
				{
					"<leader>cs",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					desc = "Symbols (Trouble)",
				},
				{
					"<leader>xL",
					"<cmd>Trouble loclist toggle<cr>",
					desc = "Location List (Trouble)",
				},
				{
					"<leader>xQ",
					"<cmd>Trouble qflist toggle<cr>",
					desc = "Quickfix List (Trouble)",
				},
			},
		},
		{
			"folke/todo-comments.nvim",
			config = function()
				require("plugins.editor.todo-comments")
			end,
		}, -- "christoomey/vim-tmux-navigator",
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
			end,
			config = function()
				require("plugins.editor.which-key")
			end,
		},
		{ "echasnovski/mini.pairs", event = "InsertEnter", opts = {} },
		{ "https://github.com/mfussenegger/nvim-ansible.git" },
		{ "echasnovski/mini.surround", opts = {} },
		{ "b0o/schemastore.nvim" },
		--- completion
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-vsnip",
				"rafamadriz/friendly-snippets",
				"onsails/lspkind.nvim",
				"saadparwaiz1/cmp_luasnip",
			},
			config = function()
				require("plugins.editor.nvim-cmp")
			end,
		},
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, --- misc: editor
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("plugins.ui.indent-blankline")
			end,
		},
		{
			"echasnovski/mini.comment",
			opts = {
				options = {
					custom_commentstring = function()
						return require("ts_context_commentstring.internal").calculate_commentstring()
							or vim.bo.commentstring
					end,
				},
			},
		},
		{ "romainl/vim-cool" },
		{
			"RRethy/vim-illuminate",
			config = function()
				require("plugins.editor.vim-illuminate")
			end,
		},
		{
			"ray-x/lsp_signature.nvim",
			event = "VeryLazy",
			opts = {},
			config = function()
				require("plugins.lsp.lsp-signature")
			end,
		},
		{ "towolf/vim-helm" },
		{
			"LunarVim/bigfile.nvim",
			config = function()
				require("plugins.editor.bigfile")
			end,
		},
		{
			"someone-stole-my-name/yaml-companion.nvim",
			dependencies = {
				"neovim/nvim-lspconfig",
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
			},
		},
		{
			"nvim-lualine/lualine.nvim",
			event = "VeryLazy",
			config = function()
				require("plugins.ui.lualine")
			end,
	},
}

local opts = {
	install = {
		colorscheme = { "catppuccin" },
	},
	ui = {
		backdrop = 100,
		border = "rounded",
		title = " Lazy Plugin Manager ",
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
}

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)
