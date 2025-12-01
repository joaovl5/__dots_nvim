local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_or_later = _G.Config.now_or_later

now(function()
  add 'zaldih/themery.nvim'

  -- Collect all theme names from the global themes array
  local theme_names = { 'minisummer' } -- Keep minisummer from mini.nvim
  for _, theme in ipairs(_G.Config.themes or {}) do
    for _, name in ipairs(theme.names) do
      table.insert(theme_names, name)
    end
  end

  require('themery').setup {
    themes = theme_names,
    livePreview = true,
  }
end)
