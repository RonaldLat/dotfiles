return {
	"vimwiki/vimwiki",
	config = function()
		vim.g.vimwiki_list = {
			{
				path = "~/Documents/Notes/",
				syntax = "markdown",
				ext = "md",
			},
		}
	end,
}
