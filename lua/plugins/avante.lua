local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now

add {
  source = 'yetone/avante.nvim',
  monitor = 'main',
  depends = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'echasnovski/mini.icons',
  },
  hooks = {
    post_checkout = function()
      vim.cmd 'make'
    end,
  },
}
--- optional
add { source = 'HakonHarnes/img-clip.nvim' }

later(function()
  require('img-clip').setup {} -- config img-clip
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
end)
