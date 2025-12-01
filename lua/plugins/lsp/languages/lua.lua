local add = MiniDeps.add

-- lua stuff
add 'folke/lazydev.nvim'
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

return {}
