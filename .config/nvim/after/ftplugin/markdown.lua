vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 80

vim.keymap.set('n', '<C-b>', 'ciw**<C-r>"**<Esc>', { buffer = true })
vim.keymap.set('v', '<C-b>', 'c**<C-r>"**<Esc>', { buffer = true })

vim.keymap.set('n', '<C-i>', 'ciw*<C-r>"*<Esc>', { buffer = true })
vim.keymap.set('v', '<C-i>', 'c*<C-r>"*<Esc>', { buffer = true })

-- Add the key mappings only for Markdown files in a zk notebook.
if require('zk.util').notebook_root(vim.fn.expand('%:p')) ~= nil then
	local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
	local opts = { noremap = true, silent = false }

	-- Open the link under the caret.
	map('n', '<CR>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

	-- Create a new note after asking for its title.
	-- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
	map(
		'n',
		'<leader>zn',
		"<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
		{ noremap = true, silent = false, desc = 'Create New ZK Note' }
	)

	-- Open notes linking to the current buffer.
	map('n', '<leader>zzb', '<Cmd>ZkBacklinks<CR>', opts)
	-- Alternative for backlinks using pure LSP and showing the source context.
	--map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
	-- Open notes linked by the current buffer.
	map('n', '<leader>zl', '<Cmd>ZkLinks<CR>', opts)

	-- Preview a linked note.
	map('n', '<C-k>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	-- Open the code actions for a visual selection.
	map('v', '<leader>zza', ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
end
