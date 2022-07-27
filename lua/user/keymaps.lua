local opts = { noremap = true, silent = true }


-- Shorten function name
local keymap = vim.keymap.set

vim.g.mapleader = " "
vim.g.neovide_transparency = 0.8

-- Common keymaps
keymap("n", "S", "<cmd>w<cr>", opts)
keymap("n", "Q", "<cmd>q<cr>", opts)
keymap("n", "<leader>rc", "<cmd>e $MYVIMRC<cr>", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- Toggle nvim tree
keymap("n", "<c-n>", "<cmd>NvimTreeToggle<cr>", opts)

-- Telescope keymaps
keymap('n', '<leader>o', "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", {noremap = true, silent = true})
keymap('n', '<leader>f', '<cmd>lua require"telescope.builtin".find_files()<cr>', {})
keymap('n', '<leader>b', '<cmd>lua require"telescope.builtin".buffers()<cr>', {})

-- Hop keymaps
keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
keymap('', 'w', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
keymap('', 'e', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
keymap('', 'b', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
keymap('', 'J', "<cmd>lua require'hop'.hint_lines({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {})

-- LuaSnip keymaps

