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

	-- onedarkpro {{{
	use({
		'olimorris/onedarkpro.nvim',
		config = function() require("user.plugconfig.colorscheme") end
	})
	-- }}}


	-- Unrefactored plugin {{{
	use 'mhinz/vim-startify'

	-- Hop.nvim
	use {
		'phaazon/hop.nvim',
	}
	-- vimtex
	use { 'lervag/vimtex' }
	-- surround vim
	use 'tpope/vim-surround'
	use "kyazdani42/nvim-web-devicons" -- icons

	use {
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	}

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	-- File tree
	use 'kyazdani42/nvim-tree.lua'

	-- bufferline plugin
	-- -- using packer.nvim
	use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
	-- }}}


	-- Telscope and extensions {{{
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' } }
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
	}
	use { 'p00f/nvim-ts-rainbow' }
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
			{
				'L3MON4D3/LuaSnip',
				config = function() require("user.plugconfig.luasnip") end,
			},
			{ 'saadparwaiz1/cmp_luasnip', after = "nvim-cmp" }
		},
		after    = { "LuaSnip", "nvim-treesitter" },
		config   = function() require("user.plugconfig.cmp") end,
	}
	-- }}}


	if packer_bootstrap then
		require('packer').sync()
	end
end)

-- vim: fdm=marker fdl=0
