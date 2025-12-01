local now = MiniDeps.now
local now_or_later = _G.Config.now_or_later

-- Load submodules in order to maintain execution order

-- noice ui
now_or_later(function()
  require 'plugins.ui.noice'
end)

-- statusline
now(function()
  require 'plugins.ui.statusline'
end)

-- reactive colors on mode/motions and color hex codes
now_or_later(function()
  require 'plugins.ui.colors'
end)

-- Keep for backward compatibility if other modules require this file
return {}
