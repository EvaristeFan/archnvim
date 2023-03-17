-- Nvim-surround
return {
	"kylechui/nvim-surround",
	config = function()
		local surround_config1 = require("nvim-surround.config")
		require("nvim-surround").setup({
			surrounds = {
				["e"] = {
					add = function()
						local env_name = surround_config1.get_input(
						"Enter the enviroment name: ")
						if env_name then
							return { { "\\begin{" .. env_name .. "}" },
								{ "\\end{" .. env_name .. "}" } }
						end
					end
				},
			},
			move_cursor = false,
			-- Configuration here, or leave empty to use defaults
		})
	end,
	event = "VeryLazy",
}
--}}}
