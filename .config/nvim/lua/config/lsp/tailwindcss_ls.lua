return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = { "html", "svelte", "tsx", "ts" },
	root_markers = { "package.json", ".git" },
	settings = {},
	-- init_options = {
	--   provideFormatter = true,
	--   embeddedLanguages = { css = true, javascript = true },
	--   configurationSection = { 'html', 'css', 'javascript' },
	-- },
}
