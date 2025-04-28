return {
	'L3MON4D3/LuaSnip',
	-- follow latest release.
	version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = 'make install_jsregexp',
	dependencies = {
		-- `friendly-snippets` contains a variety of premade snippets.
		--    See the README about individual language/framework/plugin snippets:
		--    https://github.com/rafamadriz/friendly-snippets
		{
			'rafamadriz/friendly-snippets',
			config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
		},
	},

	config = function()
		local ts = require('nvim-treesitter')

		local ls = require('luasnip')
		ls.config.setup({
			enable_autosnippets = true,
			store_selection_keys = '<Tab>',
		})

		require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/luasnip-snippets' })
	end,
}
