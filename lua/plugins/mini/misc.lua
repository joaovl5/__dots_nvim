require('mini.misc').setup()
-- Change current working directory based on the current file path. It
-- searches up the file tree until the first root marker ('.git' or 'Makefile')
-- and sets their parent directory as a current directory.
-- This is helpful when simultaneously dealing with files from several projects.
MiniMisc.setup_auto_root()

-- Restore latest cursor position on file open
MiniMisc.setup_restore_cursor()

-- Synchronize terminal emulator background with Neovim's background to remove
-- possibly different color padding around Neovim instance
MiniMisc.setup_termbg_sync()
