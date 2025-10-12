require('modules.lsp-helper').on_very_lazy(function()
	vim.filetype.add({
		extension = { mdx = 'markdown.mdx' },
	})
end)

return {
	{
		'stevearc/conform.nvim',
		opts = {
			formatters = {
				['markdown-toc'] = {
					condition = function(_, ctx)
						for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
							if line:find('<!%-%- toc %-%->') then return true end
						end
					end,
				},
				['markdownlint-cli2'] = {
					condition = function(_, ctx)
						local diag = vim.tbl_filter(function(d) return d.source == 'markdownlint' end, vim.diagnostic.get(ctx.buf))
						return #diag > 0
					end,
				},
			},
			formatters_by_ft = {
				['markdown'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
				['markdown.mdx'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
			},
		},
	},
	{
		'mason-org/mason.nvim',
		opts = { ensure_installed = { 'markdownlint-cli2', 'markdown-toc' } },
	},

	-- Markdown preview
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		build = function()
			require('lazy').load({ plugins = { 'markdown-preview.nvim' } })
			vim.fn['mkdp#util#install']()
		end,
		keys = {
			{
				'<leader>cp',
				ft = 'markdown',
				'<cmd>MarkdownPreviewToggle<cr>',
				desc = 'Markdown Preview',
			},
		},
		config = function() vim.cmd([[do FileType]]) end,
	},

	{
		'MeanderingProgrammer/render-markdown.nvim',
		opts = {
			code = {
				sign = false,
				width = 'block',
				right_pad = 1,
			},
			heading = {
				sign = false,
				icons = {},
			},
			completions = { lsp = { enabled = true }, blink = { enabled = true } },
		},
		ft = { 'markdown', 'norg', 'rmd', 'org' },
		-- config = function(_, opts)
		-- 	require('render-markdown').setup(opts)
		-- 	LazyVim.toggle.map('<leader>um', {
		-- 		name = 'Render Markdown',
		-- 		get = function() return require('render-markdown.state').enabled end,
		-- 		set = function(enabled)
		-- 			local m = require('render-markdown')
		-- 			if enabled then
		-- 				m.enable()
		-- 			else
		-- 				m.disable()
		-- 			end
		-- 		end,
		-- 	})
		-- end,
	},
	{
		-- 'bngarren/checkmate.nvim',
		-- ft = 'markdown', -- Lazy loads for Markdown files matching patterns in 'files'
		-- opts = {
		-- your configuration here
		-- or leave empty to use defaults
		-- files = { "todo", "TODO", "*.todo*" }, -- matches TODO, TODO.md, .todo.md
		-- files = { '*.md' },
		-- keys = {
		-- 	['<leader>mt'] = 'toggle', -- Toggle todo item
		-- 	['<leader>mc'] = 'check', -- Set todo item as checked (done)
		-- 	['<leader>mu'] = 'uncheck', -- Set todo item as unchecked (not done)
		-- 	['<leader>mn'] = 'create', -- Create todo item
		-- 	['<leader>mR'] = 'remove_all_metadata', -- Remove all metadata from a todo item
		-- 	['<leader>ma'] = 'archive', -- Archive checked/completed todo items (move to bottom section)
		-- },
		-- },
	},
}
