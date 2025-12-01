local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_or_later = _G.Config.now_or_later

now(function()
  add 'nvim-neorg/lua-utils.nvim'
  add 'pysan3/pathlib.nvim'
  add 'nvim-neotest/nvim-nio'
end)

now(function()
  add 'nvim-neorg/neorg'

  local neorg = require 'neorg'
  neorg.setup {
    load = {
      ['core.defaults'] = {},
      ['core.concealer'] = {},
      ['core.dirman'] = {
        config = {
          workspaces = {
            vault_neorg = '~/docs/neorg',
          },
          default_workspace = 'vault_neorg',
        },
      },
    },
  }

  vim.wo.foldlevel = 99
  vim.wo.conceallevel = 2
end)
