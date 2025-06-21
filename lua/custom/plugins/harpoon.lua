return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    }

    -- Basic telescope configuration for harpoon (optional)
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    -- Keymaps
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon [a]dd file' })
    vim.keymap.set('n', '\\', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon quick menu' })
    vim.keymap.set('n', '<leader>ht', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[H]arpoon [t]elescope' })

    -- Navigate to specific files
    vim.keymap.set('n', '<leader>h1', function()
      harpoon:list():select(1)
    end, { desc = '[H]arpoon file [1]' })
    vim.keymap.set('n', '<leader>h2', function()
      harpoon:list():select(2)
    end, { desc = '[H]arpoon file [2]' })
    vim.keymap.set('n', '<leader>h3', function()
      harpoon:list():select(3)
    end, { desc = '[H]arpoon file [3]' })
    vim.keymap.set('n', '<leader>h4', function()
      harpoon:list():select(4)
    end, { desc = '[H]arpoon file [4]' })

    -- Navigate between harpoon files
    vim.keymap.set('n', '<leader>hp', function()
      harpoon:list():prev()
    end, { desc = '[H]arpoon [p]rev' })
    vim.keymap.set('n', '<leader>hn', function()
      harpoon:list():next()
    end, { desc = '[H]arpoon [n]ext' })
  end,
}
