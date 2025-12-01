local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_or_later = _G.Config.now_or_later

-- Global variable storing all theme plugins for later usage
_G.Config.themes = {
  {
    source = 'nyoom-engineering/oxocarbon.nvim',
    post_add = nil,
    names = { 'oxocarbon' },
  },
  {
    source = 'mellow-theme/mellow.nvim',
    post_add = function()
      vim.g.mellow_italic_comments = true
    end,
    names = { 'mellow' },
  },
  {
    source = 'embark-theme/vim',
    post_add = nil,
    names = { 'embark' },
  },
  {
    source = 'eldritch-theme/eldritch.nvim',
    post_add = nil,
    names = { 'eldritch', 'eldritch-dark', 'eldritch-minimal' },
  },
  {
    source = 'MarkChuCarroll/mlavender',
    post_add = nil,
    names = { 'mlavender' },
  },
  {
    source = 'uhs-robert/oasis.nvim',
    post_add = nil,
    names = {
      'oasis-midnight',
      'oasis-abyss',
      'oasis-starlight',
      'oasis-desert',
      'oasis-sol',
      'oasis-canyon',
      'oasis-dune',
      'oasis-cactus',
      'oasis-mirage',
      'oasis-lagoon',
      'oasis-twilight',
      'oasis-rose',
    },
  },
}

now_or_later(function()
  for _, theme in ipairs(_G.Config.themes) do
    add(theme.source)
    if theme.post_add then
      theme.post_add()
    end
  end
end)
