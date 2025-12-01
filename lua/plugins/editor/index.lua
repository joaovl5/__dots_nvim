local now, later = MiniDeps.now, MiniDeps.later
local now_or_later = _G.Config.now_or_later

-- Load submodules in order to maintain execution order

-- finder (fff)
now(function()
  require 'plugins.editor.finder'
end)

-- relative line nums will only include digits 1 through 5 for comfort
now_or_later(function()
  require 'plugins.editor.motions'
end)

-- type annotations generator, pretty hover, tiny code actions
later(function()
  require 'plugins.editor.actions'
end)

-- glance and navbuddy
later(function()
  require 'plugins.editor.views'
end)

-- Keep for backward compatibility if other modules require this file
return {}
