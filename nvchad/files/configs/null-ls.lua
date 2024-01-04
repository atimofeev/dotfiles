local null_ls = require "null-ls"

local b = null_ls.builtins

local config_path = vim.fn.expand "~/.config/nvim/lua/custom/configs/lint-fmt/"

-- Builtin sources list: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
local sources = {
  b.formatting.prettier.with { filetypes = { "json", "markdown" } },
  -- Lua
  b.formatting.stylua.with {
    extra_args = { "--config-path", config_path .. ".stylua.toml" },
  },
  -- Python
  b.formatting.black,
  b.diagnostics.mypy,
  b.diagnostics.ruff,
  -- Go
  b.diagnostics.golangci_lint,
  b.formatting.gofumpt,
  b.formatting.golines,
  -- shell
  b.diagnostics.shellcheck,
  b.formatting.shfmt,
  b.diagnostics.fish,
  b.formatting.fish_indent,
  -- Docker
  b.diagnostics.hadolint,
  -- Terraform
  --b.diagnostics.tflint, -- ADD TO NULL-LS
  b.diagnostics.terraform_validate,
  b.diagnostics.tfsec,
  b.formatting.terraform_fmt,
  -- YAML
  b.diagnostics.actionlint.with { filetypes = { "yaml.gh_actions" } },
  b.diagnostics.ansiblelint,
  b.diagnostics.yamllint,
  --b.formatting.yamlfmt,
  b.formatting.yamlfix.with {
    env = {
      YAMLFIX_COMMENTS_MIN_SPACES_FROM_CONTENT = "2",
    },
  },
  -- Markdown
  b.diagnostics.markdownlint.with {
    extra_args = { "--config", config_path .. ".markdownlint.yaml" },
  },
  -- JSON
  b.diagnostics.jsonlint,
  b.formatting.fixjson,
}

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
}
