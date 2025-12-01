local now = MiniDeps.now

now(function()
  require('mini.basics').setup {
    options = { basic = false },
    mappings = {
      -- save w/ `<C-s>` among other things
      basic = true,
      -- Create `<C-hjkl>` mappings for window navigation
      windows = true,
      -- Disable `<M-hjkl>` mappings for navigation in Insert and Command modes
      move_with_alt = false,
    },
  }
end)
