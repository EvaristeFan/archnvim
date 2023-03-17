return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 200
		require("which-key").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			window = {
				border = "rounded",
				winblend = 0
			},
			icons = {
				separator = ""
			}
		})
		local wk = require("which-key")
		-- As an example, we will create the following mappings:
		--  * <leader>ff find files
		--  * <leader>fr show recent files
		--  * <leader>fb Foobar
		-- we'll document:
		--  * <leader>fn new file
		--  * <leader>fe edit file
		-- and hide <leader>1

		wk.register({
			f = {
				b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
			},
		}, { prefix = "<leader>" })
	end,
}
