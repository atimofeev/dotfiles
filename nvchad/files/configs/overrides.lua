local M = {}

M.treesitter = {
  ensure_installed = {
    -- langs
    "lua",
    "python",
    "go",
    "bash",
    "fish",
    -- devops
    "dockerfile",
    "groovy",
    "hcl",
    "terraform",
    "yaml",
    -- git
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    -- misc
    "json",
    "latex",
    "markdown",
    "markdown_inline",
    "nix",
    "org",
    "toml",
 },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- https://github.com/mason-org/mason-registry/tree/main/packages
    --- LUA ---
    "lua-language-server",
    "stylua",
    --- PYTHON ---
    "pyhton-lsp-server",
    "black", -- formatter
    --- GO ---
    "gopls",
    "goimports",
    --- BASH ---
    "bash-language-server",
    "shfmt",
    "shellcheck",
    --- ANSIBLE ---
    "ansible-language-server",
    "ansible-lint",
    --- DOCKER ---
    "dockerfile-language-server",
    "docker-compose-language-service",
    "hadolint",
    --- TERRAFORM ---
    "terraform-ls",
    "tflint",
    "tfsec", -- security snanner
    --- YAML ---
    "yaml-language-server",
    "yamllint",
    "yamlfmt",
    --"yamlfix", -- formatter
    --- MARKDOWN ---
    "markdown-toc",
    "markdownlint",
    --"markdownlint-cli2",
    --- JSON ---
    "json-lsp",
    "jsonlint",
    --- MISC ---
    "groovy-language-server",
    "helm-ls",
    "nginx-language-server",
    "powershell-editor-services",
    "prettier",
  },
}

-- git support in nvimtree
M.nvimtree = {
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
}

M.gitsigns = {
  current_line_blame = true,
}

return M
