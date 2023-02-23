return {
	'lewis6991/gitsigns.nvim',
	config = function()
		require('gitsigns').setup(
			{
				current_line_blame = true,
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
