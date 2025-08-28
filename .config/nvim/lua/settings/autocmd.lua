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

-- custom treesitter parsers
vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").ghactions = {
			install_info = {
				url = "https://github.com/rmuir/tree-sitter-ghactions",
				queries = "queries",
			},
		}
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
			vim.env.GIT_DIR = vim.fn.expand("~/Projects/Automation/Setup/dotfiles")
			vim.env.GIT_WORK_TREE = vim.fn.expand("~")
		end
	end,
})
