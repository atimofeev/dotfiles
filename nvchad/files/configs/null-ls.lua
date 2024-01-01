local null_ls = require("null-ls")

local b = null_ls.builtins

local sources = {
	b.formatting.prettier.with({ filetypes = { "json", "yaml", "markdown" } }),
	-- Lua
	b.formatting.stylua,
	-- Python
	b.formatting.black,
	-- Go
	b.diagnostics.golangci_lint,
	b.formatting.gofmt,
	b.formatting.golines,
	-- Bash
	b.diagnostics.shellcheck,
	b.formatting.shfmt,
	-- Ansible
	b.diagnostics.ansiblelint,
	-- Docker
	b.diagnostics.hadolint,
	-- Terraform
	b.diagnostics.terraform_validate,
	--b.diagnostics.tflint, -- MANUALLY ADD
	b.diagnostics.tfsec,
	b.formatting.terraform_fmt,
	-- YAML
	b.diagnostics.yamllint,
	--b.formatting.yamlfix, -- TRY OUT: fmt and keep comments
	-- Markdown
	b.diagnostics.markdownlint,
	b.formatting.markdown_toc,
	-- JSON
	b.diagnostics.jsonlint,
}

null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end,
})
