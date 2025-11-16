return {
	'sindrets/diffview.nvim',
	cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
	opts = {
		keymaps = {
			view = {
				q = '<cmd>DiffviewClose<CR>',
			},
		},
	},
	keys = {
		{ '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView Open' },
		-- { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = 'DiffView Close' },
		{ '<leader>gF', '<cmd>DiffviewFileHistory %<CR>', desc = 'File History (This)', mode = 'n' },
		-- { '<leader>gF', '<cmd>DiffviewFileHistory<CR>', desc = 'File History (All)', mode = 'n' },
	},
}
