require("telescope").setup({
    defaults = { file_ignore_patterns = {'^.git/', '^node_modules/'} },
    pickers = {
        find_files = {
            follow = true,
        },
        live_grep = {
            additional_args = { "-L", "--hidden" },
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
        }
    }
})
require("telescope").load_extension("ui-select")
