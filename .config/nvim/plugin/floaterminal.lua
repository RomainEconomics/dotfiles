local M = {}

local state = {
  floating = {
    win = -1,
    buf = -1,
  },
}

function M.create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a new buffer or use the existing one
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Define window configuration
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return {
    buf = buf,
    win = win,
  }
end

function M.toggle()
  if vim.api.nvim_win_is_valid(state.floating.win) then
    vim.api.nvim_win_hide(state.floating.win)
  else
    state.floating = M.create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  end
end

vim.api.nvim_create_user_command('FloatTerminal', function()
  M.create_floating_window()
end, {})

vim.api.nvim_create_user_command('FloatTerminalToggle', function()
  M.toggle()
end, {})

vim.keymap.set({ 'n', 't' }, '<leader>mm', M.toggle, { desc = 'Toggle Floating terminal' })
