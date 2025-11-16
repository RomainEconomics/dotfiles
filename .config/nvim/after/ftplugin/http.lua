local keymap = vim.keymap.set
local opts = { buffer = 0, noremap = true, silent = true }

keymap('n', '<CR>', "<cmd>lua require('kulala').run()<cr>", vim.tbl_extend('force', opts, { desc = 'Execute the request' }))
keymap('n', '[', "<cmd>lua require('kulala').jump_prev()<cr>", vim.tbl_extend('force', opts, { desc = 'Jump to the previous request' }))
keymap('n', ']', "<cmd>lua require('kulala').jump_next()<cr>", vim.tbl_extend('force', opts, { desc = 'Jump to the next request' }))
keymap('n', '<leader>ci', "<cmd>lua require('kulala').inspect()<cr>", vim.tbl_extend('force', opts, { desc = 'Inspect the current request' }))
keymap('n', '<leader>ct', "<cmd>lua require('kulala').toggle_view()<cr>", vim.tbl_extend('force', opts, { desc = 'Toggle between body and headers' }))
keymap('n', '<leader>co', "<cmd>lua require('kulala').copy()<cr>", vim.tbl_extend('force', opts, { desc = 'Copy the current request as a curl command' }))
