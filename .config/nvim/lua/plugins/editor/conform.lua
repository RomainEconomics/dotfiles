return { -- Autoformat
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	keys = {
		{
			'<leader>f',
			function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
			mode = '',
			desc = '[F]ormat buffer',
		},
		{
			'<leader>uf',
			function()
				-- If autoformat is currently disabled for this buffer,
				-- then enable it, otherwise disable it
				if vim.b.disable_autoformat then
					vim.b.disable_autoformat = false
					vim.notify('Enabled autoformat for current buffer')
				else
					vim.b.disable_autoformat = true
					vim.notify('Disabled autoformat for current buffer')
				end
			end,
			desc = 'Toggle autoformat for current buffer',
		},
		-- {
		-- 	'<leader>uF',
		-- 	function()
		-- 		-- If autoformat is currently disabled globally,
		-- 		-- then enable it globally, otherwise disable it globally
		-- 		if vim.g.disable_autoformat then
		-- 			vim.cmd('FormatEnable')
		-- 			vim.notify('Enabled autoformat globally')
		-- 		else
		-- 			vim.cmd('FormatDisable')
		-- 			vim.notify('Disabled autoformat globally')
		-- 		end
		-- 	end,
		-- 	desc = 'Toggle autoformat globally',
		-- },
	},
	opts = {
		notify_on_error = false,
		-- format_on_save = function(bufnr)
		--   -- Disable "format_on_save lsp_fallback" for languages that don't
		--   -- have a well standardized coding style. You can add additional
		--   -- languages here or re-enable it for the disabled ones.
		--   -- local disable_filetypes = { c = true, cpp = true }
		--   local lsp_format_opt
		--   if disable_filetypes[vim.bo[bufnr].filetype] then
		--     lsp_format_opt = 'never'
		--   else
		--     lsp_format_opt = 'fallback'
		--   end
		--   return {
		--     timeout_ms = 500,
		--     lsp_format = lsp_format_opt,
		--   }
		-- end,
		formatters_by_ft = {
			lua = { 'stylua' },
			rust = { 'rustfmt' },
			toml = { 'taplo' },
			-- python = { 'ruff' },
			python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
			javascript = { 'prettier' },
			javascriptreact = { 'prettier' },
			typescript = { 'prettier' },
			typescriptreact = { 'prettier' },
			css = { 'prettier' },
			scss = { 'prettier' },
			html = { 'prettier' },
			json = { 'prettier' },
			yaml = { 'prettier' },
			markdown = { 'prettier' },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },

			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
		},
		format_on_save = function(buf)
			if vim.g.disable_autoformat or vim.b[buf].disable_autoformat then return end
			return { timeout_ms = 500, lsp_fallback = true, format_after_save = true }
		end,
	},
}
