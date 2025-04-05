local function get_yaml_schema()
    local schema = require("schema-companion.context").get_buffer_schema()
    if schema.name == "none" then
        return ""
    end
    return schema.name
end

local codecompanion = require("lualine.component"):extend()
local vectorcode = require("vectorcode.integrations")

codecompanion.processing = false
codecompanion.spinner_index = 1

local spinner_symbols = {
    "⠋",
    "⠙",
    "⠹",
    "⠸",
    "⠼",
    "⠴",
    "⠦",
    "⠧",
    "⠇",
    "⠏",
}
local spinner_symbols_len = 10

function codecompanion:init(options)
    codecompanion.super.init(self, options)

    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionRequest*",
        group = group,
        callback = function(request)
            if request.match == "CodeCompanionRequestStarted" then
                self.processing = true
            elseif request.match == "CodeCompanionRequestFinished" then
                self.processing = false
            end
        end,
    })
end

function codecompanion:update_status()
    if self.processing then
        self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
        return spinner_symbols[self.spinner_index]
    else
        return nil
    end
end

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_x = {
            codecompanion,
            {
                function()
                    return require("vectorcode.integrations").lualine(opts)[1]()
                end,
                cond = function()
                    if package.loaded["vectorcode"] == nil then
                        return false
                    else
                        return require("vectorcode.integrations").lualine(opts).cond()
                    end
                end,
            },
            "encoding",
            "fileformat",
            "filetype",
            get_yaml_schema,
        },
    },
})
