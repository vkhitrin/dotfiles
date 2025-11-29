vim.loader.enable()

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

-- Load private settings
pcall(require, "settings.private.mac")
