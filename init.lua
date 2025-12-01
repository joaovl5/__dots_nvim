-- define leader key first to avoid conflicts
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- setup plugin manager
-- require './mini_deps.lua'
do
  local install_location = vim.fs.joinpath(vim.fn.stdpath 'data', 'rocks')
  local rocks_config = {
    rocks_path = vim.fs.normalize(install_location),
  }
  vim.g.rocks_nvim = rocks_config

  -- Configure package.path for Lua modules
  local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, 'share', 'lua', '5.1', '?.lua'),
    vim.fs.joinpath(rocks_config.rocks_path, 'share', 'lua', '5.1', '?', 'init.lua'),
  }
  package.path = package.path .. ';' .. table.concat(luarocks_path, ';')

  -- Configure package.cpath for native libraries
  local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, 'lib', 'lua', '5.1', '?.so'),
    vim.fs.joinpath(rocks_config.rocks_path, 'lib64', 'lua', '5.1', '?.so'),
  }
  package.cpath = package.cpath .. ';' .. table.concat(luarocks_cpath, ';')

  -- Add rocks.nvim to runtimepath
  vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, 'lib', 'luarocks', 'rocks-5.1', 'rocks.nvim', '*'))
end

-- ONLY AFTER the above, check if rocks.nvim needs installation
if not pcall(require, 'rocks') then
  -- your bootstrap logic here
end
-- define global cfg
_G.Config = {}

-- autocommand group helper
local gr = vim.api.nvim_create_augroup('lav-config', {})
_G.Config.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

-- -- some plugins and 'mini.nvim' modules only need setup during startup if neovim
-- -- is started like `nvim -- path/to/file`, otherwise delaying setup is fine
-- _G.Config.now_or_later = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later
--
require 'options'
require 'keymaps'
-- require 'plugins.index'
