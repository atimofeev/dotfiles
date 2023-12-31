---@type NvPluginSpec[]
local plugins = {

	---- LSP ----

	{ --built-in
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		opts = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = function()
			require("custom.configs.mason-lsp")
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		opts = function()
			return require("custom.configs.null-ls")
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("custom.configs.null-ls")
		end,
	},

	---- UI ----

	{ --built-in
		"nvim-treesitter/nvim-treesitter",
		opts = {
			auto_install = true,
		},
	},

	{ --built-in
		"nvim-tree/nvim-tree.lua",
		opts = {
			git = {
				enable = true,
			},
			renderer = {
				highlight_git = true,
				icons = {
					show = {
						git = true,
					},
				},
			},
		},
	},

	{
		"NvChad/nvcommunity",
		{ import = "nvcommunity.editor.rainbowdelimiters" },
	},

	---- GIT ----

	{ --built-in
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
		},
	},

	{
		"NeogitOrg/neogit",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			require("neogit").setup({
				disable_hint = true,
				disable_signs = true,
			})
		end,
	},

	---- MISC ----

	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
}

return plugins
