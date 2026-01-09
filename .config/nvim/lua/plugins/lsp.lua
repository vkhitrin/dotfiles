return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = {
					exclude = {
						"rust_analyzer",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		cmd = "Mason",
		build = ":MasonUpdate",
		keys = {
			{ "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP Info" },
			{ "<leader>ln", "<cmd>NullLsInfo<cr>", desc = "null-ls Info" },
		},
		config = function()
			require("mason").setup({
				PATH = "append",
				ui = {
					border = "rounded",
					backdrop = 100,
					height = 0.8,
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				registries = {
					"github:mason-org/mason-registry",
					"github:vkhitrin/mason-registry@2025-10-25-second-silk",
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"actionlint",
					"ansible-language-server",
					"ast-grep",
					"autotools-language-server",
					"bash-language-server",
					"codelldb",
					"css-lsp",
					"esbonio",
					"gitlab-ci-ls",
					"gopls",
					"harper-ls",
					"helm-ls",
					"jdtls",
					"jq",
					"json-lsp",
					"just-lsp",
					"kube-linter",
					"lemminx",
					"lua-language-server",
					"mbake",
					"nginx-config-formatter",
					"nginx-language-server",
					"prettier",
					"ruby-lsp",
					"rubyfmt",
					"ruff",
					"rumdl",
					"rust-analyzer",
					"shellcheck",
					"shfmt",
					"sonarlint-language-server",
					"sqruff",
					"stylua",
					"taplo",
					"terraform-ls",
					"tflint",
					"tfsec",
					"trivy",
					"ty",
					"typescript-language-server",
					"typos",
					"typos-lsp",
					"vscode-spring-boot-tools",
					"xmlformatter",
					"yaml-language-server",
					"yamllint",
					"yq",
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					require("none-ls.formatting.mbake"),
				},
			})
			return {
				handlers = {
					yamllint = function(source_name, methods)
						null_ls.builtins.diagnostics.yamllint.with({
							extra_args = {
								"-d",
								"{extends: default, rules: {empty-lines: disable, line-length: disable}}",
							},
						})
					end,
					function(source_name, methods)
						require("mason-null-ls").default_setup(source_name, methods)
					end,
				},
			}
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {
			indent_lines = false,
		},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			fixed_pos = true,
			handler_opts = {
				border = "none",
			},
			hint_enable = false,
		},
	},
	{
		"koppchen/helm-ls.nvim",
		ft = "helm",
		opts = {
			conceal_templates = {
				enabled = false,
			},
		},
	},
	{
		"cenk1cenk2/schema-companion.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
		opts = {},
		ft = {
			"yaml",
			"helm",
			"yaml.compose",
			"yaml.gitlab-ci",
			"json",
			"json5",
			"jsonc",
			"toml",
		},
	},
	{
		"b0o/schemastore.nvim",
	},
}
