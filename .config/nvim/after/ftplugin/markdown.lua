vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 80

vim.keymap.set('n', '<C-b>', 'ciw**<C-r>"**<Esc>', { buffer = true })
vim.keymap.set('v', '<C-b>', 'c**<C-r>"**<Esc>', { buffer = true })

vim.keymap.set('n', '<C-i>', 'ciw*<C-r>"*<Esc>', { buffer = true })
vim.keymap.set('v', '<C-i>', 'c*<C-r>"*<Esc>', { buffer = true })
