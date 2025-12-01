-- todo handle dynamic stuff

local theme_names = {
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
}

require('themery').setup {
  themes = theme_names,
  livePreview = true,
}
