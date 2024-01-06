---@type NvPluginSpec[]
local plugins = {

  ---- LSP ----

  { import = "custom.configs.lsp" },

  ---- UI/VISIBILITY ----

  { --built-in
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
    },
  },

  {
    "NvChad/nvcommunity",
    { import = "nvcommunity.editor.rainbowdelimiters" },
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
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
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
    config = function()
      require("better_escape").setup()
    end,
  },
}

return plugins
