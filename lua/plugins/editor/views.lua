local add = MiniDeps.add

-- glance
add 'dnlhc/glance.nvim'

-- navbuddy
add 'SmiteshP/nvim-navbuddy'
-- deps
add 'SmiteshP/nvim-navic'
add 'MunifTanjim/nui.nvim'
add 'numToStr/Comment.nvim'
require('nvim-navbuddy').setup {
  window = {
    border = 'none',
    size = '60%',
  },
  lsp = {
    auto_attach = true,
  },
}

return {}
