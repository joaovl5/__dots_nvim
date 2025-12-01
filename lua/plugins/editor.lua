require('fff').setup {
  prompt = '🌟 ',
  title = 'FIND FIND FIND',
  max_results = 50,
  max_threads = 8,
  layout = {
    height = 0.8,
    width = 0.8,
    prompt_position = 'top',
    preview_position = 'right',
    preview_size = 0.6,
  },
}

-- MOTIONS

require('comfy-line-numbers').setup {}

-- leap
local leap = require 'leap'
-- preview filter to reduce visual noise
leap.opts.preview = function(ch0, ch1, ch2)
  return not (ch1:match '%s' or (ch0:match '%a' and ch1:match '%a' and ch2:match '%a'))
end
-- define equivalence classes for brackets and quotes
leap.opts.equivalence_classes = {
  ' \t\r\n',
  '([{',
  ')]}',
  '\'"`',
}
-- use the traversal keys to repeat the previous motion
require('leap.user').set_repeat_keys('<enter>', '<backspace>')

-- improves insert mode experience
require('bim').setup {}

-- smart backspace (dont remember what it does, but it must be smart)
require('smart-backspace').setup {
  enabled = true,
  silent = true,
}

-- ACTIONS

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
require('pretty_hover').setup {}
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

require('nvim-navbuddy').setup {
  window = {
    border = 'none',
    size = '60%',
  },
  lsp = {
    auto_attach = true,
  },
}
