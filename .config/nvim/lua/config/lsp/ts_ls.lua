-- return{
--   "compilerOptions": {
--     "module": "commonjs",
--     "target": "es6",
--     "checkJs": false
--   },
--   "exclude": [
--     "node_modules"
--   ]
-- }
--
return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript" },
	root_markers = { "package.json", ".git", "tsconfig.json" },
	-- on_attach = function()
	--   vim.api.nvim_buf_create_user_command(
	--     0,
	--     'MigrateToSvelte5',
	--     migrate_to_svelte_5,
	--     { desc = 'Migrate Component to Svelte 5 Syntax' }
	--   )
	-- end,
}
