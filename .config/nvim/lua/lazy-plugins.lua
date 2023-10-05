local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local plugins = {
    -- theme (alabaster)
    {
        "https://git.sr.ht/~p00f/alabaster.nvim",
        lazy = false,
        config = function()
            vim.cmd([[
      colorscheme alabaster
      highlight BufTabLineFill guibg=#1a2022
      highlight BufTabLineCurrent guibg=#d2322d guifg=#cecece gui=bold
      highlight BufTabLineActive guibg=#1b2022
      highlight BufTabLineHidden guibg=#1b2022
      ]])
        end,
    },
    -- buffer
    {
        "ap/vim-buftabline",
        {
            "nvim-lualine/lualine.nvim",
            event = "VeryLazy",
            config = function()
                require("plugin_config.lualine")
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                require("plugin_config.treesitter")
            end,
        },
        -- telescope
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            config = function()
                require("plugin_config/telescope")
            end,
        },
        "BurntSushi/ripgrep",
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("plugin_config.gitsigns")
            end,
        },
        -- null-ls.nvim is deprecated https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1621
        {
            "jose-elias-alvarez/null-ls.nvim",
            config = function()
                require("plugin_config.mason-null-ls")
            end,
        },
        {
            "folke/trouble.nvim",
            config = function()
                require("plugin_config.trouble")
            end,
        },
        {
            "folke/todo-comments.nvim",
            config = function()
                require("plugin_config.todo-comments")
            end,
        },
        "christoomey/vim-tmux-navigator",
        {
            "williamboman/mason.nvim",
            dependencies = {
                "jose-elias-alvarez/null-ls.nvim",
            },
            build = ":MasonUpdate",
            config = function()
                require("plugin_config.mason")
            end,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("plugin_config.mason-lsp")
            end,
        },
        {
            "neovim/nvim-lspconfig",
            config = function()
                require("plugin_config.lsp")
            end,
        },
        {
            "jay-babu/mason-null-ls.nvim",
            event = { "BufReadPre", "BufNewFile" },
            dependencies = {
                "williamboman/mason.nvim",
                "jose-elias-alvarez/null-ls.nvim",
            },
        },
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            depencdencies = { "williamboman/mason.nvim" },
            config = function()
                require("plugin_config.mason-tool-installer")
            end,
        },
        {
            "goolord/alpha-nvim",
            event = "VimEnter",
            config = function()
                require("plugin_config.alpha")
            end,
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            init = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
            end,
            config = function()
                require("plugin_config.which-key")
            end,
        },
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            opts = {}, -- this is equalent to setup({}) function
        },
        { "https://github.com/mfussenegger/nvim-ansible.git" },
        {
            "numToStr/Comment.nvim",
            config = function()
                require("plugin_config.comment")
            end,
        },
        { "romainl/vim-cool" },
        {
            "b0o/schemastore.nvim",
            config = function()
                require("plugin_config.schemastore")
            end,
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-vsnip",
                "hrsh7th/vim-vsnip",
            },
            config = function()
                require("plugin_config.nvim-cmp")
            end,
        },
    },
}

local opts = {}

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
