---@type NvPluginSpec[]
local plugins = {

  ---- LSP ----

  { import = "custom.configs.lsp" },

  ---- UI/VISIBILITY ----

  -- { "nvim-treesitter/nvim-treesitter", opts = { auto_install = true } },
  {
    "luckasRanarison/tree-sitter-hyprlang",
    event = "BufRead",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        opts = {
          auto_install = true,
          ignore_install = { "markdown" },
        },
      },
    },
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

  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
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

  ---- MISC ---

  { -- exit INSERT mode with fast "jk"
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = function()
      require("better_escape").setup()
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup {
        --manual_mode = true,
        patterns = { ".git" },
        ignore_lsp = { "null-ls" },
      }
      require("nvim-tree").setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      }
      require("telescope").load_extension "projects"
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/repos/vaults/personal/",
        },
        {
          name = "work",
          path = "~/repos/vaults/work/",
        },
      },
    },
  },
}

return plugins
