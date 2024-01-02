-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
local opt = vim.opt

opt.relativenumber = true

vim.treesitter.language.register("hcl", "terraform-vars")

vim.filetype.add({
	filename = {
		["Jenkinsfile"] = "groovy",
	},
})

-- Cursor scrolling margin
vim.opt.scrolloff = 6
