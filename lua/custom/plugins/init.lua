-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'christoomey/vim-tmux-navigator', -- tmux & split window navigation
  require 'custom.plugins.trouble',
  require 'custom.plugins.tailwind',
  require 'custom.plugins.zen-mode',
  require 'custom.plugins.autotag',
  require 'custom.plugins.comments',
  require 'custom.plugins.file-operations',
  require 'custom.plugins.greeter',
}
