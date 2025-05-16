require("options")
require("config.lazy")
require("keymaps")
require("config.lsp")
require("autocmds")
-- require("mason").setup()
-- require("lspsaga.symbol.winbar").get_bar()

vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme monokai-pro")
vim.lsp.enable({
	-- 'ansible',
	"bash",
	"css",
	"html",
	-- 'json',
	"lua",
	"pyright",
	"svelte",
	"tailwindcss-language-server",
	-- "typescript-language-server",
	-- "tailwindcss",
	-- 'yaml',
})
