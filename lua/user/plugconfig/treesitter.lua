vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.fdl = 1

require('nvim-treesitter.configs').setup({
	fold = {
		enable = true,
	},
	highlight = { --{{{
		enable = true,
		disable = { "latex" },
	}, --}}}
	indent = {
		enable = false,
	},
	incremental_selection = { --{{{
		enable = true,
		keymaps = {
			init_selection = "<M-n>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
			scope_incremental = "<M-n>",
		},
	}, --}}}

	textobjects = {
		select = { --{{{
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["am"] = "@call.outer",
				["im"] = "@call.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["as"] = "@statement.outer",
			},
		}, --}}}
		move = { --{{{
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]b"] = "@block.outer",
				["]gc"] = "@comment.outer",
				["]a"] = "@parameter.inner",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]B"] = "@block.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[b"] = "@block.outer",
				["[gc"] = "@comment.outer",
				["[a"] = "@parameter.inner",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[B"] = "@block.outer",
			},
		}, --}}}
		swap = { --{{{
			enable = true,
			swap_next = {
				["<leader>.f"] = "@function.outer",
				["<leader>.e"] = "@element",
			},
			swap_previous = {
				["<leader>,f"] = "@function.outer",
				["<leader>,e"] = "@element",
			},
		},

		lsp_interop = {
			enable = true,
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
			},
		},
	}, --}}}

	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	}
})

-- vim: fdm=marker fdl=0
