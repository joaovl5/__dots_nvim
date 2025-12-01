-- define leader key first to avoid conflicts
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- setup mini-deps
local path_package = vim.fn.stdpath 'data' .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd 'echo "Installing [`mini.nvim`](../doc/mini-nvim.qmd#mini.nvim)" | redraw'
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd 'packadd mini.nvim | helptags ALL'
  vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

require('mini.deps').setup {
  path = {
    package = path_package,
  },
}

-- define global cfg
_G.Config = {}

-- autocommand group helper
local gr = vim.api.nvim_create_augroup('lav-config', {})
_G.Config.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

-- some plugins and 'mini.nvim' modules only need setup during startup if neovim
-- is started like `nvim -- path/to/file`, otherwise delaying setup is fine
_G.Config.now_or_later = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

require 'options'
require 'keymaps'
require 'plugins.index'
