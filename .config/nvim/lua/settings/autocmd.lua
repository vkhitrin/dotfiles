vim.api.nvim_create_autocmd("TermOpen", {
	desc = "nvim builtin terminal tweaks",
	callback = function()
		vim.opt_local.number = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf", "help", "grug-far" },
	desc = "Quick closing of quickfix, help windows, and grug-far",
	callback = function()
		vim.keymap.set("n", "q", "<cmd>bd<cr>", { silent = true, buffer = true })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }
		-- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gE", function()
			vim.diagnostic.open_float({ focusable = true })
		end, { desc = "Expand an Error into a float" })
		vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})

-- vectorcode
-- TODO: See how it can be integrated with opencode
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function()
--     local bufpath = vim.api.nvim_buf_get_name(0)
--     local root = vim.fs.dirname(bufpath)
--     local vc_dir = vim.fs.find(".vectorcode", { path = root, upward = true })[1]
--
--     if not vc_dir then
--       return
--     end
--
--     local bufnr = vim.api.nvim_get_current_buf()
--     local cacher = require("vectorcode.config").get_cacher_backend()
--     local utils = require("vectorcode.cacher").utils
--
--     utils.async_check("config", function()
--       cacher.register_buffer(bufnr, {
--         n_query = 10,
--       })
--     end, nil)
--   end,
--   desc = "Register buffer for VectorCode if `.vectorcode` exists",
-- })

-- Custom support for 'dotfiles' alias-like behavior
-- TODO: Update various plugin to look for the git dir
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local cwd = vim.fn.getcwd()
		local home = vim.fn.expand("~")
		local config = home .. "/.config"

		if cwd == home or cwd == config or cwd:find(config .. "/", 1, true) == 1 then
			vim.env.GIT_DIR = vim.fn.expand("~/Projects/Personal/Automation/Setup/dotfiles")
			vim.env.GIT_WORK_TREE = vim.fn.expand("~")
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local filetype = ev.match
		local lang = vim.treesitter.language.get_lang(filetype)
		if vim.treesitter.language.add(lang) then
			if vim.treesitter.query.get(filetype, "indents") then
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
			if vim.treesitter.query.get(filetype, "folds") then
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			end
			vim.treesitter.start()
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").ghactions = {
			install_info = {
				url = "https://github.com/rmuir/tree-sitter-ghactions",
				queries = "queries",
			},
		}
		require("nvim-treesitter.parsers").zsh = {
			install_info = {
				url = "https://github.com/georgeharker/tree-sitter-zsh",
				generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
				queries = "nvim-queries", -- also install queries from given directory
			},
			tier = 3,
		}
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown.floating_window",
	callback = function()
		vim.opt_local.number = false
		vim.o.swapfile = false
		vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
			pattern = "*",
			command = "silent! write",
		})
	end,
})
