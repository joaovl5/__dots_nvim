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
