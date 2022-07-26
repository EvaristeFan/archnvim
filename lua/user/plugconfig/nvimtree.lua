local nvim_tree = require("nvim-tree")
-- Setup {{{
nvim_tree.setup { -- BEGIN_DEFAULT_OPTS
	sync_root_with_cwd = true,
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = {},
	},
} -- }}}

-- vim: fdm=marker fdl=0

