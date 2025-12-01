local now, later = MiniDeps.now, MiniDeps.later
local now_or_later = _G.Config.now_or_later

-- Load submodules in order to maintain execution order
now_or_later(function()
  -- Mason setup (must be first)
  require 'plugins.lsp.mason'
  -- Completions (blink.cmp) setup
  require 'plugins.lsp.completions'
  -- LSP server configuration
  require 'plugins.lsp.config'
  -- Formatting configuration
  require 'plugins.lsp.formatting'

  -- misc
  require 'plugins.lsp.misc'

  --- language stuff
  require 'plugins.lsp.languages.markdown'
  require 'plugins.lsp.languages.lua'
  require 'plugins.lsp.languages.typescript'
  require 'plugins.lsp.languages.python'
end)

return {}
