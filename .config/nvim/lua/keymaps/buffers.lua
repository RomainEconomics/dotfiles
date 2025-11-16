-- Buffer management keymaps
-- Note: Buffer navigation keymaps (<S-h>, <S-l>, [b, ]b) are defined in bufferline.lua

local keymap = vim.keymap.set

keymap('n', '<leader>bd', '<cmd>Bdelete<cr>', { desc = 'Delete Buffer' })
keymap('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })
