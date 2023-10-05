require("mason-tool-installer").setup({
    ensure_installed = {
        "ansible-language-server",
        "ansible-lint",
        "autopep8",
        "bash-language-server",
        "black",
        "esbonio",
        "flake8",
        "glow",
        "golangci-lint-langserver",
        "gopls",
        "groovy-language-server",
        "jq",
        "json-lsp",
        "lua-language-server",
        "markdownlint",
        "prettier",
        "shellcheck",
        "sonarlint-language-server",
        "stylua",
        "terraform-ls",
        "tflint",
        "tfsec",
        "typescript-language-server",
        "yaml-language-server",
        "yamllint",
        "yq",
    },
    -- if set to true this will check each tool for updates. If updates
    -- are available the tool will be updated. This setting does not
    -- affect :MasonToolsUpdate or :MasonToolsInstall.
    auto_update = false,
    -- automatically install / update on startup. If set to false nothing
    -- will happen on startup. You can use :MasonToolsInstall or
    -- :MasonToolsUpdate to install tools and check for updates.
    run_on_start = true,
})
