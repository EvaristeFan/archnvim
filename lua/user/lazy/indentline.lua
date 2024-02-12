-- indent line
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		-- for example, context is off by default, use this to turn it on
		indent = {
			highlight = {
				"IndentBlanklineIndent1",
				"IndentBlanklineIndent2",
				"IndentBlanklineIndent3",
				"IndentBlanklineIndent4",
				"IndentBlanklineIndent5",
				"IndentBlanklineIndent6",
			},
		},
		scope = {
			char = "▏",
			highlight = {
				"IndentBlanklineIndent5",
			},
			include = {
				node_type = { lua = { "return_statement", "table_constructor" } },
			},
		},
	}
}
