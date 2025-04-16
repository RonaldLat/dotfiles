require("options")
require("config.lazy")
require("keymaps")
require("config.lsp")
require("mason").setup()

vim.cmd("colorscheme cyberdream")
vim.lsp.enable({
	-- 'ansible',
	"bash",
	"css",
	"html",
	-- 'json',
	"lua",
	"pyright",
	"svelte",
	-- 'yaml',
})
