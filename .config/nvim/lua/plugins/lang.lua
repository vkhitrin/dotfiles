return {
	{
		"mfussenegger/nvim-ansible",
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		init = function()
			vim.g.rustaceanvim = {
				ra_multiplex = {
					enable = "true",
				},
			}
		end,
	},
	{
		"nvim-java/nvim-java",
		config = function()
			require("java").setup()
		end,
	},
	{
		"vkhitrin/vim-tera",
	},
	{
		"pdurbin/vim-tsv",
	},
	{
		"fladson/vim-kitty",
	},
	{
		"projectfluent/fluent.vim",
	},
	{
		"psliwka/vim-dirtytalk",
		build = ":DirtytalkUpdate",
		config = function()
			vim.opt.spell = true
			vim.opt.spelllang = { "en", "programming" }
		end,
	},
	{
		"HiPhish/jinja.vim",
	},
	{
		"m-pilia/vim-pkgbuild",
	},
	{
		"chrisgrieser/nvim-justice",
		ft = "just",
		opts = {},
	},
	{
		"ngynkvn/gotmpl.nvim",
		opts = {},
	},
	{ "cachebag/nvim-tcss", opts = {} },
}
