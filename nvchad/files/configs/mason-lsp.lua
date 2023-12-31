local M = {}

M.servers = {
	-- langs
	"lua_ls",
	"pylsp",
	"gopls",
	"bashls",
	-- devops
	"ansiblels",
	"dockerls",
	"docker_compose_language_service",
	"terraformls",
	"yamlls",
	-- misc
	"jsonls",
	"groovyls",
	"helm_ls",
	"powershell_es",
}

M.setup = function()
	local present, mason_lspconfig = pcall(require, "mason-lspconfig")
	if not present then
		return
	end
	mason_lspconfig.setup({
		ensure_installed = M.servers,
		automatic_installation = true, -- not the same as ensure_installed
	})
end

return M
