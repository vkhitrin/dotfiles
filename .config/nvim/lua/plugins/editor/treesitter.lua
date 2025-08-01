require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "awk",
        "bash",
        "c",
        "cmake",
        "comment",
        "csv",
        "diff",
        "dockerfile",
        "go",
        "graphql",
        "groovy",
        "hcl",
        "html",
        "http",
        "ini",
        "java",
        "javascript",
        "jinja",
        "jq",
        "json",
        "json5",
        "jsonc",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "perl",
        "python",
        "regex",
        "requirements",
        "rst",
        "ruby",
        "sql",
        "swift",
        "terraform",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
})

require("ts_context_commentstring").setup({})
local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
    return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
end
