local opt = vim.opt

-- show line numbers relative to current line
opt.relativenumber = true

-- apply treesitter lang hcl to terraform-vars files
vim.treesitter.language.register("hcl", "terraform-vars")

-- apply filetype of groovy to Jenkinsfile; enables treesitter highlight
vim.filetype.add {
  filename = {
    ["Jenkinsfile"] = "groovy",
  },
}

-- Cursor scrolling margin
vim.opt.scrolloff = 6
