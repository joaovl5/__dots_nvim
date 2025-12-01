local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_or_later = _G.Config.now_or_later

now_or_later(function()
  add 'nvim-lua/popup.nvim'
  add 'nvim-lua/plenary.nvim'
  add 'nvim-telescope/telescope.nvim'
  -- extensions
  add 'jvgrootveld/telescope-zoxide'
  local telescope = require 'telescope'
  local z_utils = require 'telescope._extensions.zoxide.utils'
  telescope.setup {
    extensions = {
      zoxide = {
        prompt_title = '∟ Zoxide Pick ⯾',
        mappings = {
          default = {
            action = function(selection)
              vim.cmd.cd(selection.path)
              MiniFiles.open(selection.path)
            end,
            after_action = function(selection)
              vim.notify('Directory changed to ' .. selection.path)
            end,
          },
        },
      },
    },
  }
  telescope.load_extension 'zoxide'
end)
