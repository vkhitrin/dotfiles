local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local plugins = {
    --- theme
    {
        "Shatur/neovim-ayu",
        lazy = false,
        config = function()
            vim.cmd([[
          colorscheme ayu-dark]])
            vim.cmd([[
          highlight LineNr guibg=transparent guifg=#545454]])
            vim.cmd([[
          highlight GitSignsCurrentLineBlame guibg=transparent guifg=#545454]])
        end
    }, --- dashboard
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function() require("plugin_config.alpha") end
    }, {
        --- buffer
        {
            "akinsho/bufferline.nvim",
            config = function() require("plugin_config.bufferline") end
        }, --- lualine
        {
            "nvim-lualine/lualine.nvim",
            event = "VeryLazy",
            config = function() require("plugin_config.lualine") end
        }, --- treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            config = function() require("plugin_config.treesitter") end,
            dependencies = {"JoosepAlviste/nvim-ts-context-commentstring"}
        }, --- telescope
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-ui-select.nvim", "BurntSushi/ripgrep"
            },
            config = function() require("plugin_config/telescope") end
        }, --- gitsigns
        {
            "lewis6991/gitsigns.nvim",
            config = function() require("plugin_config.gitsigns") end
        }, --- mason + lsp
        {
            "williamboman/mason.nvim",
            dependencies = {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig"
            },
            build = ":MasonUpdate",
            config = function()
                require("plugin_config.mason")
                require("plugin_config.mason-lsp")
                require("plugin_config.lsp")
            end
        },
        ---- null-ls.nvim is deprecated https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1621
        {
            "jay-babu/mason-null-ls.nvim",
            event = {"BufReadPre", "BufNewFile"},
            dependencies = {"jose-elias-alvarez/null-ls.nvim"}
        }, -- misc
        {
            "folke/trouble.nvim",
            config = function() require("plugin_config.trouble") end
        }, {
            "folke/todo-comments.nvim",
            config = function()
                require("plugin_config.todo-comments")
            end
        }, -- "christoomey/vim-tmux-navigator",
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            init = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
            end,
            config = function() require("plugin_config.which-key") end
        }, {"echasnovski/mini.pairs", event = "InsertEnter", opts = {}},
        {"https://github.com/mfussenegger/nvim-ansible.git"},
        {"echasnovski/mini.surround", opts = {}}, {
            "b0o/schemastore.nvim",
            config = function() require("plugin_config.schemastore") end
        }, --- completion
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-vsnip",
                "rafamadriz/friendly-snippets", "onsails/lspkind.nvim",
                "saadparwaiz1/cmp_luasnip"
            },
            config = function() require("plugin_config.nvim-cmp") end
        }, {"L3MON4D3/LuaSnip", build = "make install_jsregexp"}, --- misc: editor
        {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("plugin_config.indent-blankline")
            end
        }, {
            "echasnovski/mini.comment",
            opts = {
                options = {
                    custom_commentstring = function()
                        return
                            require("ts_context_commentstring.internal").calculate_commentstring() or
                                vim.bo.commentstring
                    end
                }
            }
        }, {"romainl/vim-cool"}, {
            "RRethy/vim-illuminate",
            config = function()
                require("plugin_config.vim-illuminate")
            end
        }
    }
}

local opts = {}

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)
