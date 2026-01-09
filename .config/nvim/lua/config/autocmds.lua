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
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown.floating_window",
	callback = function()
		vim.opt_local.number = false
		vim.o.swapfile = false
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
			pattern = "*",
			command = "silent! write",
		})
	end,
})

vim.api.nvim_create_user_command("LspCapabilities", function()
	local curBuf = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = curBuf })

	for _, client in pairs(clients) do
		if client.name ~= "null-ls" then
			local capAsList = {}
			for key, value in pairs(client.server_capabilities) do
				if value and key:find("Provider") then
					local capability = key:gsub("Provider$", "")
					table.insert(capAsList, "- " .. capability)
				end
			end
			table.sort(capAsList)
			local msg = "LSP Server: " .. client.name .. "\n" .. table.concat(capAsList, "\n")
			vim.notify(msg, "trace", {
				on_open = function(win)
					local buf = vim.api.nvim_win_get_buf(win)
					vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
				end,
				timeout = 14000,
			})
			vim.fn.setreg("+", "Capabilities = " .. vim.inspect(client.server_capabilities))
		end
	end
end, {})

local RemoveComments = function()
	local ts = vim.treesitter
	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.bo[bufnr].filetype
	local lang = ts.language.get_lang(ft) or ft

	local ok, parser = pcall(ts.get_parser, bufnr, lang)
	if not ok then
		return vim.notify("No parser for " .. ft, vim.log.levels.WARN)
	end

	local tree = parser:parse()[1]
	local root = tree:root()
	local query = ts.query.parse(lang, "(comment) @comment")

	local ranges = {}
	for _, node in query:iter_captures(root, bufnr, 0, -1) do
		table.insert(ranges, { node:range() })
	end

	table.sort(ranges, function(a, b)
		if a[1] == b[1] then
			return a[2] < b[2]
		end
		return a[1] > b[1]
	end)

	for _, r in ipairs(ranges) do
		vim.api.nvim_buf_set_text(bufnr, r[1], r[2], r[3], r[4], {})
	end
end
vim.api.nvim_create_user_command("RemoveComments", RemoveComments, {})

-- Custom filetype detection
vim.filetype.add({
	extension = {
		gotmpl = "gotmpl",
	},
	pattern = {
		[vim.fn.expand("~") .. "/.kube/.*config"] = "yaml",
		[".*%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
		[".*/.zshrc.d/xx_functions/.*"] = "zsh",
		[".*/templates/.*%.tpl"] = "helm",
		[".*%.gotmpl"] = "helm",
		[".*/templates/.*%.ya?ml"] = "helm",
		["helmfile.*%.ya?ml"] = "helm",
		["Brewfile"] = "ruby",
		[".tmux_floating_note.md"] = "markdown.floating_window",
	},
})
