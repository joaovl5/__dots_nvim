local add = MiniDeps.add

-- kill inactive lsps
add 'zeioth/garbage-day.nvim'
require('garbage-day').setup {
  grace_period = 60 * 15, -- waits 15 minutes for the kill
  wakeup_delay = 1, -- waits 1 second to ressucitate
}

return {}
