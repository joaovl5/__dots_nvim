local later = MiniDeps.later

later(function()
  require('mini.files').setup {
    windows = {
      preview = true,
      width_focus = 60,
      width_nofocus = 30,
    },
    mappings = _G.MiniFilesMappings, -- see keymaps.lua
  }
end)

-- customize window
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesWindowOpen',
  callback = function(args)
    local win_id = args.data.win_id
    -- vim.wo[win_id].winblend = 50
    local config = vim.api.nvim_win_get_config(win_id)
    config.border, config.title_pos = 'rounded', 'center'
    vim.api.nvim_win_set_config(win_id, config)
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesWindowUpdate',
  callback = function(args)
    local config = vim.api.nvim_win_get_config(args.data.win_id)
    -- -- Ensure fixed height
    -- config.height = 10

    -- Ensure no title padding
    local n = #config.title
    config.title[1][1] = config.title[1][1]:gsub('^ ', '')
    config.title[n][1] = config.title[n][1]:gsub(' $', '')

    vim.api.nvim_win_set_config(args.data.win_id, config)
  end,
})
