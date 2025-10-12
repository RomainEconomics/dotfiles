return {
	{
		'FabijanZulj/blame.nvim',
		-- `:BlameToggle`
		lazy = false,
		config = function() require('blame').setup({}) end,
	},
}
