return {
	"lervag/vimtex",
	config = function()
		vim.g.vimtex_view_method = 'sioyek'
		vim.g.vimtex_complete_enable = 0
		vim.g.vimtex_matchparen_enabled = 0
		vim.g.vimtex_imaps_enabled = 0

		vim.g.vimtex_fold_enabled = 0
		vim.g.vimtex_fold_manual = 1
	end,
}
