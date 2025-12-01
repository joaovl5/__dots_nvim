local add = MiniDeps.add

-- statusline
add 'sschleemilch/slimline.nvim'
require('slimline').setup {
  style = 'fg',
  bold = true,
  configs = {
    path = {
      hl = {
        primary = 'Label',
      },
    },
    git = {
      hl = {
        primary = 'Function',
      },
    },
    filetype_lsp = {
      hl = {
        primary = 'String',
      },
    },
  },
}

return {}
