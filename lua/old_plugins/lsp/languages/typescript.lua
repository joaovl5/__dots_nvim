local add = MiniDeps.add

-- typescript stuff
add 'neovim/nvim-lspconfig'
add 'nvim-lua/plenary.nvim'
add 'pmizio/typescript-tools.nvim'
local tstools = require 'typescript-tools'
tstools.setup {}

return {}
