---@module 'snacks'
return {
	'folke/snacks.nvim',
	lazy = false,
	priority = 1000,
	---@type snacks.Config
	opts = {
		debug = { enabled = true },
		notifier = { enabled = true },
		rename = { enabled = true },
		gitbrowse = { enabled = true },
		image = { enabled = true },
		picker = {
			enabled = true,
			win = {
				input = {
					keys = {
						['<C-n>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
						['<C-p>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
					},
				},
			},
		},
	},
	-- Snacks.picker.grep()
	-- To search for particular files: when searching, do `<C-g>` to switch to live models
	-- `lua$` to look for lua files, `<C-g>` again to go back to previous mode
	keys = {
		--
		-- Snacks
		--
		{ '<leader>ch', function() Snacks.notifier.show_history() end, desc = 'Show Notification History' },
		{ '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
		{ '<leader>gB', function() Snacks.git.blame_line() end, desc = 'Git Blame Line' },
		{ '<leader>gR', function() Snacks.gitbrowse() end, desc = 'Browse Git Repo' },
		{ '<leader>gg', function() Snacks.terminal('lazygit') end, desc = 'Open Lazygit' },

		--
		-- Pickers
		--
		{
			'<leader><leader>',
			function() Snacks.picker.smart({ hidden = true, filter = { cwd = true } }) end,
			desc = 'Find Files (Smart)',
		},
		{ '<leader>sb', function() Snacks.picker.buffers({ layout = { preset = 'ivy' } }) end, desc = 'Buffers' },
		{ '<leader>su', function() Snacks.picker.undo({ layout = { preset = 'ivy' } }) end, desc = 'Undo' },

		-- Find
		{ '<leader>fb', function() Snacks.picker.buffers({ layout = { preset = 'ivy' } }) end, desc = 'Buffers' },
		{ '<leader>ff', function() Snacks.picker.files({ hidden = true }) end, desc = 'Find Files' },
		{ '<leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, desc = 'Find Config File' },
		{ '<leader>fg', function() Snacks.picker.git_files() end, desc = 'Find Git Files' },
		{ '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent' },
		-- Git
		{ '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Log' },
		{ '<leader>gc', function() Snacks.picker.git_log() end, desc = 'Git Log' },
		{ '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
		-- Grep
		{ '<leader>sl', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
		{ '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
		{ '<leader>sg', function() Snacks.picker.grep({ hidden = true }) end, desc = 'Grep' },
		{
			'<leader>sw',
			function() Snacks.picker.grep_word({ hidden = true }) end,
			desc = 'Visual selection or word',
			mode = { 'n', 'x' },
		},
		-- Search
		{ '<leader>s"', function() Snacks.picker.registers() end, desc = 'Registers' },
		{ '<leader>sa', function() Snacks.picker.autocmds() end, desc = 'Autocmds' },
		{ '<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
		{ '<leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
		{ '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
		{ '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
		{ '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
		{ '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
		{ '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
		{ '<leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List' },
		{ '<leader>sm', function() Snacks.picker.man() end, desc = 'Man Pages' },
		{ '<leader>sM', function() Snacks.picker.marks() end, desc = 'Marks' },
		{ '<leader>sr', function() Snacks.picker.resume() end, desc = 'Resume' },
		{ '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
		{ '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },
		{ '<leader>qp', function() Snacks.picker.projects() end, desc = 'Projects' },
		-- LSP
		{ 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
		-- { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
		{ 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
		{ 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
		{ '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
		-- Others
		{
			'<leader>cH',
			function() Snacks.picker.files({ cwd = '~/Documents/repos/cheat-sheet/cheat_sheet' }) end,
			desc = 'Find Cheat Sheet',
		},
	},
	init = function()
		vim.api.nvim_create_autocmd('User', {
			pattern = 'VeryLazy',
			callback = function()
        -- stylua: ignore start
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>un")
        Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("<leader>uC")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.dim():map("<leader>uD")
				-- stylua: ignore end
			end,
		})
	end,
}
