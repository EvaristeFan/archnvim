return {
	"lervag/vimtex",
	config = function()
		vim.g.vimtex_view_method = 'sioyek'
		vim.g.vimtex_view_sioyek_exe = 'sioyek.exe'
		vim.g.vimtex_callback_progpath = 'wsl nvim'
		vim.g.vimtex_complete_enable = 0
		vim.g.vimtex_matchparen_enabled = 0
		vim.g.vimtex_imaps_enabled = 0

		vim.g.vimtex_fold_enabled = 0
		vim.g.vimtex_fold_manual = 1
	end,
}
