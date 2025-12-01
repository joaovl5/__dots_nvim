local add = MiniDeps.add

-- markdown stuff
add 'OXY2DEV/markview.nvim'
require('markview').setup {
  preview = {
    filetypes = { 'markdown', 'quarto', 'rmd', 'typst', 'Avante' },
    ignore_buftypes = {},
  },
}

return {}
