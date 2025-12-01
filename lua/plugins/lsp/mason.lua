local add = MiniDeps.add

-- Mason setup
add 'mason-org/mason.nvim'
require('mason').setup {}
add 'mason-org/mason-lspconfig.nvim'
require('mason-lspconfig').setup {}
add 'WhoIsSethDaniel/mason-tool-installer.nvim'
require('mason-tool-installer').setup {}

return {}
