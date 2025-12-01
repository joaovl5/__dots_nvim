local later = MiniDeps.later

later(function()
  -- Create pairs not only in Insert, but also in Command line mode
  require('mini.pairs').setup { modes = { command = true } }
end)
