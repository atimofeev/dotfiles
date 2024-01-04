local opt = vim.opt

-- show line numbers relative to current line
opt.relativenumber = true

-- apply treesitter lang hcl to terraform-vars files
vim.treesitter.language.register("hcl", "terraform-vars")

vim.filetype.add {
  filename = {
    ["Jenkinsfile"] = "groovy",
    ["playbook.yaml"] = "yaml.ansible",
    ["playbook.yml"] = "yaml.ansible",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["docker-compose.yml"] = "yaml.docker-compose",
  },
  pattern = {
    [".*/playbooks/.*%.yaml"] = "yaml.ansible",
    [".*/playbooks/.*%.yml"] = "yaml.ansible",
    [".*/roles/.*%.yaml"] = "yaml.ansible",
    [".*/roles/.*%.yml"] = "yaml.ansible",
    [".*/.github/workflows/.*%.yaml"] = "yaml.gh_actions",
    [".*/.github/workflows/.*%.yml"] = "yaml.gh_actions",
  },
}

-- Cursor scrolling margin
vim.opt.scrolloff = 6
