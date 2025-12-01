local later = MiniDeps.later

later(function()
  require('mini.files').setup {
    windows = {
      preview = true,
      width_focus = 60,
      width_nofocus = 30,
    },
  }
end)
