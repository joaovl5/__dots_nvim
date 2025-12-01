local later = MiniDeps.later

later(function()
  local indentscope = require 'mini.indentscope'
  indentscope.setup {
    draw = {

      delay = 50,
      -- disable animations
      animation = indentscope.gen_animation.none(),
    },
    options = {
      try_as_border = true,
    },
    symbol = '⋅',
  }
end)
