local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Use onedarkpro colorscheme
  use 'olimorris/onedarkpro.nvim'

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
  -- extensions of fzf native
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  -- extensions of frecency
  use {
  "nvim-telescope/telescope-frecency.nvim",
  config = function()
    require"telescope".load_extension("frecency")
  end,
  requires = {"tami5/sqlite.lua"}
  }
  use 'mhinz/vim-startify'
  if packer_bootstrap then
    require('packer').sync()
  end
end)
