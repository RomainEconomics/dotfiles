return {
	name = 'run script',
	builder = function()
		local file = vim.fn.expand('%:p')
		local filename = vim.fn.expand('%:r')
		local cmd = { file }
		local args = {}

		if vim.bo.filetype == 'go' then
			cmd = { 'go', 'run', file }
		elseif vim.bo.filetype == 'c' then
			cmd = { 'bash' }
			args = { '-c', string.format('gcc -g -Wall %s -o %s && %s', file, filename, filename) }
		elseif vim.bo.filetype == 'zig' then
			cmd = { 'zig', 'run', file }
		elseif vim.bo.filetype == 'nu' then
			cmd = { 'nu', file }
		elseif vim.bo.filetype == 'python' then
			cmd = { 'uv', 'run', file }
		elseif vim.bo.filetype == 'typescript' then
			cmd = { 'bun', 'run', file }
		end
		return {
			cmd = cmd,
			args = args,
			components = {
				{ 'on_output_quickfix', set_diagnostics = true },
				'on_result_diagnostics',
				'default',
			},
		}
	end,
	condition = {
		filetype = { 'sh', 'go', 'c', 'nu', 'python', 'zig', 'typescript' },
	},
}
