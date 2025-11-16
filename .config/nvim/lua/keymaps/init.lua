local keymap = vim.keymap.set

-- Clear highlights on search
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear Search Highlights' })

-- Exit terminal mode
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Quick movement
keymap({ 'n', 'v' }, 'J', '5jzz', { desc = 'Move down 5 rows and center' })
keymap({ 'n', 'v' }, 'K', '5kzz', { desc = 'Move up 5 rows and center' })
keymap({ 'n', 'v' }, 'gh', '^', { desc = 'Go to the beginning line' })
keymap({ 'n', 'v' }, 'gl', '$', { desc = 'Go to the end of the line' })

-- To keep ? or not ?
keymap({ 'n', 'v' }, 'dh', 'd^', { desc = 'Delete to the beginning line' })
keymap({ 'n', 'v' }, 'dl', 'd$', { desc = 'Delete to the end of the line' })
keymap({ 'n', 'v' }, 'ch', 'c^', { desc = 'Delete and Insert to the beginning line' })
keymap({ 'n', 'v' }, 'cl', 'c$', { desc = 'Delete and Insert to the end of the line' })

-- Move lines
keymap('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
keymap('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
keymap('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
keymap('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
keymap('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
keymap('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- File Explorer
keymap('n', '<leader>e', function() require('mini.files').open() end, { desc = 'Open File Explorer' })
keymap('n', '<leader>E', function() require('mini.files').open(vim.api.nvim_buf_get_name(0)) end, { desc = 'Open File Explorer from file' })

-- Quit All
keymap('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

-- Save File
keymap({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- Lazy
keymap('n', '<leader>ll', '<cmd>Lazy<cr>', { desc = 'Lazy' })
keymap('n', '<leader>cx', '<cmd>source %<cr>', { desc = 'Source Current File' })
keymap('n', '<leader>cw', ':WatchRun<CR>', { desc = 'Watch and Run Script' })

-- Mason
keymap('n', '<leader>cm', '<cmd>Mason<cr>', { desc = 'Open Mason' })

-- Copy file path to clipboard
local function copy_filepath_to_clipboard()
	local filePath = vim.fn.expand('%:~')
	vim.fn.setreg('+', filePath)
	vim.notify('Path copied to clipboard: ' .. filePath, vim.log.levels.INFO)
end

keymap({ 'n', 'v', 'i' }, '<M-c>', copy_filepath_to_clipboard, { desc = 'Copy file path to clipboard' })

-- Git worktrees
keymap('n', '<leader>gws', function() Snacks.picker.worktrees() end)
keymap('n', '<leader>gwn', function() Snacks.picker.worktrees_new() end)
keymap('n', '<leader>go', function() require('mini.diff').toggle_overlay(0) end)

-- Load submodules
require('keymaps.buffers')
require('keymaps.windows')
require('keymaps.diagnostics')
require('keymaps.utils')

-- Quit All
keymap('n', '<leader>qQ', function() require('quicker').toggle() end, { desc = 'Toggle Quicklist' })
keymap('n', '<leader>ql', function() require('quicker').toggle({ loclist = true }) end, { desc = 'Toggle Quicklist' })
