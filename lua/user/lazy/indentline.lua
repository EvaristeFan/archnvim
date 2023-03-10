-- indent line
return {
	"lukas-reineke/indent-blankline.nvim",
	opts = {
		-- for example, context is off by default, use this to turn it on
		show_current_context = true,
		use_treesitter = true,
		char_highlight_list = {
			"IndentBlanklineIndent1",
			"IndentBlanklineIndent2",
			"IndentBlanklineIndent3",
			"IndentBlanklineIndent4",
			"IndentBlanklineIndent5",
			"IndentBlanklineIndent6",
		},
		filetype_exclude = {
			"tex",
			"lspinfo",
			"checkhealth",
			"help",
			"man",
			"gitcommit",
			"lazy",
			"null-ls-info",
			"",
		}
	}
}
