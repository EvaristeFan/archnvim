local opts = { noremap = true, silent = true }

local term_opts = {silent = true }

-- Shorten function name
local keymap = vim.keymap.set

vim.g.mapleader = " "

-- Common keymaps
keymap("n", "S", "<cmd>w<cr>", opts)
keymap("n", "Q", "<cmd>q<cr>", opts)
keymap("n", "<leader>rc", "<cmd>e $MYVIMRC<cr>", opts)
keymap("n", "<leader>w", "<C-w>w", opts)
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
