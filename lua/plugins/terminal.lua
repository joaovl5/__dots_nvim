local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_or_later = _G.Config.now_or_later

later(function()
  add 'akinsho/toggleterm.nvim'
  require('toggleterm').setup {}
end)
