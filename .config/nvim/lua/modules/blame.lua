local M = {}

-- Find the git project root
function M.find_git_root(buf)
	-- Try to find .git directory upwards from current buffer's path
	local path = vim.api.nvim_buf_get_name(buf)
	path = path ~= '' and vim.fs.dirname(path) or vim.uv.cwd()

	local git_root = vim.fs.find('.git', {
		path = path,
		upward = true,
		type = 'directory',
	})[1]

	return git_root and vim.fs.dirname(git_root) or nil
end

-- Git blame for current line
function M.blame_line(opts)
	opts = vim.tbl_deep_extend('force', {
		count = 5,
		filetype = 'git-blame',
		size = {
			width = 0.6,
			height = 0.6,
		},
		border = 'rounded',
		direction = 'float',
	}, opts or {})

	-- Get current cursor position and file
	local cursor = vim.api.nvim_win_get_cursor(0)
	local line = cursor[1]
	local file = vim.api.nvim_buf_get_name(0)

	-- Find git root
	local root = M.find_git_root(0)
	if not root then
		vim.notify('Not in a git repository', vim.log.levels.WARN)
		return
	end

	local cmd = 'git -C ' .. root .. ' log -n ' .. opts.count .. ' -u -L ' .. line .. ',+1:' .. file

	-- Create a new terminal with toggleterm
	local Terminal = require('toggleterm.terminal').Terminal
	local float_term = Terminal:new({
		cmd = cmd,
		hidden = true,
		direction = opts.direction,
		float_opts = {
			border = opts.border,
			width = math.floor(vim.o.columns * opts.size.width),
			height = math.floor(vim.o.lines * opts.size.height),
		},
		on_open = function(term)
			vim.cmd('startinsert!')
			vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
		end,
		on_close = function(_) vim.cmd('startinsert!') end,
	})

	float_term:toggle()
end

return M
