local overseer = require('overseer')

-- Create a template for compiling and running C programs
overseer.register_template({
	name = 'C: Build and Run',
	builder = function(params)
		-- Get filename without extension
		local fname = vim.fn.expand('%:t:r')
		return {
			cmd = { 'bash' },
			args = { '-c', string.format('gcc -Wall %s -o %s && ./%s', vim.fn.expand('%'), fname, fname) },
			components = {
				{ 'on_output_quickfix', open = true },
				'default',
			},
		}
	end,
	condition = {
		filetype = { 'c' },
	},
})
