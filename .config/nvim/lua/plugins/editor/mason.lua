require("mason").setup({
    PATH = "append",
    ui = {
        border = "none",
        height = 0.8,
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})
require("mason-tool-installer").setup({
    ensure_installed = {
        "actionlint",
        "ansible-language-server",
        "bash-language-server",
        "esbonio",
        "gopls",
        "helm-ls",
        "jq",
        "json-lsp",
        "lua-language-server",
        -- "ltex-ls",
        "markdownlint",
        "marksman",
        "mypy",
        "prettier",
        "shellcheck",
        "shfmt",
        "sonarlint-language-server",
        "stylua",
        "taplo",
        "terraform-ls",
        "tflint",
        "tfsec",
        "typescript-language-server",
        "ruff",
        "pyright",
        "yaml-language-server",
        "yamllint",
        "yq",
    },
    auto_update = true,
    run_on_start = true,
})
