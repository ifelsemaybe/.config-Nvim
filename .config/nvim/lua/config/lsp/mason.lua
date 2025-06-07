local servers = {
    "ts_ls", --typescript
    "jsonls", --json files
    "lua_ls", --lua
    "pyright", --python
    "clangd", --C/C++
    "omnisharp" --C#
}


local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig = require("lspconfig")

local opts = {}
local handlers_pth = "config.lsp.handlers"


for _, server in pairs(servers) do
	opts = {
		on_attach = require(handlers_pth).on_attach,
		capabilities = require(handlers_pth).capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "thefoldername.lsp.settings" .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

require(handlers_pth).setup()
