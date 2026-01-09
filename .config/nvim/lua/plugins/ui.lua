return {
	{
		"catppuccin/nvim",
		priority = 1000,
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				background = {
					light = "latte",
					dark = "mocha",
				},
				custom_highlights = function(colors)
					return {
						SnacksPickerMatch = { fg = colors.red },
						BufferLineFill = { bg = colors.mantle, fg = colors.text },
						BufferLineTabSeparator = { bg = colors.mantle, fg = colors.text },
						BufferLineSeparatorVisible = { bg = colors.mantle, fg = colors.text },
						BufferLineSeparatorSelected = { bg = colors.mantle, fg = colors.text },
						Pmenu = {
							bg = colors.mantle,
							fg = colors.overlay2,
						},
						FloatBorder = { fg = colors.rosewater },
						BlinkCmpMenuSelection = { bg = colors.surface0, bold = true },
						BlinkCmpScrollBarGutter = { bg = colors.crust },
						BlinkCmpScrollBarThumb = { bg = colors.surface0 },
						OpencodeBackground = { link = "NormalFloat" },
						BlinkCmpMenuBorder = { link = "FloatBorder" },
						OpencodeBorder = { link = "FloatBorder" },
						OpencodeInputLegend = { link = "FloatShadow" },
						OpencodeAgentBuild = { link = "NormalSB" },
						OpencodeAgentPlan = { bg = colors.pink, fg = colors.mantle },
						OpencodeDiffAdd = { link = "DiffAdd" },
						OpencodeDiffDelete = { link = "DiffDelete" },
					}
				end,
				integrations = {
					blink_cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					grug_far = true,
					mason = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					snacks = { enabled = true, indentscope_color = "" },
					illuminate = {
						enabled = true,
						lsp = false,
					},
					which_key = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						inlay_hints = {
							background = true,
						},
					},
				},
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 300,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> (<abbrev_sha>) - <summary>",
			gh = true,
		},
	},
	{
		"nvim-mini/mini.diff",
		opts = function()
			local diff = require("mini.diff")
			return {
				source = diff.gen_source.none(),
			}
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				override_by_extension = {
					["tcss"] = {
						icon = "󰌜",
						color = "#42a5f5",
						cterm_color = "75",
						name = "Tcss",
					},
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "catppuccin",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_x = {
					"encoding",
					"fileformat",
					"filetype",
					{
						function()
							return ("%s"):format(require("schema-companion").get_current_schemas() or ""):sub(0, 128)
						end,
					},
				},
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "opencode_output", "markdown", "markdown.floating_window" },
		opts = {
			anti_conceal = {
				enabled = true,
			},
			file_types = { "markdown", "opencode_output", "markdown.floating_window" },
			completions = {
				blink = {
					enabled = true,
				},
			},
			sign = { enabled = false },
			heading = {
				icons = { " ", " ", " ", " ", " ", " " },
			},
		},
	},
	{
		"Bekaboo/dropbar.nvim",
		opts = {},
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"fugitive",
					"alpha",
					"toggleterm",
					"lazyterm",
				},
			})
		end,
	},
}
