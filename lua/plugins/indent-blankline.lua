local ibl = require 'ibl'
local bg_highlight = {
  'DimDim',
}
local highlight = {
  'RainbowViolet',
}

local hooks = require 'ibl.hooks'
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#AB94FC' })
  vim.api.nvim_set_hl(0, 'DimDim', { fg = '#303030' })
end)
ibl.setup {
  indent = {
    highlight = bg_highlight,
    char = '⋮',
    -- ․
  },
  scope = {
    char = '⋮', -- ⨞ ∼ ⋄ ∘
    show_exact_scope = true,
    highlight = highlight,
  },
}

vim.o.termguicolors = true
