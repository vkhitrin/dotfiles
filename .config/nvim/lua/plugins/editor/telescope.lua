require("telescope").setup({
    defaults = {
        file_ignore_patterns = { "^.git/", "^node_modules/" },
        initial_mode = "insert",
        layout_config = {
            horizontal = { width = 0.8, height = 0.95 },
        },
    },
    pickers = {
        find_files = {
            follow = true,
        },
        live_grep = {
            additional_args = { "-L", "--hidden" },
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
        ["file_browser"] = {
            hijack_netrw = true,
            follow_symlinks = true,
            disable_devicons = true,
            hidden = {
                file_browser = true,
                folder_browser = true,
            },
        },
    },
})
require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("yaml_schema")

local utils = require("telescope.utils")
local builtin = require("telescope.builtin")
_G.project_files = function()
    local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
    if ret == 0 then
        builtin.git_files()
    else
        builtin.find_files({ hidden = true, follow = true })
    end
end
