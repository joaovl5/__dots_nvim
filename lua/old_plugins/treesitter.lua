local add, now = MiniDeps.add, MiniDeps.later

local languages = {
  'lua',
  'vimdoc',
  'markdown',
  'python',
  'javascript',
  'jsx',
  'typescript',
  'tsx',
  'html',
  'css',
  'scss',
  'csv',
  'norg',
  'norg_meta',
}

local install_dir = vim.fn.stdpath 'data' .. '/site'

function ts_update()
  vim.notify('Updating Treesitter', vim.log.levels.INFO)
  vim.cmd 'TSUpdate'
  vim.notify('Updated Treesitter', vim.log.levels.INFO)
end

local isnt_installed = function(lang)
  return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
end

now(function()
  -- Use `main` branch since `master` branch is frozen, yet still default
  add {
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'main',
    hooks = {
      post_checkout = ts_update,
    },
  }
  add {
    source = 'nvim-treesitter/nvim-treesitter-textobjects',
    checkout = 'main',
  }

  local treesitter = require 'nvim-treesitter'

  -- install languages that aren't installed
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then
    treesitter.install(to_install)
  end

  -- enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev)
    vim.treesitter.start(ev.buf)
  end
  _G.Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end)
