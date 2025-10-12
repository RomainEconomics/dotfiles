-- return { -- Autocompletion
-- 	'hrsh7th/nvim-cmp',
-- 	event = 'InsertEnter',
-- 	dependencies = {
-- 		-- Snippet Engine & its associated nvim-cmp source
-- 		'saadparwaiz1/cmp_luasnip',
-- 		'hrsh7th/cmp-nvim-lsp',
-- 		'hrsh7th/cmp-buffer', -- source for text in buffer
-- 		'hrsh7th/cmp-path', -- source for file system paths
-- 		'hrsh7th/cmp-nvim-lsp-signature-help',
-- 		'onsails/lspkind.nvim', -- vs-code like pictograms
-- 	},
-- 	config = function()
-- 		-- See `:help cmp`
-- 		local cmp = require('cmp')
-- 		local ls = require('luasnip')
--
-- 		ls.filetype_extend('typescript', { 'javascript' })
--
-- 		cmp.setup({
-- 			snippet = {
-- 				expand = function(args) ls.lsp_expand(args.body) end,
-- 			},
-- 			completion = { completeopt = 'menu,menuone,noinsert' },
--
-- 			mapping = cmp.mapping.preset.insert({
-- 				['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
-- 				['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
-- 				['<C-p>'] = cmp.mapping.scroll_docs(-4),
-- 				['<C-n>'] = cmp.mapping.scroll_docs(4),
-- 				['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
-- 				['<C-e>'] = cmp.mapping.abort(), -- close completion window
-- 				['<CR>'] = cmp.mapping.confirm({ select = false }),
--
-- 				-- LuaSnip will expand the snippet, and place your cursor at $name.
-- 				-- <c-l> will move you to the right of each of the expansion locations.
-- 				-- <c-h> is similar, except moving you backwards.
-- 				['<C-l>'] = cmp.mapping(function()
-- 					if ls.expand_or_locally_jumpable() then ls.expand_or_jump() end
-- 				end, { 'i', 's' }),
-- 				['<C-h>'] = cmp.mapping(function()
-- 					if ls.locally_jumpable(-1) then ls.jump(-1) end
-- 				end, { 'i', 's' }),
--
-- 				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
-- 				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
-- 			}),
-- 			sources = {
-- 				{
-- 					name = 'lazydev',
-- 					-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
-- 					group_index = 0,
-- 				},
-- 				{ name = 'nvim_lsp' },
-- 				{ name = 'luasnip' },
-- 				{ name = 'render-markdown' },
-- 				{ name = 'path' },
-- 				{ name = 'nvim_lsp_signature_help' },
-- 			},
-- 		})
-- 	end,
-- }
return {
	'saghen/blink.cmp',
	event = 'VimEnter',
	-- optional: provides snippets for the snippet source
	dependencies = { 'rafamadriz/friendly-snippets', 'L3MON4D3/LuaSnip', 'folke/lazydev.nvim', 'mikavilpas/blink-ripgrep.nvim' },

	-- use a release tag to download pre-built binaries
	version = '1.*',
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = 'default',
			['<C-k>'] = { 'select_prev', 'fallback' },
			['<C-j>'] = { 'select_next', 'fallback' },
			['<C-n>'] = { 'scroll_documentation_down' },
			['<C-p>'] = { 'scroll_documentation_up' },
			['<CR>'] = { 'accept', 'fallback' },
			['<C-l>'] = { 'show_signature', 'hide_signature', 'fallback' },
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono',
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 100 },
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { 'snippets', 'lsp', 'buffer', 'path', 'lazydev', 'ripgrep' },

			per_filetype = {
				sql = { 'snippets', 'dadbod', 'buffer' },
			},
			providers = {
				lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
				dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
				ripgrep = {
					module = 'blink-ripgrep',
					name = 'Ripgrep',
					-- see the full configuration below for all available options
					---@module "blink-ripgrep"
					---@type blink-ripgrep.Options
					opts = {
						backend = {
							use = 'gitgrep-or-ripgrep',
						},
						prefix_min_len = 5,
					},
				},
			},
		},

		snippets = { preset = 'luasnip' },
		signature = { enabled = true },

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = 'prefer_rust_with_warning' },

		cmdline = {
			keymap = {

				['<C-k>'] = { 'select_prev', 'fallback' },
				['<C-j>'] = { 'select_next', 'fallback' },
			},
			completion = { menu = { auto_show = true } },
		},
	},
	opts_extend = { 'sources.default' },
}
