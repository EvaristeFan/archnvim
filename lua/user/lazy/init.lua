return {

	-- FileType Plugin {{{
	{
		"iamcco/markdown-preview.nvim",
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	-- }}}

	-- Appearance {{{
	-- Main Colorscheme

	{ "nvim-tree/nvim-web-devicons" }, -- icons

	--File tree


	-- BufferLine Plugin
	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("bufferline").setup {
				options = {
					numbers = "buffer_id",
					offsets = { { filetype = "neo-tree", text = "File Explorer", text_align =
					"center" } },                                 -- | function , text_align = "left" | "center" | "right"}},
				}
			}
		end,
	},
	-- }}}

	-- Telscope and extensions {{{
	{ 'nvim-telescope/telescope-ui-select.nvim' },

	-- extensions of fzf native
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build =
		'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
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
	{ "p00f/nvim-ts-rainbow",        dependencies = "nvim-treesitter/nvim-treesitter" },
	-- }}}

	-- lsp config {{{
	{
		'neovim/nvim-lspconfig',
		config = function()
			require("user.lsp")
		end,
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp"
		}
	},
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
	{
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig"
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons"
		}, -- optional dependency
		config = function()
			require("barbecue").setup(
				{
					context_follow_icon_color = true
				})
		end
	},
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
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup(
				{
					border = "rounded",
					sources = {
						null_ls.builtins.formatting.autopep8,
						null_ls.builtins.formatting.bibclean,
						null_ls.builtins.formatting.rustfmt,
						null_ls.builtins.formatting.astyle,
					}
				})
		end
	},


	-- }}}

	-- Cmp completion {{{
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
	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip"
		}
	},
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
		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = "firenvim", wait = true })
			vim.fn["firenvim#install"](0)
		end
	},
}

-- vim: fdm=marker fdl=0
