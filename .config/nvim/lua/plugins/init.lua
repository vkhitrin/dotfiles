local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local plugins = {
	{
		"https://github.com/catppuccin/nvim",
		priority = 1000,
		config = function()
			require("plugins.ui.catppuccin")
		end,
	},
	{
		"https://github.com/nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("plugins.editor.treesitter")
		end,
	},
	{
		"https://github.com/folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("plugins.editor.snacks")
		end,
		keys = {
			{
				"<leader><space>",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart Find Files",
			},
			{
				"<leader>,",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>:",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Find Git Files",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent",
			},
			-- git
			{
				"<leader>gb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git Branches",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gL",
				function()
					Snacks.picker.git_log_line()
				end,
				desc = "Git Log Line",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>gS",
				function()
					Snacks.picker.git_stash()
				end,
				desc = "Git Stash",
			},
			{
				"<leader>gd",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git Log File",
			},
			-- Grep
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sB",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep Open Buffers",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			-- search
			{
				'<leader>s"',
				function()
					Snacks.picker.registers()
				end,
				desc = "Registers",
			},
			{
				"<leader>s/",
				function()
					Snacks.picker.search_history()
				end,
				desc = "Search History",
			},
			{
				"<leader>sa",
				function()
					Snacks.picker.autocmds()
				end,
				desc = "Autocmds",
			},
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sc",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader>sC",
				function()
					Snacks.picker.commands()
				end,
				desc = "Commands",
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>sD",
				function()
					Snacks.picker.diagnostics_buffer()
				end,
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "Help Pages",
			},
			{
				"<leader>sH",
				function()
					Snacks.picker.highlights()
				end,
				desc = "Highlights",
			},
			{
				"<leader>si",
				function()
					Snacks.picker.icons()
				end,
				desc = "Icons",
			},
			{
				"<leader>sj",
				function()
					Snacks.picker.jumps()
				end,
				desc = "Jumps",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<leader>sl",
				function()
					Snacks.picker.loclist()
				end,
				desc = "Location List",
			},
			{
				"<leader>sm",
				function()
					Snacks.picker.marks()
				end,
				desc = "Marks",
			},
			{
				"<leader>sM",
				function()
					Snacks.picker.man()
				end,
				desc = "Man Pages",
			},
			{
				"<leader>sp",
				function()
					Snacks.picker.lazy()
				end,
				desc = "Search for Plugin Spec",
			},
			{
				"<leader>sq",
				function()
					Snacks.picker.qflist()
				end,
				desc = "Quickfix List",
			},
			{
				"<leader>sR",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume",
			},
			{
				"<leader>su",
				function()
					Snacks.picker.undo()
				end,
				desc = "Undo History",
			},
			{
				"<leader>uC",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "Colorschemes",
			},
			-- LSP
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gD",
				function()
					Snacks.picker.lsp_declarations()
				end,
				desc = "Goto Declaration",
			},
			{
				"gr",
				function()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"gI",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "LSP Workspace Symbols",
			},
			-- Other
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>cR",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
				mode = { "n", "v" },
			},
			{
				"<c-/>",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<c-_>",
				function()
					Snacks.terminal()
				end,
				desc = "which_key_ignore",
			},
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Reference",
				mode = { "n", "t" },
			},
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev Reference",
				mode = { "n", "t" },
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
				end,
			})
		end,
	},
	{
		"https://github.com/lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.ui.gitsigns")
		end,
	},
	{
		"https://github.com/mason-org/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "williamboman/mason-lspconfig.nvim" },
			"neovim/nvim-lspconfig",
		},
		build = ":MasonUpdate",
		lazy = false,
		config = function()
			require("plugins.editor.mason")
			require("plugins.lsp.mason-lsp")
		end,
		keys = {
			{
				"<leader>li",
				":LspInfo<cr>",
				desc = "LSP Info",
			},
			{
				"<leader>ln",
				":NullLsInfo<cr>",
				desc = "null-ls Info",
			},
		},
	},
	{
		"https://github.com/nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
	},
	{
		"https://github.com/jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lsp.mason-none-ls")
		end,
	},
	{
		"https://github.com/folke/trouble.nvim",
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
		"https://github.com/folke/todo-comments.nvim",
		config = function()
			require("plugins.editor.todo-comments")
		end,
		keys = {
			{
				"<leader>st",
				function()
					Snacks.picker.todo_comments()
				end,
				desc = "Todo",
			},
		},
	},
	{
		"https://github.com/folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			require("plugins.editor.which-key")
		end,
	},
	{ "https://github.com/mfussenegger/nvim-ansible.git" },
	{ "https://github.com/echasnovski/mini.surround", opts = {} },
	{
		"https://github.com/nvim-mini/mini.diff",
		config = function()
			require("plugins.ui.mini-diff")
		end,
	},
	{ "https://github.com/b0o/schemastore.nvim" },
	{
		"https://github.com/Saghen/blink.cmp",
		dependencies = {
			"https://github.com/rafamadriz/friendly-snippets",
			"https://github.com/onsails/lspkind.nvim",
			"https://github.com/Kaiser-Yang/blink-cmp-git",
			"https://github.com/bydlw98/blink-cmp-env",
		},
		build = "cargo build --release",
		config = function()
			require("plugins.editor.blink")
		end,
	},
	{ "https://github.com/romainl/vim-cool" },
	{
		"https://github.com/RRethy/vim-illuminate",
		config = function()
			require("plugins.editor.vim-illuminate")
		end,
	},
	{
		"https://github.com/ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function()
			require("plugins.lsp.lsp-signature")
		end,
	},
	{
		"https://github.com/koppchen/helm-ls.nvim",
		ft = "helm",
		opts = {
			conceal_templates = {
				enabled = false,
			},
		},
	},
	{
		"https://github.com/cenk1cenk2/schema-companion.nvim",
		dependencies = {
			"https://github.com/neovim/nvim-lspconfig",
			"https://github.com/nvim-lua/plenary.nvim",
		},
		config = function()
			require("schema-companion").setup({})
		end,
	},
	{
		"https://github.com/nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.ui.lualine")
		end,
	},
	{
		"https://github.com/mfussenegger/nvim-dap",
		disabled = true,
		config = function()
			require("plugins.editor.dap")
		end,
	},
	{ "https://github.com/vkhitrin/vim-tera" },
	{ "https://github.com/pdurbin/vim-tsv" },
	{
		"https://github.com/MagicDuck/grug-far.nvim",
		config = function()
			require("plugins.editor.grug-far")
		end,
		keys = {
			{
				"<leader>F",
				"<cmd>lua require('grug-far').toggle_instance({ instanceName='far', staticTitle='Find and Replace' })<CR>",
				desc = "Spectre",
			},
		},
	},
	{ "https://github.com/nvim-tree/nvim-web-devicons" },
	{
		"https://github.com/windwp/nvim-ts-autotag",
		config = function()
			require("plugins.editor.nvim-ts-autotag")
		end,
	},
	{
		"https://github.com/MeanderingProgrammer/render-markdown.nvim",
		ft = { "opencode_output", "markdown", "markdown.floating_window" },
		config = function()
			require("plugins.ui.render-markdown")
		end,
	},
	{
		"https://github.com/fladson/vim-kitty",
	},
	{ "https://github.com/projectfluent/fluent.vim" },
	{
		"https://github.com/psliwka/vim-dirtytalk",
		build = ":DirtytalkUpdate",
		config = function()
			vim.opt.spell = true
			vim.opt.spelllang = { "en", "programming" }
		end,
	},
	{
		"https://github.com/Davidyz/VectorCode",
		cmd = "VectorCode",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.editor.vectorcode")
		end,
	},
	{
		"https://github.com/mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
	},
	{
		"https://gitlab.com/HiPhish/jinja.vim",
	},
	{
		"https://github.com/m-pilia/vim-pkgbuild",
	},
	{
		"https://github.com/obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		config = function()
			require("plugins.editor.obsidian")
		end,
	},
	{
		"https://github.com/sudo-tee/opencode.nvim",
		config = function()
			require("plugins.editor.opencode")
		end,
	},
	-- https://github.com/nvim-java/nvim-java/issues/427
	-- {
	--     "https://github.com/nvim-java/nvim-java",
	--     config = function()
	--         require("plugins.editor.java")
	--     end,
	-- },
	{ "https://github.com/Bekaboo/dropbar.nvim", opts = {} },
	{ "https://github.com/chrisgrieser/nvim-justice", ft = "just", opts = {} },
	{ "https://github.com/ngynkvn/gotmpl.nvim", opts = {} },
	{
		"https://github.com/cachebag/nvim-tcss",
		config = true,
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
			loaded = "󰸞",
			not_loaded = "",
		},
	},
}

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)
