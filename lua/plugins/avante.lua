require('avante').setup {
  provider = 'claude',
  providers = {
    claude = {
      model = 'claude-sonnet-4-5-20250929',
    },
  },
  behavior = {},
  selector = {
    provider = 'telescope',
    -- Options override for custom providers
    provider_opts = {},
  },
}
