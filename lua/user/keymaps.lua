local opts = { noremap = true, silent = true }

local term_opts = {silent = true }

-- Shorten function name
local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("n", "S", "<cmd>w<cr>", opts)
keymap("n", "Q", "<cmd>q<cr>", opts)
keymap("n", "<leader>rc", "<cmd>e $MYVIMRC<cr>", opts)
keymap("n", "<c-n>", "<cmd>NvimTreeToggle<cr>", opts)
