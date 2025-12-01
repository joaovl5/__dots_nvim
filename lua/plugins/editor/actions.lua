local add = MiniDeps.add

-- type annotations generator
add 'danymat/neogen'
require('neogen').setup {
  enabled = true,
  languages = {
    python = {
      template = {
        annotation_convention = 'google_docstrings',
      },
    },
  },
}

-- pretty hover
add 'Fildo7525/pretty_hover'
require('pretty_hover').setup {}

-- tiny code actions
add 'rachartier/tiny-code-action.nvim'
-- deps
add 'nvim-lua/plenary.nvim'

require('tiny-code-action').setup {
  backend = 'delta',
  picker = 'telescope',
  resolve_timeout = 100, -- Timeout in milliseconds to resolve code actions
  notify = {
    enabled = true, -- Enable/disable all notifications
    on_empty = true, -- Show notification when no code actions are found
  },
  backend_opts = {
    header_lines_to_remove = 4,
    args = {
      '--line-numbers',
    },
  },
}

return {}
