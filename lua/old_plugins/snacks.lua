local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_or_later = _G.Config.now_or_later

now(function()
  add 'folke/snacks.nvim'
  require('snacks').setup {
    -- optimize big file viewing
    bigfile = { enabled = true },
    -- load files faster
    quickfile = { enabled = true },

    -- notifications
    notify = { enabled = true },
    notifier = {
      enabled = true,
      width = { min = 50, max = 0.4 },
      height = { min = 1, max = 0.6 },
      -- editor margin to keep free. tabline and statusline are taken into account automatically
      margin = { top = 2, right = 1, bottom = 0 },
      padding = true, -- add 1 cell of left/right padding to the notification window
      gap = 1, -- gap between notifications
      sort = { 'level', 'added' }, -- sort by level and time
      -- minimum log level to display. TRACE is the lowest
      -- all notifications are stored in history
      level = vim.log.levels.TRACE,
      icons = {
        error = ' ',
        warn = ' ',
        info = ' ',
        debug = ' ',
        trace = ' ',
      },
      keep = function(notif)
        return vim.fn.getcmdpos() > 0
      end,
      style = 'minimal',
      top_down = true, -- place notifications from top to bottom
      date_format = '%R', -- time format for notifications
      -- format for footer when more lines are available
      -- `%d` is replaced with the number of lines.
      -- only works for styles with a border
      ---@type string|boolean
      more_format = ' ↓ %d lines ',
      refresh = 50, -- refresh at most every 50ms
    },

    -- smooth scroll
    scroll = { enabled = true },

    -- ui-related
    input = { enabled = true },
    image = { enabled = true },
  }
  vim.o.termguicolors = true
end)
