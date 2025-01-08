-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down' })
-- vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down' })
-- vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up' })
-- vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up' })

vim.keymap.set({ 'n', 'v' }, 'J', '5jzz', { desc = 'Move down 5 row at a time and center screen ' })
vim.keymap.set({ 'n', 'v' }, 'K', '5kzz', { desc = 'Move up 5 row at a time and center screen ' })

vim.keymap.set({ 'n', 'v' }, 'gh', '^', { desc = '[P]Go to the beginning line' })
vim.keymap.set({ 'n', 'v' }, 'gll', '$', { desc = '[P]go to the end of the line' })

-- vim.keymap.set({ 'n', 'v' }, '<leader>qq', '5kzz', { desc = 'Move up 5 row at a time and center screen ' })

-- Move Line
vim.keymap.set('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

vim.keymap.set('n', '<leader>e', function()
  require('mini.files').open()
end, { desc = 'Open File Explorer' })

vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- window management
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' }) -- split window vertically
vim.keymap.set('n', '<leader>wh', '<C-w>s', { desc = 'Split window horizontally' }) -- split window horizontally
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window' })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- buffers
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
vim.keymap.set('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>Bdelete<cr>', { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>cx', '<cmd>source %<cr>', { desc = 'Lazy' })

local blame = require 'modules.blame'

vim.keymap.set('n', '<leader>gb', function()
  blame.blame_line()
end, { desc = 'Git Blame' })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- Function to copy file path to clipboard
local function copy_filepath_to_clipboard()
  local filePath = vim.fn.expand '%:~' -- Gets the file path relative to the home directory
  vim.fn.setreg('+', filePath) -- Copy the file path to the clipboard register
  vim.notify(filePath, vim.log.levels.INFO)
  vim.notify('Path copied to clipboard: ', vim.log.levels.INFO)
end
-- Keymaps for copying file path to clipboard
-- vim.keymap.set("n", "<leader>fp", copy_filepath_to_clipboard, { desc = "[P]Copy file path to clipboard" })
-- I couldn't use <M-p> because its used for previous reference
vim.keymap.set({ 'n', 'v', 'i' }, '<M-c>', copy_filepath_to_clipboard, { desc = '[P]Copy file path to clipboard' })

vim.keymap.set('n', '<leader>cm', '<cmd>Mason<cr>', { desc = 'Open Mason' })

vim.keymap.set('n', '<leader>cH', function()
  require('telescope.builtin').find_files {
    cwd = '~/Documents/repos/cheat-sheet/cheat_sheet',
    hidden = true,
  }
end, { desc = 'Search Cheat Sheet files' })
