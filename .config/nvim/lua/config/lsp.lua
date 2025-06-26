local lsp = vim.lsp

lsp.config("*", {
	root_markers = { ".git" },
})
lsp.enable({
	"basedpyright",
	"bashls",
	"clangd",
	"lua_ls",
	"ruff",
	-- "marksman",
	-- "ts_ls",
	-- "jsonls",
	-- "yamlls",
})
