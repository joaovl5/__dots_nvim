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
