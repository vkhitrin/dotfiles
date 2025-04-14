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
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("plugins.editor.snacks")
        end,
        keys = {
            -- Top Pickers & Explorer
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
            -- find
            {
                "<leader>fb",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
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
                "<leader>sg",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep",
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
                "<leader>gg",
                function()
                    Snacks.lazygit()
                end,
                desc = "Lazygit",
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
    { "echasnovski/mini.diff",                           opts = {} },
    { "b0o/schemastore.nvim" },
    {
        "Saghen/blink.cmp",
        version = "*",
        dependencies = {
            --     "hrsh7th/cmp-nvim-lsp",
            --     "hrsh7th/cmp-buffer",
            --     "https://codeberg.org/FelipeLema/cmp-async-path",
            --     "hrsh7th/cmp-cmdline",
            --     "hrsh7th/cmp-vsnip",
            "rafamadriz/friendly-snippets",
            --     "onsails/lspkind.nvim",
            --     "saadparwaiz1/cmp_luasnip",
            --     "petertriho/cmp-git",
            --     -- "lukas-reineke/cmp-rg",
        },
        config = function()
            require("plugins.editor.blink")
        end,
    },
    -- { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
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
        "https://github.com/cenk1cenk2/schema-companion.nvim",
        ft = { "yaml" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("plugins.editor.schema-companion")
        end,
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
        "MagicDuck/grug-far.nvim",
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
    { "nvim-tree/nvim-web-devicons" },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("plugins.editor.nvim-ts-autotag")
        end,
    },
    {
        "OXY2DEV/markview.nvim",
        ft = { "codecompanion" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.ui.markview")
        end,
    },
    {
        "fladson/vim-kitty",
    },
    {
        "olimorris/codecompanion.nvim",
        event = { "InsertEnter", "LspAttach" },
        config = function()
            require("plugins.editor.codecompanion")
        end,
    },
    { "projectfluent/fluent.vim" },
    {
        "psliwka/vim-dirtytalk",
        build = ":DirtytalkUpdate",
        config = function()
            vim.opt.spell = true
            vim.opt.spelllang = { "en", "programming" }
        end,
    },
    {
        "Davidyz/VectorCode",
        cmd = "VectorCode",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.editor.vectorcode")
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false,
    },
    {
        "https://gitlab.com/HiPhish/jinja.vim",
    },
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
