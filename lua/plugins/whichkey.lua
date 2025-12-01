local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_or_later = _G.Config.now_or_later

later(function()
  add 'folke/which-key.nvim'
  require('which-key').setup {
    keys = {},
    preset = 'helix',
    plugins = {
      spelling = {
        enabled = false,
      },
    },
    win = {
      title = true,
      title_pos = 'center',
    },
    layout = {
      spacing = 4,
    },
    delay = 150,
    spec = _G.Config.leader_spec,
  }
end)
