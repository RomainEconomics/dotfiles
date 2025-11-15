return {
	'windwp/nvim-autopairs',
	event = 'InsertEnter',
	config = function()
		require('nvim-autopairs').setup({})
		-- Note: blink.cmp doesn't have official nvim-autopairs integration yet.
		-- For auto-bracket completion with blink.cmp, use its built-in auto_brackets feature.
	end,
}
