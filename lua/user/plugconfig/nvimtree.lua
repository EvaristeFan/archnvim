local nvim_tree = require("nvim-tree")
nvim_tree.setup { -- BEGIN_DEFAULT_OPTS
	sync_root_with_cwd = true,
	actions = { --{{{
		open_file = {
			quit_on_open = true,
		},
	}, --}}}
} -- END_DEFAULT_OPTS
