local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- format
-- Fast saving

-- Exit on jj and jk
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Exit on jj and jk
map("i", "jj", "<ESC>", opts)
map("i", "jk", "<ESC>", opts)
map("i", "kj", "<ESC>", opts)

map("n", ";", ":", opts)

-- map("n", "<leader>s", ":source %<CR>", opts)
-- Remove search highlight
-- map("n", "<leader>c", "<cmd>nohlsearch<CR>", opts)
-- Reload configuration without restart nvim
-- map("n", "<leader>r", ":so %<CR>", opts)

-- Fast saving with <leader> and s
map("n", "<leader>w", ":w<CR>", opts)

-- Grab text between curly braces
map("n", "YY", "va{Vy", opts)


-- Better split switching
-- map("n", "<C-h>", "<C-w>h", opts)
-- map("n", "<C-j>", "<C-w>j", opts)
-- map("n", "<C-k>", "<C-w>k", opts)
-- map("n", "<C-l>", "<C-w>l", opts)



-- barbar mappings

-- Move to previous/next
map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<Tab>", "<Cmd>BufferNext<CR>", opts)
-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
-- Close buffer
map("n", "<leader>x", "<Cmd>BufferClose<CR>", opts)
map("n", "<leader>xa", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--xx                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map("n", "<leader>bp", "<Cmd>BufferPick<CR>", opts)
-- Sort automatically by...
-- map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map("n", "<leader>bon", "<Cmd>BufferOrderByBufferName<CR>", opts)
map("n", "<leader>bod", "<Cmd>BufferOrderByDirectory<CR>", opts)
map("n", "<leader>bol", "<Cmd>BufferOrderByLanguage<CR>", opts)
-- map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

---- NvimTree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)    -- open/close
map("n", "<leader>ec", ":NvimTreeCollapse<CR>", opts) -- open/close


-- Monorepo navigation
-- map("n", "<leader>p", "<Cmd>CdProject<CR>", opts)
-- map("n", "<leader>pa", "<Cmd>CdProjectAdd<CR>", opts)
-- map("n", "<leader>pd", "<Cmd>CdProjectDelete<CR>", opts)
-- map("n", "<leader>pt", "<Cmd>CdProjectBack<CR>", opts)
--
