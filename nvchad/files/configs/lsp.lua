local setup = function(_, opts)
  local on_attach = require("plugins.configs.lspconfig").on_attach
  local capabilities = require("plugins.configs.lspconfig").capabilities

  local lspconfig = require "lspconfig"

  require("mason").setup(opts)

  require("mason-lspconfig").setup {
    automatic_installation = true,
    ensure_installed = require("custom.configs.packages").lsp,
  }

  -- local cfg = require("yaml-companion").setup {
  --   --overrides
  -- }

  require("mason-lspconfig").setup_handlers {
    -- Default setup for all servers, unless a custom one is defined below
    function(server_name)
      lspconfig[server_name].setup {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- Add your other things here
          -- Example being format on save or something
        end,
        capabilities = capabilities,
      }
    end,
    -- disable auto config for lua_ls to use NvChad conf instead
    ["lua_ls"] = function() end,
    ["yamlls"] = function()
      lspconfig.yamlls.setup { --cfg }
        settings = {
          yaml = {
            -- disable builtin schemastore
            schemaStore = { enable = false, url = "" },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      }
    end,
  }
end

---@type NvPluginSpec
local spec = {
  "neovim/nvim-lspconfig",
  -- BufRead is to make sure if you do nvim some_file then this is still going to be loaded
  event = { "VeryLazy", "BufRead" },
  config = function() end, -- Override to make sure load order is correct
  dependencies = {
    -- {
    --   "someone-stole-my-name/yaml-companion.nvim",
    --   dependencies = {
    --     { "nvim-lua/plenary.nvim" },
    --     { "nvim-telescope/telescope.nvim" },
    --   },
    --   config = function()
    --     require("telescope").load_extension "yaml_schema"
    --   end,
    -- },
    "b0o/schemastore.nvim",
    {
      "williamboman/mason.nvim",
      config = function(plugin, opts)
        setup(plugin, opts)
      end,
    },
    "williamboman/mason-lspconfig",
    {
      "nvimtools/none-ls.nvim",
      dependencies = {
        {
          "jay-babu/mason-null-ls.nvim",
          config = function()
            require "custom.configs.null-ls"
            require("mason-null-ls").setup {
              automatic_installation = true,
            }
          end,
        },
      },
    },

    {
      "NvChad/nvcommunity",
      { import = "nvcommunity.lsp.lsplines" },
      { import = "nvcommunity/diagnostics/trouble" },
    },
  },
}

return spec
