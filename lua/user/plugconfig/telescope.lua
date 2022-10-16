local keymap = vim.keymap.set
local trouble = require("trouble.providers.telescope")
require('telescope').setup{
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('frecency')
require("telescope").load_extension("ui-select")
require("telescope").load_extension("neoclip")

-- Telescope keymaps {{{
keymap('n', '<leader>o', require('telescope').extensions.frecency.frecency, {noremap = true, silent = true})
keymap('n', '<leader>f', require"telescope.builtin".find_files, {})
keymap('n', '<leader>b', require"telescope.builtin".buffers, {})
-- }}}

-- vim: fdm=marker fdl=0

