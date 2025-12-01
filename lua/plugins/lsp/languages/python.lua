local add = MiniDeps.add

-- python stuff
add 'AckslD/swenv.nvim'
require('swenv').setup {
  post_set_venv = function()
    vim.cmd 'LspRestart'
  end,
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python' },
  callback = function()
    require('swenv.api').auto_venv()
    vim.cmd 'LspRestart'
  end,
})

return {}
