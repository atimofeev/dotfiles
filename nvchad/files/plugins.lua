---@type NvPluginSpec[]
local plugins = {

	---- LSP ----

	{ --built-in
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"nvimtools/none-ls.nvim",
				opts = function()
					require("custom.configs.null-ls")
				end,
			},

			"williamboman/mason.nvim",

			{
				"NvChad/nvcommunity",
				{ import = "nvcommunity.lsp.mason-lspconfig" },
				{
					"mason-lspconfig.nvim",
					opts = {
						automatic_installation = true,
						ensure_installed = require("custom.configs.packages").lsp,
					},
				},
			},
		},
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("custom.configs.null-ls")
			require("mason-null-ls").setup({
				automatic_installation = true,
			})
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
				mappings = {
					commit_editor = {
						["q"] = "Close",
						["<M-c>"] = "Submit",
						["<M-k>"] = "Abort",
					},
					popup = {
						["p"] = "PushPopup",
						["P"] = "PullPopup",
					},
				},
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
