-- vim.api.nvim_set_hl(0, "NullLsInfoBorder", { link = "FloatBorder" })
local null_ls = require("null-ls")
null_ls.setup({
    border = "none",
    -- debug = true,
})
require("mason-null-ls").setup({
    handlers = {
        function(source_name, methods)
            require("mason-null-ls").default_setup(source_name, methods)
        end,
    },
})
