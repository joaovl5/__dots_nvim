local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_or_later = _G.Config.now_or_later

now(function()
  add 'alex-popov-tech/store.nvim'
end)
