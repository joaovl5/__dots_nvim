-- Set up to not prefer extension-based icon for some extensions
local ext3_blocklist = { scm = true, txt = true, yml = true }
local ext4_blocklist = { json = true, yaml = true }
require('mini.icons').setup {
  use_file_extension = function(ext, _)
    return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
  end,
}
-- todo lazy load
MiniIcons.mock_nvim_web_devicons()
MiniIcons.tweak_lsp_kind()
