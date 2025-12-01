local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_or_later = _G.Config.now_or_later

now_or_later(function()
  add {
    source = 'nosduco/remote-sshfs.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
  }
  require('remote-sshfs').setup {}
  require('telescope').load_extension 'remote-sshfs'
end)
