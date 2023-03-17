return {
	"L3MON4D3/LuaSnip",
	config = function()
		local ls = require("luasnip")
		local types = require("luasnip.util.types")

		ls.config.set_config({
			enable_autosnippets = true,
			update_events = "TextChanged,TextchangedI",
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { " ChoiceNode", "TSAAAReference" } },
					},
				},
				[types.insertNode] = {
					active = {
						virt_text = { { " InsertNode", "TSAAAEmphasis" } },
					},
				},
			},
		})


		require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/user/lazy/luasnip/snippets/" })

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
		vim.keymap.set({ 'i', 's' }, "<C-j>",
			'<cmd>lua require("user.lazy.luasnip.utils").dynamic_node_external_update(1)<Cr>',
			{ noremap = true })

		vim.keymap.set({ 'i', 's' }, "<C-k>",
			'<cmd>lua require("user.lazy.luasnip.utils").dynamic_node_external_update(2)<Cr>',
			{ noremap = true })
	end
}
