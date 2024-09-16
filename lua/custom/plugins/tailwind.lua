return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tailwindcsss = {
          filetypes = {
            'html',
            'typescriptreact',
            'javascriptreact',
            'css',
            'sass',
            'less',
          },
        },
      },
    },
  },
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
}
