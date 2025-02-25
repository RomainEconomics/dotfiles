-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})

-- vim.api.nvim_create_autocmd('FileType', {
-- 	group = vim.api.nvim_create_augroup('user_close_with_q', { clear = true }),
-- 	pattern = {
-- 		'toggleterm',
-- 		'gitgraph',
-- 		'DiffviewFiles',
-- 		'git-blame', -- custom type for the git blame cmd
-- 		'Avente',
-- 		'k8s_*',
-- 	},
-- 	callback = function(event)
-- 		---@type string|function
-- 		local closeCommand = function() vim.api.nvim_buf_delete(event.buf, {}) end
-- 		if event.match == 'DiffviewFiles' then
-- 			closeCommand = '<cmd>DiffviewClose<CR>'
-- 			-- elseif event.match:match 'k8s_.*' ~= '' then
-- 			--   closeCommand = function()
-- 			--     require('kubectl').close()
-- 			--   end
-- 		else
-- 			vim.bo[event.buf].buflisted = false
-- 		end
-- 		vim.keymap.set('n', 'q', closeCommand, { buffer = event.buf, silent = true })
-- 	end,
-- })

vim.api.nvim_create_autocmd({ 'FileType' }, {
	callback = function()
		if require('nvim-treesitter.parsers').has_parser() then
			vim.opt.foldmethod = 'expr'
			vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
		else
			vim.opt.foldmethod = 'syntax'
		end
	end,
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then return end
		if client.name == 'ruff' then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = 'LSP: Disable hover capability from Ruff',
})

vim.api.nvim_create_user_command('WatchRun', function()
	local overseer = require('overseer')
	overseer.run_template({ name = 'run script' }, function(task)
		print('run script task', task)
		if task then
			task:add_component({ 'restart_on_save', paths = { vim.fn.expand('%:p') } })
			local main_win = vim.api.nvim_get_current_win()
			overseer.run_action(task, 'open vsplit')
			vim.api.nvim_set_current_win(main_win)
		else
			vim.notify('WatchRun not supported for filetype ' .. vim.bo.filetype, vim.log.levels.ERROR)
		end
	end)
end, {})
