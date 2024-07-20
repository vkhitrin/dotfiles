-- local custom_theme = require("lualine.themes.catppuccin-mocha")
-- custom_theme.normal.c.bg = "#1e1e2e"
-- custom_theme.normal.c.bg = "#1e1e2e"
-- custom_theme.inactive.c.bg = "#1e1e2e"
local function get_schema()
    local schema = require("yaml-companion").get_buf_schema(0)
    if schema.result[1].name == "none" then
        return ""
    end
    return schema.result[1].name
end
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "catppuccin-mocha",
        -- theme = custom_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_x = { "copilot", "encoding", "fileformat", "filetype", get_schema },
    },
})
