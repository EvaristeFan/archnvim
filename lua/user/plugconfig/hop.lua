local keymap = vim.keymap.set
require'hop'.setup {}


-- Hop keymaps {{{
keymap({'o','n','v'}, 'F', "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
keymap({'o','n','v'}, 'T', "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, hint_offset = 1, current_line_only = true })<cr>", {})
keymap({'o','n','v'}, 't', "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_offset = -1, current_line_only = true })<cr>", {})
keymap({'o','n','v'}, 'f', "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
keymap({'o','n','v'}, 'w', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
keymap({'o','n','v'}, 'e', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
keymap({'o','n','v'}, 'b', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
keymap({'o','n','v'}, 'J', "<cmd>lua require'hop'.hint_vertical({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {}) --}}}

-- vim: fdm=marker fdl=0
