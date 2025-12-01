--- [[General]]
-- enable mouse
vim.o.mouse = 'a'
vim.o.mousescroll = 'ver:25,hor:6'

-- switch between opened buffers
vim.o.switchbuf = 'usetab'

-- clipboard OS sync
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- persistent undo (saves undo history)
vim.o.undofile = true

-- limit shada file size
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- enable filetype plugins and syntax (faster startup)
vim.cmd 'filetype plugin indent on'
if vim.fn.exists 'syntax_on' ~= 1 then
  vim.cmd 'syntax enable'
end

-- ensure nerd font
vim.g.have_nerd_font = true

--- [[Misc]]
vim.cmd 'autocmd BufRead,BufNewFile *.hbs set filetype=html'

--- [[UI]]
vim.o.updatetime = 100
vim.o.timeoutlen = 300
vim.opt.background = 'dark'
--- indentation/lines
vim.o.colorcolumn = '+1' -- Draw column on the right of maximum width
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Relative line numbers
vim.o.list = true -- Show helpful text indicators
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.fillchars = 'eob: ,fold:╌'
-- vim.o.shortmess = 'CFOSWaco' -- Disable some built-in completion messages
-- wrap
vim.o.wrap = false -- Don't visually wrap lines (toggle with \w)
vim.o.linebreak = true -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.breakindent = true -- Indent wrapped lines to match line start
vim.o.breakindentopt = 'list:-1' -- Add padding for lists (if 'wrap' is set)
-- cursor
vim.o.cursorline = true -- Enable current line highlighting
vim.o.cursorcolumn = true -- Crosshair!
vim.o.cursorlineopt = 'screenline,number' -- Show cursor line per screen line
-- statusbar/cmdbar
vim.o.ruler = false -- Don't show cursor coordinates in statusbar
vim.o.showmode = false -- Don't show mode in command line
vim.o.signcolumn = 'yes' -- Always show signcolumn (less flicker)
--- tabs/windows/buffers/splits
vim.o.splitbelow = true -- Horizontal splits will be below
vim.o.splitkeep = 'screen' -- Reduce scroll during window split
vim.o.splitright = true -- Vertical splits will be to the right
vim.o.winborder = 'rounded' -- Use border in floating windows
--- folds
vim.o.foldlevel = 10 -- Fold nothing by default; set to 0 or 1 to fold
vim.o.foldmethod = 'indent' -- Fold based on indent level
vim.o.foldnestmax = 10 -- Limit number of fold levels
vim.o.foldtext = '' -- Show text under fold with its highlighting

--- [[Editor]]
vim.o.spelloptions = 'camel' -- Treat camelCase word parts as separate words
vim.o.virtualedit = 'block' -- Allow going past end of line in blockwise mode
vim.o.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part
vim.o.scrolloff = 10
vim.o.inccommand = 'split'

-- built-in completion
vim.o.complete = '.,w,b,kspell' -- Use less sources
vim.o.completeopt = 'menuone,noselect,fuzzy,nosort' -- Use custom behavior

-- indents
vim.o.autoindent = true -- Use auto indent
vim.o.smartindent = true -- Make indenting smart
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
vim.o.tabstop = 2 -- Show tab as this number of spaces

-- formatting
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]
vim.o.formatoptions = 'rqnl1'
local f = function()
  vim.cmd 'setlocal formatoptions-=c formatoptions-=o'
end
_G.Config.new_autocmd('FileType', nil, f, "Proper 'formatoptions'")

-- search
vim.o.ignorecase = true -- Ignore case during search
vim.o.incsearch = true -- Show search matches while typing
-- vim.o.infercase = true -- Infer case in built-in completion
vim.o.smartcase = true -- Respect case if search pattern has upper case

-- neovim diagnostics
local diagnostic_opts = {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  -- Show signs on top of any other sign, but only for warnings and errors
  signs = {
    priority = 9999,
    severity = { min = 'WARN', max = 'ERROR' },
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },

  -- Show all diagnostics as underline (for their messages type `<Leader>ld`)
  underline = { severity = { 'ERROR' } },

  -- Show more details immediately for errors on the current line
  virtual_lines = false,
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    current_line = true,
    severity = { 'ERROR' },
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}

-- Use `later()` to avoid sourcing `vim.diagnostic` on startup
MiniDeps.later(function()
  vim.diagnostic.config(diagnostic_opts)
end)
