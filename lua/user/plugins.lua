local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Use onedarkpro colorscheme
  use { 'olimorris/onedarkpro.nvim', }

  -- onedark
  use 'navarasu/onedark.nvim'

  use "kyazdani42/nvim-web-devicons" -- icons

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- File tree
  use 'kyazdani42/nvim-tree.lua'

  -- bufferline plugin
  -- -- using packer.nvim
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins

  -- Telscope and extensions
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-ui-select.nvim' }

  -- extensions of fzf native
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }

  -- extensions of frecency
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require"telescope".load_extension("frecency")
    end,
    requires = {"tami5/sqlite.lua"}
  }

  use 'mhinz/vim-startify'

  -- Hop.nvim
  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
  }

    -- Treesittetr
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use 'onsails/lspkind.nvim'
  use 'arkav/lualine-lsp-progress'
  use 'ray-x/lsp_signature.nvim'
  use 'RishabhRD/popfix'
  use 'RishabhRD/nvim-lsputils'

  -- Cmp completion
  use "hrsh7th/nvim-cmp"
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use 'honza/vim-snippets'
  use {
    "SirVer/ultisnips",
     config = function()
        -- optional call to setup (see customization section)
        require("cmp_nvim_ultisnips").setup{}
      end,
  }
  use "quangnguyen30192/cmp-nvim-ultisnips"

  -- vimtex
  use { 'lervag/vimtex', opt = true, ft = { "tex", "bib"} }
  -- surround vim
  use 'tpope/vim-surround'
  if packer_bootstrap then
    require('packer').sync()
  end
end)

