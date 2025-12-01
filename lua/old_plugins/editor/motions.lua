local add = MiniDeps.add

-- relative line nums will only include digits 1 throught 5 for comfort
add 'mluders/comfy-line-numbers.nvim'
require('comfy-line-numbers').setup {}

-- leap motions
add {
  source = 'ggandor/leap.nvim',
  dependencies = { 'tpope/vim-repeat' },
}
local leap = require 'leap'
-- preview filter to reduce visual noise
leap.opts.preview = function(ch0, ch1, ch2)
  return not (ch1:match '%s' or (ch0:match '%a' and ch1:match '%a' and ch2:match '%a'))
end
-- define equivalence classes for brackets and quotes
leap.opts.equivalence_classes = {
  ' \t\r\n',
  '([{',
  ')]}',
  '\'"`',
}
-- use the traversal keys to repeat the previous motion
require('leap.user').set_repeat_keys('<enter>', '<backspace>')

-- improves w,e,b word motions
add 'chrisgrieser/nvim-spider'
require('spider').setup {}

-- improves insert mode experience
add 'sontungexpt/bim.nvim'
require('bim').setup {}

-- prevents scrolling past bottom of buffer
add 'saghen/filler-begone.nvim'

-- smart backspace (dont remember what it does, but it must be smart)
add 'qwavies/smart-backspace.nvim'
require('smart-backspace').setup {
  enabled = true,
  silent = true,
}

return {}
