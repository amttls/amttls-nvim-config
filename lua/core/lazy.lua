-- [[ Install `lazy.nvim` and its configuration ]]

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--[[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- colorscheme plugin + theme configuration
  require 'core.colorscheme',

  -- LSP Plugins

  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  -- used for completion, annotations and signatures of Neovim apis
  require 'kickstart.plugins.lazydev',
  -- Meta type definitions for the Lua platform Luvit
  require 'kickstart.plugins.luvid-meta',

  -- Main LSP Configuration
  require 'core.lsp',

  -- Detect tabstop and shiftwidth automatically
  require 'kickstart.plugins.vim-sleuth',

  -- Useful plugin to show you pending keybinds.
  require 'kickstart.plugins.which-key',

  -- Fuzzy Finder (files, lsp, etc)
  require 'kickstart.plugins.telescope',

  -- Autoformat
  require 'kickstart.plugins.autoformat',

  -- Autocompletion
  require 'kickstart.plugins.autocompletion',

  -- Highlight todo, notes, etc in comments
  require 'kickstart.plugins.todo-comments',

  -- Collection of various small independent plugins/modules
  require 'kickstart.plugins.mini',

  -- Highlight, edit, and navigate code
  require 'kickstart.plugins.treesitter',

  -- require 'kickstart.plugins.debug',

  -- Add indentation guides even on blank lines
  require 'kickstart.plugins.indent_line',

  -- Linting
  require 'kickstart.plugins.lint',

  -- autopairs
  require 'kickstart.plugins.autopairs',

  -- Neo-tree is a Neovim plugin to browse the file system
  require 'kickstart.plugins.neo-tree',

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  require 'kickstart.plugins.gitsigns',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
