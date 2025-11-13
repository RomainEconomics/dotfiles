local function html_to_text()
  local cmd = 'uv run /home/rjouhameau/dotfiles/.config/scripts/html_to_text.py --url'

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
    local success, _, exit_code = handle:close()

    if not success or exit_code ~= 0 then
      vim.notify('Command failed: ' .. result, vim.log.levels.ERROR)
      return
    end

    -- Get current buffer and cursor position
    local buf = vim.api.nvim_get_current_buf()
    local line_count = vim.api.nvim_buf_line_count(buf)

    -- Split the result into lines
    local lines = vim.split(result, '\n', { plain = true })

    -- Remove the last empty line if it exists
    if lines[#lines] == '' then
      table.remove(lines)
    end

    -- Append the lines to the buffer
    vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, lines)

    vim.notify('Content appended to buffer', vim.log.levels.INFO)
  end)
end

-- Add the keymap
keymap('n', '<leader>ht', html_to_text, { desc = 'Convert HTML URL to text and append to buffer' })
