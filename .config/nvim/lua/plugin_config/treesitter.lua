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
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true
    },
    indent = { enable = true },
    context_commentstring = { enable = true }
})
