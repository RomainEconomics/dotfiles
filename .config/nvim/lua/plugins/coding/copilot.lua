return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		build = ':Copilot auth',
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 75,
				keymap = {
					accept = '<M-l>',
					accept_word = '<M-]>',
					-- accept_line = '<M-]',
					next = '<M-n>',
					prev = '<M-p>',
					dismiss = '<C-]>',
				},
			},
			panel = { enabled = false },
			filetypes = {
				['*'] = true,
				-- yaml = true,
				-- go = true,
				-- lua = true,
				-- markdown = true,
				-- python = true,
				-- r = true,
				-- javascript = true,
				-- typescript = true,
				-- rust = true,
				help = true,
			},
		},
		config = function(_, opts)
			local copilot = require('copilot')
			copilot.setup(opts)

			vim.keymap.set('n', '<leader>cc', function()
				require('copilot.suggestion').toggle_auto_trigger()
				local on_off = (vim.b.copilot_suggestion_auto_trigger and 'on') or 'off'
				vim.notify('Copilot suggestion: ' .. on_off, vim.log.levels.INFO)
			end, { desc = 'Toggle Copilot' })
		end,
	},

	-- copilot cmp source
	-- {
	--   'nvim-cmp',
	--   dependencies = {
	--     {
	--       'zbirenbaum/copilot-cmp',
	--       dependencies = 'copilot.lua',
	--       opts = {},
	--       config = function(_, opts)
	--         local copilot_cmp = require 'copilot_cmp'
	--         copilot_cmp.setup(opts)
	--         -- attach cmp source whenever copilot attaches
	--         -- fixes lazy-loading issues with the copilot cmp source
	--         LazyVim.lsp.on_attach(function(client)
	--           copilot_cmp._on_insert_enter {}
	--         end, 'copilot')
	--       end,
	--     },
	--   },
	--   opts = function(_, opts)
	--     table.insert(opts.sources, 1, {
	--       name = 'copilot',
	--       group_index = 1,
	--       priority = 100,
	--     })
	--   end,
	-- },
}
