local add = MiniDeps.add

local function build_fff(params)
  vim.notify('Building FFF', vim.log.levels.INFO)
  local obj = vim.system({ 'cargo', 'build', '--release' }, { cwd = params.path }):wait()
  if obj.code == 0 then
    vim.notify('Building FFF done', vim.log.levels.INFO)
  else
    vim.notify('Building FFF failed', vim.log.levels.ERROR)
  end
end

add {
  source = 'dmtrKovalenko/fff.nvim',
  hooks = {
    post_install = build_fff,
    post_checkout = build_fff,
  },
}

require('fff').setup {
  prompt = '🌟 ',
  title = 'FIND FIND FIND',
  max_results = 50,
  max_threads = 8,
  layout = {
    height = 0.8,
    width = 0.8,
    prompt_position = 'top',
    preview_position = 'right',
    preview_size = 0.6,
  },
}

return {}
