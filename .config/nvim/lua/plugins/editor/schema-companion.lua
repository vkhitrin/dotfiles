require("schema-companion").setup({
    enable_telescope = false,
    matchers = {
        require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
        require("schema-companion.matchers.cloud-init").setup({ version = "master" }),
    },
})
-- Workaround https://github.com/cenk1cenk2/schema-companion.nvim/issues/6#issuecomment-3077464638
vim.keymap.set("n", "<leader>ya", function()
    local schemas = require("schema-companion.schema").all()
    if not schemas or #schemas == 0 then
        return
    end
    vim.ui.select(schemas, {
        prompt = "Select Available Schema",
        format_item = function(item)
            return item.name or item.uri or "<unnamed>"
        end,
    }, function(choice)
        if choice then
            require("schema-companion.context").schema(vim.api.nvim_get_current_buf(), {
                name = choice.name or choice.uri,
                uri = choice.uri,
            })
        end
    end)
end, { desc = "Select Schema" })
