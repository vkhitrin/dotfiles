local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local plugins = {
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            require("plugins.ui.catppuccin")
        end,
    },
    {
        {
            "akinsho/bufferline.nvim",
            lazy = false,
            config = function()
                require("plugins.ui.bufferline")
            end,
            keys = {
                {
                    "[1",
                    ":BufferLineGoToBuffer 1<cr>",
                    desc = "Buffer #1",
                },
                {
                    "[2",
                    ":BufferLineGoToBuffer 2<cr>",
                    desc = "Buffer #2",
                },
                {
                    "[3",
                    ":BufferLineGoToBuffer 3<cr>",
                    desc = "Buffer #3",
                },
                {
                    "[4",
                    ":BufferLineGoToBuffer 4<cr>",
                    desc = "Buffer #4",
                },
                {
                    "[5",
                    ":BufferLineGoToBuffer 5<cr>",
                    desc = "Buffer #5",
                },
                {
                    "[6",
                    ":BufferLineGoToBuffer 6<cr>",
                    desc = "Buffer #6",
                },
                {
                    "[6",
                    ":BufferLineGoToBuffer 6<cr>",
                    desc = "Buffer #6",
                },
                {
                    "[7",
                    ":BufferLineGoToBuffer 7<cr>",
                    desc = "Buffer #7",
                },
                {
                    "[8",
                    ":BufferLineGoToBuffer 8<cr>",
                    desc = "Buffer #8",
                },
                {
                    "[9",
                    ":BufferLineGoToBuffer 9<cr>",
                    desc = "Buffer #9",
                },
                {
                    "[0",
                    ":BufferLineGoToBuffer 10<cr>",
                    desc = "Buffer #10",
                },
                {
                    "<F12>",
                    ":CopilotChatToggle<cr>",
                    desc = "Toggle Copilot Chat",
                },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.editor.treesitter")
        end,
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "BurntSushi/ripgrep",
        },
        config = function()
            require("plugins.editor.telescope")
        end,
        keys = {
            {
                "<leader>ff",
                ":lua project_files()<cr>",
                desc = "Files",
            },
            {
                "<leader>fg",
                ":Telescope live_grep<cr>",
                desc = "Grep",
            },
            {
                "<leader>ft",
                ":Telescope file_browser<cr>",
                desc = "File Browser",
            },
            {
                "<leader>fT",
                ":TodoTelescope<cr>",
                desc = "TODO",
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.ui.gitsigns")
        end,
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        build = ":MasonUpdate",
        lazy = false,
        config = function()
            require("plugins.editor.mason")
            require("plugins.lsp.mason-lsp")
            require("plugins.lsp.lsp")
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
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvimtools/none-ls.nvim" },
        config = function()
            require("plugins.lsp.mason-null-ls")
        end,
    },
    {
        "folke/trouble.nvim",
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
    },
    "christoomey/vim-tmux-navigator",
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
    { "echasnovski/mini.pairs",                          event = "InsertEnter", opts = {} },
    { "https://github.com/mfussenegger/nvim-ansible.git" },
    { "echasnovski/mini.surround",                       opts = {} },
    { "b0o/schemastore.nvim" },
    {
        "iguanacucumber/magazine.nvim",
        name = "nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "https://codeberg.org/FelipeLema/cmp-async-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
            "saadparwaiz1/cmp_luasnip",
            "petertriho/cmp-git",
            "davidsierradz/cmp-conventionalcommits",
            -- "lukas-reineke/cmp-rg",
        },
        config = function()
            require("plugins.editor.nvim-cmp")
        end,
    },
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugins.ui.indent-blankline")
        end,
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
        ft = { "yaml" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.ui.lualine")
        end,
    },
    {
        "mfussenegger/nvim-dap",
        disabled = true,
        config = function()
            require("plugins.editor.dap")
        end,
    },
    { "vkhitrin/vim-tera" },
    { "pdurbin/vim-tsv" },
    {
        "nvim-pack/nvim-spectre",
        config = function()
            require("plugins.editor.spectre")
        end,
        keys = {
            {
                "<leader>F",
                "<cmd>lua require('spectre').toggle()<CR>",
                desc = "Spectre",
            },
        },
    },
    {
        "kdheepak/lazygit.nvim",
        config = function()
            require("plugins.ui.lazygit")
        end,
        keys = { { "<leader>fG", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
    },
    { "nvim-tree/nvim-web-devicons" },
    {
        "stevearc/dressing.nvim",
        config = function()
            require("plugins.ui.dressing")
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("plugins.editor.nvim-ts-autotag")
        end,
    },
    -- {
    --     "OXY2DEV/markview.nvim",
    --     ft = { "markdown" },
    --     dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    --     config = function()
    --         require("plugins.ui.markview")
    --     end,
    -- },
    {
        "fladson/vim-kitty",
    },
    {
        "zbirenbaum/copilot.lua",
        event = { "InsertEnter", "LspAttach" },
        dependencies = { "zbirenbaum/copilot-cmp", "AndreM222/copilot-lualine" },
        config = function()
            require("plugins.editor.copilot")
        end,
    },
    { "CopilotC-Nvim/CopilotChat.nvim", opts = {} },
    { "projectfluent/fluent.vim" },
    {
        "psliwka/vim-dirtytalk",
        build = ":DirtytalkUpdate",
        config = function()
            vim.opt.spell = true
            vim.opt.spelllang = { "en", "programming" }
        end,
    },

    -- {
    --     "rachartier/tiny-inline-diagnostic.nvim",
    --     event = "VeryLazy",
    --     priority = 1000,
    --     config = function()
    --         require("plugins.ui.tiny-inline-diagnostics")
    --     end,
    -- },
    -- {
    --     "tris203/precognition.nvim",
    --     event = "VeryLazy",
    --     config = {
    --     }
    -- }
}

local opts = {
    install = {
        colorscheme = { "catppuccin" },
    },
    ui = {
        backdrop = 100,
        border = "none",
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
