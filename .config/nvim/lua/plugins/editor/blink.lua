local function get_gitlab_config(source_type)
	return {
		get_command = function()
			if vim.fn.getcwd():find("Work/GitLab", 1, true) then
				return "env"
			end
			return require("blink-cmp-git.default.gitlab")[source_type].get_command()
		end,
		get_command_args = function(command, token)
			local original_command = command
			if command == "env" then
				original_command = require("blink-cmp-git.default.gitlab")[source_type].get_command()
			end
			local args = require("blink-cmp-git.default.gitlab")[source_type].get_command_args(original_command, token)
			if vim.fn.getcwd():find("Work/GitLab", 1, true) then
				table.insert(args, 1, original_command)
				table.insert(args, 1, "GLAB_CONFIG_DIR=/Users/vkhitrin/.config/glab-cli/work")
			end
			return args
		end,
	}
end

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<Tab>"] = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.accept()
				else
					return cmp.select_and_accept()
				end
			end,
			"snippet_forward",
			"fallback",
		},
		["<S-Tab>"] = { "snippet_backward", "fallback" },
		-- ["<Up>"] = { "select_prev", "fallback" },
		-- ["<Down>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
		-- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
	},
	completion = {
		documentation = { auto_show = true },
		trigger = { prefetch_on_insert = false },
		menu = {
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "source_name" },
				},
			},
		},
	},
	sources = {
		default = { "lsp", "path", "buffer", "snippets", "git", "env" },
		providers = {
			git = {
				module = "blink-cmp-git",
				name = "Git",
				opts = {
					git_centers = {
						gitlab = {
							pull_request = get_gitlab_config("pull_request"),
							issue = get_gitlab_config("issue"),
							mention = get_gitlab_config("mention"),
						},
					},
				},
			},
			env = {
				name = "Env",
				module = "blink-cmp-env",
				opts = {
					item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
					show_braces = true,
					show_documentation_window = true,
				},
			},
			snippets = {
				should_show_items = function(ctx)
					return ctx.trigger.initial_kind ~= "trigger_character"
				end,
			},
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
})
