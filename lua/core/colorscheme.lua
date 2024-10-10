-- [[ colorscheme.lua  ]]
return {
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'rebelot/kanagawa.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = true,
  init = function()
    -- Load the colorscheme here.
    vim.o.termguicolors = true
    vim.o.background = 'dark' -- or "light" for light mode
    require('kanagawa').setup {
      transparent = true,
      statementStyle = { bold = false },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          Boolean = { fg = theme.syn.constant, bold = false },
          ['@lsp.typemod.function.readonly'] = { fg = theme.syn.fun, bold = false },
        }
      end,
    }

    vim.cmd [[colorscheme kanagawa]]
  end,
}
