local ls = require("luasnip")
local types = require("luasnip.util.types")
ls.config.set_config({
	enable_autosnippets = true,
	update_events = "TextChanged,TextchangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "● choiceNode", "LuasnipChoiceNodeActive" } },
			},
		},
		-- [types.insertNode] = {
		-- 	active = {
		-- 		virt_text = { { "●", "" } },
		-- 	},
		-- },
	},
})

-- Keymap for choiceNode {{{
vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
vim.keymap.set({ "i", "s" }, "<C-h>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)
-- }}}

-- Keymap for dynamic_node {{{
vim.api.nvim_set_keymap('i', "<C-t>", '<cmd>lua require("user.plugconfig.luasnip.util").dynamic_node_external_update(1)<Cr>', { noremap = true })
vim.api.nvim_set_keymap('s', "<C-t>", '<cmd>lua require("user.plugconfig.luasnip.util").dynamic_node_external_update(1)<Cr>', { noremap = true })

vim.api.nvim_set_keymap('i', "<C-g>", '<cmd>lua require("user.plugconfig.luasnip.util").dynamic_node_external_update(2)<Cr>', { noremap = true })
vim.api.nvim_set_keymap('s', "<C-g>", '<cmd>lua require("user.plugconfig.luasnip.util").dynamic_node_external_update(2)<Cr>', { noremap = true })
---}}}

-- vim: fdm=marker fdl=0
