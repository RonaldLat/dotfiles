require("options")
require("config.lazy")
require("keymaps")
require("config.lsp")
require("autocmds")
-- require("mason").setup()
-- require("lspsaga.symbol.winbar").get_bar()

local odools = require("odools")
local h = os.getenv("HOME")
odools.setup({
	-- mandatory
	odoo_path = h .. "/src/odoo/",
	python_path = h .. "/.pyenv/shims/python3",

	-- optional
	server_path = h .. "/.local/share/nvim/odoo/odoo_ls_server",
	addons = { h .. "/src/enterprise/" },
	additional_stubs = { h .. "/src/additional_stubs/", h .. "/src/typeshed/stubs" },
	root_dir = h .. "/src/", -- working directory, odoo_path if empty
	settings = {
		autoRefresh = true,
		autoRefreshDelay = nil,
		diagMissingImportLevel = "none",
	},
})

-- vim.cmd("colorscheme pywal16")
vim.cmd("colorscheme ayu-mirage")
vim.cmd("silent! RenderMarkdown")
-- vim.cmd("colorscheme monokai-pro")
-- vim.lsp.enable({
-- 	-- 'ansible',
-- 	"bash",
-- 	"css",
-- 	"html",
-- 	-- 'json',
-- 	"lua",
-- 	-- "pyright",
-- 	"svelte",
-- 	"tailwindcss-language-server",
-- 	-- "typescript-language-server",
-- 	-- "tailwindcss",
-- 	-- 'yaml',
-- })
