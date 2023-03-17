return {
	"phaazon/hop.nvim",
	event = "VeryLazy",
	config = function()
		local keymap = vim.keymap.set
		require 'hop'.setup {}

		keymap({ 'o', 'n', 'v' }, 'F',
			function()
				require 'hop'.hint_char2({
					direction = require 'hop.hint'.HintDirection.BEFORE_CURSOR,
					current_line_only = true
				})
			end,
			{})
		keymap({ 'o', 'n', 'v' }, 'T',
			function()
				require 'hop'.hint_char2({
					direction = require 'hop.hint'.HintDirection.BEFORE_CURSOR,
					hint_offset = 1,
					current_line_only = true
				})
			end,
			{})
		keymap({ 'o', 'n', 'v' }, 't',
			function()
				require 'hop'.hint_char2({
					direction = require 'hop.hint'.HintDirection.AFTER_CURSOR,
					hint_offset = -1,
					current_line_only = true
				})
			end,
			{})
		keymap({ 'o', 'n', 'v' }, 'f',
			function()
				require 'hop'.hint_char2({
					direction = require 'hop.hint'.HintDirection.AFTER_CURSOR,
					current_line_only = true
				})
			end,
			{})
		keymap({ 'o', 'n', 'v' }, 'w',
			function()
				require 'hop'.hint_words({
					direction = require 'hop.hint'.HintDirection.AFTER_CURSOR,
					current_line_only = true
				})
			end,
			{})
		keymap({ 'o', 'n', 'v' }, 'e',
			function()
				require 'hop'.hint_words({
					direction = require 'hop.hint'.HintDirection.AFTER_CURSOR,
					current_line_only = true,
					hint_position = require 'hop.hint'.HintPosition.END
				})
			end,
			{})
		keymap({ 'o', 'n', 'v' }, 'b',
			function()
				require 'hop'.hint_words({
					direction = require 'hop.hint'.HintDirection.BEFORE_CURSOR,
					current_line_only = true
				})
			end,
			{})
		keymap({ 'o', 'n', 'v' }, 'J',
			function()
				require 'hop'.hint_vertical({
					direction = require 'hop.hint'.HintDirection.AFTER_CURSOR })
			end,
			{})
	end
}



-- vim: fdm=marker fdl=0
