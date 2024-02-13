return {
	'lewis6991/gitsigns.nvim',
	config = function()
		require('gitsigns').setup(
			{
				show_deleted = true,
				word_diff = true,
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
					delay = 500,
					ignore_whitespace = false,
				},
				preview_config = {
					-- Options passed to nvim_open_win
					border = 'rounded',
					style = 'minimal',
					relative = 'cursor',
					row = 0,
					col = 1
				},
				current_line_blame_formatter = ' <author>, <author_time:%Y-%m-%d> - <summary>',
			})
	end
}
