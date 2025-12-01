-- helper for mapping to normal mode
local nmap = function(lhs, rhs, desc)
  -- See `:h vim.keymap.set()`
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end
-- leader-key helpers
local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc })
end

--- [[General]]

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
nmap('[p', '<Cmd>exe "put! " . v:register<CR>', 'Paste Above')
nmap(']p', '<Cmd>exe "put "  . v:register<CR>', 'Paste Below')
-- disable pasting in visual selection replacing original copied value
vim.keymap.set('x', 'p', '"_dP')

--- [[Spooky Motions]]
-- leaps
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-from-window)')
vim.keymap.set({ 'x', 'o' }, 'R', function()
  require('leap.treesitter').select {
    -- To increase/decrease the selection in a clever-f-like manner,
    -- with the trigger key itself (vRRRRrr...). The default keys
    -- (<enter>/<backspace>) also work, so feel free to skip this.
    opts = require('leap.user').with_traversal_keys('R', 'r'),
  }
end)
vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>")

--- [[Leader]]
_G.Config.leader_spec = {
  { '<Leader>w', group = '+Window' },
  { '<Leader>b', group = '+Buffer' },
  { '<Leader>f', group = '+Find' },
  { '<Leader>g', group = '+Git', mode = { 'n', 'v' } },
  { '<Leader>c', group = '+Code', mode = { 'n', 'v' } },
  { '<Leader>m', group = '+Map' },
  { '<Leader>t', group = '+Terminal' },
  { '<Leader>o', group = '+Other' },
  { '<Leader>s', group = '+Session' },
  { '<Leader>v', group = '+Visits' },
  { '<Leader>e', group = '+Explore' },
}

-- w is for 'Window'
nmap_leader('wr', '<Cmd>lua MiniMisc.resize_window()<CR>', 'Resize to default width')
nmap_leader('wz', '<Cmd>lua MiniMisc.zoom()<CR>', 'Zoom toggle')
nmap_leader('wd', '<Cmd>quit<CR>', 'Quit window')
nmap_leader('wD', '<Cmd>quitall<CR>', 'Quit all windows')
nmap_leader('ww', '<Cmd>b#<CR>', 'Alternate Buffers in Window')
nmap_leader('|', '<Cmd>vsplit()<CR>', 'Split vertical')
nmap_leader('-', '<Cmd>split()<CR>', 'Split horizontal')

-- b is for 'Buffer'
local new_scratch_buffer = function()
  vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

nmap_leader('bd', '<Cmd>lua MiniBufremove.delete()<CR>', 'Delete Buffer')
-- TODO: use scratchbuffer plugin
nmap_leader('bs', new_scratch_buffer, 'Scratch Buffer')
nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>', 'Wipeout')

-- e is for 'Explore' and 'Edit'
local edit_plugin_file = function(filename)
  return string.format('<Cmd>edit %s/plugin/%s<CR>', vim.fn.stdpath 'config', filename)
end
local explore_at_file = '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>'
local fuzzy_at_root = '<Cmd>lua require("fff").find_files()<CR>'
local fuzzy_at_file = '<Cmd>lua require("fff").find_files_in_dir(vim.api.nvim_buf_get_name(0)<CR>'

nmap_leader('e', '<Cmd>lua MiniFiles.open()<CR>', 'Directory')
nmap_leader('E', explore_at_file, 'File Directory')
nmap_leader('on', '<Cmd>lua MiniNotify.show_history()<CR>', 'Notifications')
-- explore -> minifiles windows keymaps
_G.MiniFilesMappings = {
  close = 'q',
  go_in = 'l',
  go_in_plus = 'L',
  go_out = 'h',
  go_out_plus = 'H',
  mark_goto = "'",
  mark_set = 'm',
  reset = '<BS>',
  reveal_cwd = '@',
  show_help = 'g?',
  synchronize = '=',
  trim_left = '<',
  trim_right = '>',
}
-- toggle hidden and other functions
local show_dotfiles = true
local filter_show = function(fs_entry)
  return true
end

local filter_hide = function(fs_entry)
  -- hide dotfiles except .env
  return not vim.startswith(fs_entry.name, '.') or vim.endswith(fs_entry.name, '.env')
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh { content = { filter = new_filter } }
end

-- Set focused directory as current working directory
local set_cwd = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify 'Cursor is not on valid entry'
  end
  vim.fn.chdir(vim.fs.dirname(path))
end

-- Open path with system default handler (useful for non-text files)
local ui_open = function()
  vim.ui.open(MiniFiles.get_fs_entry().path)
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set('n', '<leader>bh', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle Hidden Files' })
    vim.keymap.set('n', '<leader>bS', set_cwd, { buffer = buf_id, desc = 'Set focused dir as CWD' })
    vim.keymap.set('n', '<leader>bO', ui_open, { buffer = buf_id, desc = 'Open file w/ system handler' })
  end,
})

-- f is for 'Fuzzy Find'
-- All these use 'mini.pick'. See `:h MiniPick-overview` for an overview.
local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'

nmap_leader('<leader>', fuzzy_at_root, 'Fuzzy')
nmap_leader('.', fuzzy_at_file, 'Fuzzy (at file)')
nmap_leader('/', '<Cmd>Pick grep_live<CR>', 'Grep live')
nmap_leader('\\', '<Cmd>Telescope zoxide list<CR>', 'Grep live')

-- TODO: implement zoxide int.
nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>', '"/" history')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>', '":" history')
nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>', 'Added hunks (all)')
nmap_leader('fA', pick_added_hunks_buf, 'Added hunks (buf)')
nmap_leader('fb', '<Cmd>Pick buffers<CR>', 'Buffers')
nmap_leader('fc', '<Cmd>Pick git_commits<CR>', 'Commits (all)')
nmap_leader('fC', '<Cmd>Pick git_commits path="%"<CR>', 'Commits (buf)')
nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>', 'Diagnostic workspace')
nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>', 'Diagnostic buffer')
nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep current word')
nmap_leader('fh', '<Cmd>Pick help<CR>', 'Help tags')
nmap_leader('fH', '<Cmd>Pick hl_groups<CR>', 'Highlight groups')
nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>', 'Lines (all)')
nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>', 'Lines (buf)')
nmap_leader('fm', '<Cmd>Pick git_hunks<CR>', 'Modified hunks (all)')
nmap_leader('fM', '<Cmd>Pick git_hunks path="%"<CR>', 'Modified hunks (buf)')
nmap_leader('fr', '<Cmd>Pick resume<CR>', 'Resume')
nmap_leader('fs', '<Cmd>Pick lsp scope="workspace_symbol"<CR>', 'Symbols workspace')
nmap_leader('fS', '<Cmd>Pick lsp scope="document_symbol"<CR>', 'Symbols document')

-- g is for 'Git'
nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at cursor')
xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at selection')

-- c is for 'Code'
local formatting_cmd = '<Cmd>lua require("conform").format({lsp_fallback=true})<CR>'
local inlay_hint_cmd = '<Cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>'
nmap('K', '<Cmd>lua require("pretty_hover").hover()<CR>')
nmap_leader('ca', "<Cmd>lua require('tiny-code-action').code_action()<CR>", 'Actions')
nmap_leader('cf', formatting_cmd, 'Format')
nmap('gI', '<Cmd>Glance implementations<CR>', 'Implementation')
nmap('gr', '<Cmd>Glance references<CR>', 'References')
nmap('gd', '<Cmd>Glance definitions<CR>', 'Source definition')
nmap('gt', '<Cmd>Glance type_definitions<CR>', 'Type definition')
nmap_leader('cH', inlay_hint_cmd, 'Toggle inlay hint')
nmap_leader('cr', '<Cmd>lua vim.lsp.buf.rename()<CR>', 'Rename')
nmap_leader('cd', '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostic popup')
nmap_leader('cv', '<Cmd>lua require("swenv.api").pick_venv()<CR>', 'Python switch venv')
nmap_leader('cn', '<Cmd>Navbuddy<CR>', 'Navbuddy')
xmap_leader('cf', formatting_cmd, 'Format selection')
nmap_leader('cg', '<Cmd>Neogen<CR>', 'Generate annotations')
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('i', '<C-l>', "<Cmd>lua require('neogen').jump_next()<CR>", opts)
vim.api.nvim_set_keymap('i', '<C-h>', "<Cmd>lua require('neogen').jump_prev()<CR>", opts)

-- m is for 'Map'
nmap_leader('mf', '<Cmd>lua MiniMap.toggle_focus()<CR>', 'Focus (toggle)')
nmap_leader('mr', '<Cmd>lua MiniMap.refresh()<CR>', 'Refresh')
nmap_leader('ms', '<Cmd>lua MiniMap.toggle_side()<CR>', 'Side (toggle)')
nmap_leader('mt', '<Cmd>lua MiniMap.toggle()<CR>', 'Toggle')

-- o is for 'Other'. Common usage:
-- - `<Leader>oz` - toggle between "zoomed" and regular view of current buffer
nmap_leader('ot', '<Cmd>lua MiniTrailspace.trim()<CR>', 'Trim trailspace')
nmap_leader('ot', '<cmd>SmartBackspaceToggle<CR>', 'Toggle Smart Backspace')
nmap_leader('of', function()
  vim.b.filler_begone = not vim.b.filler_begone
  vim.notify('filler_begone set to ' .. tostring(vim.b.filler_begone), vim.log.levels.INFO)
end, 'Toggle filler_begone (buffer)')

-- -- s is for 'Session'. Common usage:
-- -- - `<Leader>sn` - start new session
-- -- - `<Leader>sr` - read previously started session
-- -- - `<Leader>sd` - delete previously started session
-- local session_new = 'MiniSessions.write(vim.fn.input("Session name: "))'
-- nmap_leader('sd', '<Cmd>lua MiniSessions.select("delete")<CR>', 'Delete')
-- nmap_leader('sn', '<Cmd>lua ' .. session_new .. '<CR>',         'New')
-- nmap_leader('sr', '<Cmd>lua MiniSessions.select("read")<CR>',   'Read')
-- nmap_leader('sw', '<Cmd>lua MiniSessions.write()<CR>',          'Write current')

-- t is for 'Terminal'
vim.keymap.set({ 'n', 't' }, '<M-/>', '<Cmd>ToggleTerm<CR>', { desc = 'Toggle Terminal' })
nmap_leader('th', '<Cmd>horizontal term<CR>', 'Terminal (horizontal)')
nmap_leader('tv', '<Cmd>vertical term<CR>', 'Terminal (vertical)')
