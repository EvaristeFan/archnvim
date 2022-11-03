-- Packer setup {{{
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end
-- }}}

require('packer').startup(function(use)
	-- Packer can manage itself {{{
	use 'wbthomason/packer.nvim'
	-- }}}

	-- UI Modify {{{
	use "mhinz/vim-startify"
	-- Packer
	
	-- }}}
	use {
		"AckslD/nvim-neoclip.lua",
		requires = {
			{ 'kkharji/sqlite.lua' },
			-- you'll need at least one of these
			{ 'nvim-telescope/telescope.nvim' },
			-- {'ibhagwan/fzf-lua'},
		},
		config = function()
			require('neoclip').setup({
				enable_persistent_history = true,
			})
		end,
	}
	-- Editor {{{
	-- Hop.nvim
	use { 'phaazon/hop.nvim',
		config = function()
			require("user.plugconfig.hop")
		end }
	--  nvim-surround
	use({
		"kylechui/nvim-surround",
		config = function()
			require("user.plugconfig.nvim_surround")
		end
	}) --}}}

	-- Appearance {{{
	use({
		'olimorris/onedarkpro.nvim',
		config = function() require("user.plugconfig.colorscheme") end
	})
	use "kyazdani42/nvim-web-devicons" -- icons
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function() require("user.plugconfig.lualine") end
	}
	-- File tree
	use { 'kyazdani42/nvim-tree.lua',
		config = function()
			require("user.plugconfig.nvimtree")
		end,
	}
	-- bufferline plugin
	use { 'akinsho/bufferline.nvim',
		tag = "v2.*",
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require("user.plugconfig.bufferline")
		end,
	}
	-- }}}


	-- Telscope and extensions {{{
	use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			require("user.plugconfig.telescope")
		end,
		after = "nvim-neoclip.lua",
	}
	use { 'nvim-telescope/telescope-ui-select.nvim' }

	-- extensions of fzf native
	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
	}

	-- extensions of frecency
	use {
		"nvim-telescope/telescope-frecency.nvim",
		requires = { "tami5/sqlite.lua" }
	}
	-- }}}


	-- Treesittetr {{{
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				after = "nvim-treesitter",
				-- This is actually the nvim-treesitter config, but it's
				-- here to make lazy loading happy.
				config = function() require("user.plugconfig.treesitter") end,
			},
			{ 'p00f/nvim-ts-rainbow', after = "nvim-treesitter" },
			{ 'nvim-treesitter/playground', after = "nvim-treesitter" }
		}
	}
	-- }}}

	-- Lsp Config {{{
	use {
		'neovim/nvim-lspconfig', -- Collection of configurations for the built-in LSP client
		config = function() require("user.lsp") end,
		after = { "nvim-cmp", "cmp-nvim-lsp" },
	}
	use 'onsails/lspkind.nvim'
	use 'arkav/lualine-lsp-progress'
	use 'ray-x/lsp_signature.nvim'
	use 'RishabhRD/popfix'
	use 'RishabhRD/nvim-lsputils'
	use {
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig"
	}
	use {
		'B4mbus/nvim-headband',
		config = function()
			require('nvim-headband').setup {
				-- Your configuration goes here
			}
		end,
		after = 'nvim-web-devicons',
		requires = {
			{ 'SmiteshP/nvim-navic' }, -- required for for the navic section to work
			{ 'kyazdani42/nvim-web-devicons' } -- required for for devicons and default location_section.separator highlight group
		}
	}

	-- Lua
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}
	-- }}}


	-- Cmp completion {{{
	use {
		"hrsh7th/nvim-cmp",
		requires = {
			{ 'hrsh7th/cmp-nvim-lsp', after = "nvim-cmp" }, -- LSP source for nvim-cmp
			{ 'hrsh7th/cmp-buffer', after = "nvim-cmp" }, -- buffer completions
			{ 'hrsh7th/cmp-path', after = "nvim-cmp" }, -- path completions
			{ 'hrsh7th/cmp-cmdline', after = "nvim-cmp" }, -- cmdline completions
			{ 'dmitmel/cmp-cmdline-history', after = "nvim-cmp" }, -- cmdline completions history
			{
				'L3MON4D3/LuaSnip',
				config = function() require("user.plugconfig.luasnip") end,
			},
			{ 'saadparwaiz1/cmp_luasnip', after = "nvim-cmp" }
		},
		after    = { "LuaSnip", "nvim-treesitter" },
		config   = function() require("user.plugconfig.cmp") end,
	}
	use {
		"iurimateus/luasnip-latex-snippets.nvim",
		-- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
		-- using treesitter.
		requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
		config = function()
			require 'luasnip-latex-snippets'.setup()
			-- or setup({ use_treesitter = true })
		end,
		ft = "tex",
	}
	-- }}}


	-- Filetype Plugins -- {{{
	-- vimtex
	use { 'lervag/vimtex' }
	use {
		"iamcco/markdown-preview.nvim",
		config = function() require("user.plugconfig.vimtex") end,
		run = function() vim.fn["mkdp#util#install"]() end,
	}
	--}}}


	if packer_bootstrap then
		require('packer').sync()
	end
end)

-- vim: fdm=marker fdl=0
