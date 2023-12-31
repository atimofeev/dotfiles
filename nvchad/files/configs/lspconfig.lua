local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = require("custom.configs.mason-lsp").servers

for _, lsp in ipairs(servers) do
  local opt = {
    on_attach = on_attach,
    capabilities = capabilities
  }
  --[[if lsp == "emmet_ls" then
    opt["filetypes"] = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" }
  end]]
  lspconfig[lsp].setup(opt)
end
