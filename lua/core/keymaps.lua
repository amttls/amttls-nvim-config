-- [[ Basic Keymaps ]]

--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Custom Keymaps

-- Exit INSERT mode with jk
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit INSERT mode with jk' })
-- Exit COMMAND mode with jk
vim.keymap.set('c', 'jk', '<ESC>', { desc = 'Exit COMMAND mode with jk' })
-- Toggle Zen Mode
vim.keymap.set('n', '<leader>tz', ':ZenMode<CR>', { desc = '[T]oggle [Z]en Mode' })
-- Go to previous file with Tab
vim.keymap.set('n', '<Tab>', '<C-^>', { desc = 'Go to previous file' })
-- Move visually highlighted
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
-- Copy to clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy selected lines to clipboard' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
