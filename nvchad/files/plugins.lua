---@type NvPluginSpec[]
local plugins = {

  ---- LSP ----

  { import = "custom.configs.lsp" },

  ---- UI/VISIBILITY ----

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { auto_install = true },
    dependencies = { "nvim-treesitter/playground" },
  },

  { "NvChad/nvcommunity", { import = "nvcommunity.editor.rainbowdelimiters" } },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
      renderer = {
        highlight_git = true,
        icons = { show = { git = true } },
      },
    },
  },

  ---- GIT ----

  { "lewis6991/gitsigns.nvim", opts = { current_line_blame = true } },

  {
    "NeogitOrg/neogit",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = function()
      require("neogit").setup {
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
      }
    end,
  },

  ---- MISC ----

  { -- exit INSERT mode with fast "jk"
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = function()
      require("better_escape").setup()
    end,
  },
}

return plugins
