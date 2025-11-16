-- Utility keymaps and custom functions

local keymap = vim.keymap.set

-- LLM
keymap({ 'n', 'v' }, '<leader>zz', function() require('llm').llm_with_picker() end, { desc = 'Start LLM Chat with picker' })
keymap({ 'n', 'v' }, '<leader>zZ', function() require('llm').llm({ model = 'claude-sonnet-4-20250514' }) end, { desc = 'Start LLM Chat' })
keymap({ 'n', 'v' }, '<leader>zp', function() require('llm').llm_with_project() end, { desc = 'Start LLM Chat with project' })
keymap('n', '<leader>zh', function() require('llm').llm_with_history() end, { desc = 'Resume LLM Chat via history' })

-- Copilot
keymap('n', '<leader>cc', '<cmd>Copilot<cr>', { desc = 'Start Copilot' })

-- HTML to text converter
local function html_to_text()
	local config_dir = vim.fn.stdpath('config')
	local dotfiles_dir = vim.fn.fnamemodify(config_dir, ':h:h:h')
	local cmd = 'uv run ' .. dotfiles_dir .. '/.config/scripts/html_to_text.py --url'

	Snacks.input.input({
		prompt = 'Enter URL: ',
		default = '',
	}, function(url)
		if not url or url == '' then
			vim.notify('No URL provided', vim.log.levels.WARN)
			return
		end

		-- Build the full command
		local full_cmd = cmd .. ' "' .. url .. '"'

		-- Execute the command and capture output
		local handle = io.popen(full_cmd .. ' 2>&1')
		if not handle then
			vim.notify('Failed to execute command', vim.log.levels.ERROR)
			return
		end

		local result = handle:read('*a')
		local success, _, _ = handle:close()

		if not success then
			vim.notify('Command failed: ' .. result, vim.log.levels.ERROR)
			return
		end

		-- Simple cleaning: replace tabs and normalize line endings
		result = result:gsub('\t', '    ') -- Replace tabs with 4 spaces
		result = result:gsub('\r\n', '\n') -- Normalize Windows line endings
		result = result:gsub('\r', '\n') -- Handle old Mac line endings

		-- Get current buffer and cursor position
		local buf = vim.api.nvim_get_current_buf()
		local line_count = vim.api.nvim_buf_line_count(buf)

		-- Split the result into lines
		local lines = vim.split(result, '\n', { plain = true })

		-- Remove the last empty line if it exists
		if #lines > 0 and lines[#lines] == '' then table.remove(lines) end

		-- Only proceed if we have content to add
		if #lines > 0 then
			-- Append the lines to the buffer
			vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, lines)
			vim.notify('Content appended to buffer (' .. #lines .. ' lines)', vim.log.levels.INFO)
		else
			vim.notify('No valid content to append', vim.log.levels.WARN)
		end
	end)
end

-- PDF to text converter
local function pdf_to_text()
	local cmd = 'utils text'

	Snacks.input.input({
		prompt = 'Enter PDF filepath: ',
		default = '',
	}, function(filepath)
		if not filepath or filepath == '' then
			vim.notify('No filepath provided', vim.log.levels.WARN)
			return
		end

		-- Build the full command
		local full_cmd = cmd .. ' "' .. filepath .. '"'

		-- Execute the command and capture output
		local handle = io.popen(full_cmd .. ' 2>&1')
		if not handle then
			vim.notify('Failed to execute command', vim.log.levels.ERROR)
			return
		end

		local result = handle:read('*a')
		local success, _, _ = handle:close()

		if not success then
			vim.notify('Command failed: ' .. result, vim.log.levels.ERROR)
			return
		end

		-- Get current buffer and cursor position
		local buf = vim.api.nvim_get_current_buf()
		local line_count = vim.api.nvim_buf_line_count(buf)

		-- Split the result into lines
		local lines = vim.split(result, '\n', { plain = true })

		-- Remove the last empty line if it exists
		if #lines > 0 and lines[#lines] == '' then table.remove(lines) end

		-- Only proceed if we have content to add
		if #lines > 0 then
			-- Append the lines to the buffer
			vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, lines)
			vim.notify('Content appended to buffer (' .. #lines .. ' lines)', vim.log.levels.INFO)
		else
			vim.notify('No valid content to append', vim.log.levels.WARN)
		end
	end)
end

-- Add the keymaps
keymap('n', '<leader>ht', html_to_text, { desc = 'Convert HTML URL to text and append to buffer' })
keymap('n', '<leader>hp', pdf_to_text, { desc = 'Convert PDF to text and append to buffer' })
