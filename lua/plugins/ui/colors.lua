local add = MiniDeps.add

-- reactive colors on mode/motions
add 'rasulomaroff/reactive.nvim'
require('reactive').setup {
  builtin = {
    cursorline = true,
    cursor = true,
    modemsg = true,
  },
}

-- color hex codes
add 'catgoose/nvim-colorizer.lua'

return {}
