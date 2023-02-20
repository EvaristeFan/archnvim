return {

	-- FileType Plugin {{{
	"lervag/vimtex",
	{
		"iamcco/markdown-preview.nvim",
		config = function() require("user.plugconfig.vimtex") end,
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	-- }}}

	-- Editor {{{
	-- Hop.nvim

	{ "phaazon/hop.nvim",
		config = function()
			require("user.plugconfig.hop")
		end },
	-- Nvim-surround
	{ "kylechui/nvim-surround",
		config = function()
			require("user.plugconfig.nvim_surround")
		end },
	--}}}

	-- Appearance {{{
	-- Main Colorscheme
	{ "olimorris/onedarkpro.nvim",
		config = function()
			require("user.plugconfig.colorscheme")
		end,
		lazy = false, },

	{ "nvim-tree/nvim-web-devicons" }, -- icons

	--File tree

	{ "nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("user.plugconfig.neotree")
		end, },

	-- Lualine
	{ "nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("user.plugconfig.lualine")
		end, },
	-- BufferLine Plugin
	{ "akinsho/bufferline.nvim",
		version = "v3.*",
		denpendencies = {
			"nvim-tree/nvim-webdevicons",
		},
		config = function()
			require("user.plugconfig.bufferline")
		end, },
	-- }}}

	-- Telscope and extensions {{{
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require("user.plugconfig.telescope")
		end,
	},
	{ 'nvim-telescope/telescope-ui-select.nvim' },

	-- extensions of fzf native
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
	},

	-- extensions of frecency
	{
		"nvim-telescope/telescope-frecency.nvim",
		dependencies = { "kkharji/sqlite.lua" }
	},
	-- }}}

	-- Treesitter {{{
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("user.plugconfig.treesitter")
		end
	},
	{ "p00f/nvim-ts-rainbow",        dependencies = "nvim-treesitter/nvim-treesitter" },
	-- }}}

	-- lsp config {{{
	{ 'neovim/nvim-lspconfig',
		config = function()
			require("user.lsp")
		end,
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp"
		} },
	"onsails/lspkind.nvim", -- cmp icons
	{
		'j-hui/fidget.nvim',
		config = function()
			require("fidget").setup({
				window = {
					blend = 0,
					border = "rounded"
				}
			}
			)
		end
	},
	"RishabhRD/popfix",
	"RishabhRD/nvim-lsputils",
	{ "SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig" },
	{ "utilyre/barbecue.nvim",
		name = "barbecue",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons"
		}, -- optional dependency
		config = function()
			require("barbecue").setup()
		end },
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	},



	-- }}}

	-- Cmp completion {{{
	{ "hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"nvim-treesitter/nvim-treesitter"
		},
		config = function()
			require("user.plugconfig.cmp")
		end },
	{ "hrsh7th/cmp-nvim-lsp",        dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-path",            dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-cmdline",         dependencies = "hrsh7th/nvim-cmp" },
	{ "dmitmel/cmp-cmdline-history", dependencies = "hrsh7th/nvim-cmp" },
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("user.plugconfig.luasnip")
		end
	},
	{ "saadparwaiz1/cmp_luasnip",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip"
		} },
	{
		"iurimateus/luasnip-latex-snippets.nvim",
		-- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
		-- using treesitter.
		dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
		config = function()
			require 'luasnip-latex-snippets'.setup()
			-- or setup({ use_treesitter = true })
		end,
		ft = "tex",
	},
	-- }}}

	{
		'glacambre/firenvim',
		build = function() vim.fn['firenvim#install'](0) end,

		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		cond = not not vim.g.started_by_firenvim
	},
}

-- vim: fdm=marker fdl=0
