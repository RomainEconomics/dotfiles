-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local keymap = vim.keymap.set

-- Clear highlights on search
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear Search Highlights' })

-- Exit terminal mode
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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

-- Quit All
keymap('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

-- Save File
keymap({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- Window management
keymap('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
keymap('n', '<leader>wh', '<C-w>s', { desc = 'Split window horizontally' })
keymap('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window' })

-- Resize window
keymap('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
keymap('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
keymap('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
keymap('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Buffers
keymap('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
keymap('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
keymap('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
keymap('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
keymap('n', '<leader>bd', '<cmd>Bdelete<cr>', { desc = 'Delete Buffer' })
keymap('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })

-- Lazy
keymap('n', '<leader>ll', '<cmd>Lazy<cr>', { desc = 'Lazy' })
keymap('n', '<leader>cx', '<cmd>source %<cr>', { desc = 'Source Current File' })

-- Diagnostics
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function() go({ severity = severity }) end
end

keymap('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
keymap('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
keymap('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
keymap('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
keymap('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
keymap('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
keymap('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- Copy file path to clipboard
local function copy_filepath_to_clipboard()
	local filePath = vim.fn.expand('%:~')
	vim.fn.setreg('+', filePath)
	vim.notify('Path copied to clipboard: ' .. filePath, vim.log.levels.INFO)
end

keymap({ 'n', 'v', 'i' }, '<M-c>', copy_filepath_to_clipboard, { desc = 'Copy file path to clipboard' })

-- Mason
keymap('n', '<leader>cm', '<cmd>Mason<cr>', { desc = 'Open Mason' })

-- LLM
keymap({ 'n', 'v' }, '<leader>zz', function() require('llm').llm_with_picker() end, { desc = 'Start LLM Chat with picker' })
keymap({ 'n', 'v' }, '<leader>zZ', function() require('llm').llm({ model = 'claude-3-7-sonnet-20250219' }) end, { desc = 'Start LLM Chat' })
keymap('n', '<leader>zh', function() require('llm').llm_with_history() end, { desc = 'Start LLM Chat' })
