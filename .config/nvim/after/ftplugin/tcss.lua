vim.bo.commentstring = "/* %s */"

vim.treesitter.stop()

vim.api.nvim_create_autocmd("LspAttach", {
	buffer = 0,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "cssls" then
			vim.lsp.buf_attach_client(0, client.id)
		end
	end,
})
