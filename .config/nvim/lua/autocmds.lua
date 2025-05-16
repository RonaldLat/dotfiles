-- Function to save the current buffer
local function autosave_markdown()
	if vim.bo.filetype == "markdown" then
		vim.cmd("silent w") -- 'silent' prevents the "written" message
	end
end

-- Set the autosave interval (in milliseconds)
local autosave_interval = 5000 -- Save every 5 seconds

-- Create an autocmd that triggers the autosave function periodically
vim.api.nvim_create_autocmd("CursorHold", {
	-- * /this autocmd applies to all buffers
	pattern = "*",
	callback = function()
		vim.defer_fn(autosave_markdown, autosave_interval)
	end,
})
