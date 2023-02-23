local opts = { noremap = true, silent = true }


-- Shorten function name
local keymap = vim.keymap.set

keymap("n", "<Space>", "<Nop>", { silent = true, remap = false })

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

-- LuaSnip keymaps

