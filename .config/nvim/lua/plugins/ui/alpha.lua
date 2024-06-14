local if_nil = vim.F.if_nil
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local nvim_version = vim.version()

local leader = "SPC"
local strdisplaywidth = vim.fn.strdisplaywidth
local concat = table.concat
local str_rep = string.rep
local list_extend = vim.list_extend

local function spaces(n)
    return str_rep(" ", n)
end

local cursor_jumps = {}
local cursor_jumps_press = {}

--- overwrite method
--- WARN: This is a mess, it breaks the behavior of alpha cursor positioning.
---       Should be refactored.
function alpha.layout_element.button(el, conf, state)
    local val = {}
    local hl = {}
    local padding = {
        left = 0,
        center = 0,
        right = 0,
    }
    local opts = vim.tbl_get(el, "opts") or {}
    local shortcut = vim.tbl_get(opts, "shortcut")
    local width = vim.tbl_get(opts, "width")
    if shortcut then
        if width then
            local max_width = math.min(width, state.win_width)
            local shortcut_padding = max_width - (strdisplaywidth(el.val) + strdisplaywidth(shortcut))
            if opts.align_shortcut == "right" then
                padding.center = shortcut_padding
            else
                padding.right = shortcut_padding
            end
        end
        if opts.align_shortcut == "right" then
            val = { "│ " .. concat({ el.val, spaces(padding.center), opts.shortcut }) .. " │" }
        else
            val = { concat({ opts.shortcut, el.val, spaces(padding.right) }) }
        end
    else
        val = { el.val }
    end

    -- margin
    if vim.tbl_get(conf, "opts", "margin") and (vim.tbl_get(opts, "position") ~= "center") then
        local left
        val, left = alpha.pad_margin(val, state, conf.opts.margin, if_nil(vim.tbl_get(opts, "shrink_margin"), true))
        if vim.tbl_get(opts, "align_shortcut") == "right" then
            padding.center = padding.center + left
        else
            padding.left = padding.left + left
        end
    end

    -- center
    if vim.tbl_get(el, "opts", "position") == "center" then
        local left
        val, left = alpha.align_center(val, state)
        if el.opts.align_shortcut == "right" then
            padding.center = padding.center + left
        end
        padding.left = padding.left + left
    end

    local row = state.line + 1
    local col = ((el.opts and el.opts.cursor) or 0) + padding.left
    cursor_jumps[#cursor_jumps + 1] = { row, col }
    cursor_jumps_press[#cursor_jumps_press + 1] = el.on_press
    if el.opts and el.opts.hl_shortcut then
        if type(el.opts.hl_shortcut) == "string" then
            hl = { { el.opts.hl_shortcut, 0, #el.opts.shortcut + 1 } }
        else
            hl = el.opts.hl_shortcut
        end
        if el.opts.align_shortcut == "right" then
            hl = alpha.highlight(state, state.line, hl, #el.val + math.max(0, padding.center + 3), el)
        else
            hl = alpha.highlight(state, state.line, hl, padding.left, el)
        end
    end

    if el.opts and el.opts.hl then
        local left = padding.left
        if el.opts.align_shortcut == "left" then
            left = left + #el.opts.shortcut
        end
        list_extend(hl, alpha.highlight(state, state.line, el.opts.hl, left, el))
    end
    state.line = state.line + 1
    return val, hl
end

local function custom_button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 3,
        width = 69,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
        -- hl_shortcut = "CurSearch",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

dashboard.section.header.val = {
    [[╭───────────────────────────────────────────────────────────────────────╮]],
    [[│                                                                       │]],
    [[│       ████ ██████           █████      ██                     │]],
    [[│      ███████████             █████                             │]],
    [[│      █████████ ███████████████████ ███   ███████████   │]],
    [[│     █████████  ███    █████████████ █████ ██████████████   │]],
    [[│    █████████ ██████████ █████████ █████ █████ ████ █████   │]],
    [[│  ███████████ ███    ███ █████████ █████ █████ ████ █████  │]],
    [[│ ██████  █████████████████████ ████ █████ █████ ████ ██████ │]],
    "│                                                                "
    .. nvim_version.major
    .. "."
    .. nvim_version.minor
    .. "."
    .. nvim_version.patch
    .. " │",
    [[├───────────────────────────────────────────────────────────────────────┤]],
}
dashboard.section.header.opts = {
    position = "center",
    hl = "Bold",
}

dashboard.section.buttons.val = {
    {
        type = "text",
        val = "│                                                                       │",
        opts = { position = "center" },
    },
    custom_button("n", " New File", ":ene <BAR> startinsert <CR>"),
    custom_button("l", "󱧕 Lazy", ":Lazy <CR>"),
    custom_button("m", " Mason", ":Mason <CR>"),
    custom_button("q", "󰈆 Quit", ":qall!<CR>"),
    {
        type = "text",
        val = "│                                                                       │",
        opts = { position = "center" },
    },
    {
        type = "text",
        val = "├───────────────────────────────────────────────────────────────────────┤",
        opts = { position = "center" },
    },
}
dashboard.section.buttons.opts = {
    spacing = 0,
}
dashboard.section.footer.val = {}
dashboard.section.footer.opts = {
    hl = "normal",
    position = "center",
}

-- Send config to alpha
-- alpha.setup(dashboard.opts)
alpha.setup({
    layout = {
        -- { type = "padding", val = 2 },
        dashboard.section.header,
        dashboard.section.buttons,
        dashboard.section.footer,
    },
})

-- Disable folding on alpha buffer
vim.api.nvim_create_autocmd("User", {
    callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100) / 100
        dashboard.section.footer.val = {
            [[│                                                                       │]],
            "│ Lazy-loaded " .. stats.loaded .. " plugins in " .. ms .. "ms                                    │",
            [[│                                                                       │]],
            [[╰───────────────────────────────────────────────────────────────────────╯]],
        }
        pcall(vim.cmd.AlphaRedraw)
    end,
})

vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
