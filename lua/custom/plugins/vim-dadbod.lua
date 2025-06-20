-- vim-dadbod: Modern database interface for Vim
-- Provides a simple, consistent interface for interacting with databases
-- Supports multiple database types (PostgreSQL, MySQL, SQLite, etc.)
return {
  'tpope/vim-dadbod',
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      'tpope/vim-dadbod',
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = {
      'tpope/vim-dadbod',
      'hrsh7th/nvim-cmp',
    },
    ft = { 'sql', 'mysql', 'plsql' },
    init = function()
      -- Configure completion settings
      vim.g.db_completion_sql_omni = 1
    end,
  },
}
