local later = MiniDeps.later

later(function()
  require('mini.diff').setup {}
  require('mini.git').setup {}
end)
