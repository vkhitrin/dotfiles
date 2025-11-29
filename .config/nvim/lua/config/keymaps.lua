vim.keymap.set("n", "ycc", "yygccp", { remap = true })
vim.keymap.set("x", "/", "<Esc>/\\%V")
vim.keymap.set("x", "I", function()
    return vim.fn.mode() == "V" and "^<C-v>I" or "I"
end, { expr = true })
vim.keymap.set("x", "A", function()
    return vim.fn.mode() == "V" and "$<C-v>A" or "A"
end, { expr = true })

vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=gi<C-g>u", { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<C-J>', '<Nop>', { noremap = true, silent = true })
