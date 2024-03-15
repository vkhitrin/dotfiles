require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "awk", "bash", "c", "cmake", "csv", "dockerfile", "go", "graphql",
        "groovy", "hcl", "html", "http", "ini", "java", "javascript", "jq",
        "json", "json5", "jsonc", "lua", "luadoc", "make", "markdown",
        "markdown_inline", "perl", "puppet", "python", "regex", "requirements",
        "ruby", "sql", "swift", "terraform", "toml", "typescript", "vim",
        "vimdoc", "xml", "yaml"
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
    },
    indent = { enable = true },
})