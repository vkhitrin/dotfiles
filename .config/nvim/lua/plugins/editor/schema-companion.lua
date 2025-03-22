require("schema-companion").setup({
    enable_telescope = false,
    matchers = {
        require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
        require("schema-companion.matchers.cloud-init").setup({ version = "master" }),
    },
})
