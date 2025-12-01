require('conform').setup {
  formatters = {
    eslint = {
      command = '/home/lav/.bun/bin/eslint',
    },
  },
  formatters_by_ft = {
    python = { 'ruff_format' },
    typescript = { 'eslint' },
    typescriptreact = { 'eslint' },
    handlebars = { 'eslint' },
    lua = { 'stylua' },
    rust = { 'rustfmt', lsp_format = 'fallback' },
    markdown = { 'prettierd' },
    -- javascript = { 'prettierd', 'prettier', stop_after_first = true },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
}
