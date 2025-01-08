local M = {}

function M.setup()
  vim.notify('prez.lua setup', 'info', {})
end

-- M.setup()
-- return M

local state = {
  parsed = {},
  current_slide = 1,
  floats = {},
}

function M.create_floating_window(opts)
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, opts)

  return {
    buf = buf,
    win = win,
  }
end

---@class prez.Slides
---@field slides present.Slide[]

---@class present.Slide
---@field title string
---@field body string[]
---@field blocks string[]

---@return present.Slide
local build_slide = function()
  return {
    title = nil,
    body = {},
    blocks = {},
  }
end

---@return table vim.api.keyset.win_config[]
local create_config_windows = function()
  local width = vim.o.columns
  local height = vim.o.lines

  local header_height = 1 -- 1 for the header and 2 for the border
  local footer_height = 1 -- 1 for the footer and no border
  local body_height = height - header_height - footer_height - 4 -- 2 for the border

  return {
    background = {
      relative = 'editor',
      width = width,
      height = height,
      style = 'minimal',
      col = 0,
      row = 0,
      zindex = 1,
    },

    header = {
      relative = 'editor',
      width = width,
      height = header_height,
      style = 'minimal',
      border = 'rounded',
      col = 0,
      row = 0,
      zindex = 2,
    },
    body = {
      relative = 'editor',
      width = width - 8,
      height = body_height,
      style = 'minimal',
      border = { '', '', '', '', '', '', '', '' },
      col = 8,
      row = 4,
      zindex = 2,
    },
    footer = {
      relative = 'editor',
      width = width,
      height = footer_height,
      style = 'minimal',
      col = 0,
      row = height - 1,
      zindex = 2,
    },
  }
end

---Take a list of strings from a buffer and parse them into slides
---@param lines string[]
---@return prez.Slides
local parse_slides = function(lines)
  local slides = { slides = {} }
  local current_slide = build_slide()
  local separator = '---'

  for _, line in ipairs(lines) do
    -- 1. Check if the line is a separator, if it is, then we start a new slide
    -- 2. If the line is not a separator, then we add it to the current slide
    if line == separator then
      if #current_slide.title > 0 then
        table.insert(slides.slides, current_slide)
      end

      current_slide = build_slide()
    else
      -- 1. Take first not empty lines as title
      -- 2. Next lines are added to the body slide
      if current_slide.title == nil then
        if line ~= '' then
          current_slide.title = line
        end
      else
        table.insert(current_slide.body, line)
      end
    end
  end

  if #current_slide.title > 0 then
    table.insert(slides.slides, current_slide)
  end

  return slides
end

local set_slide_content = function(idx)
  local slide = state.parsed.slides[idx]
  local width = vim.o.columns
  local padding = string.rep(' ', (width - #slide.title) / 2)
  local title = padding .. slide.title
  local footer = string.format('%d | %d', state.current_slide, #state.parsed.slides)

  vim.api.nvim_buf_set_lines(state.floats.header.buf, 0, 1, false, { title })
  vim.api.nvim_buf_set_lines(state.floats.body.buf, 1, -1, false, state.parsed.slides[idx].body)
  vim.api.nvim_buf_set_lines(state.floats.footer.buf, 0, -1, false, { footer })
end

local set_prez_keymaps = function()
  vim.keymap.set('n', 'n', function()
    state.current_slide = math.min(state.current_slide + 1, #state.parsed.slides)
    set_slide_content(state.current_slide)
  end, { buffer = state.floats.body.buf })

  vim.keymap.set('n', 'p', function()
    state.current_slide = math.max(state.current_slide - 1, 1)
    set_slide_content(state.current_slide)
  end, { buffer = state.floats.body.buf })

  vim.keymap.set('n', 'q', function()
    -- The other windows are closed using `BufLeave` event
    vim.api.nvim_win_close(state.floats.body.win, true)
  end, { buffer = state.floats.body.buf })
end

local for_each_float = function(cb)
  for name, float in pairs(state.floats) do
    cb(name, float)
  end
end

function M.start_prez(opts)
  opts = opts or {}
  opts.buf = opts.buf or 0
  local lines = vim.api.nvim_buf_get_lines(opts.buf, 0, -1, false)
  state.parsed = parse_slides(lines)

  local windows = create_config_windows()

  state.floats.background = M.create_floating_window(windows.background)
  state.floats.header = M.create_floating_window(windows.header)
  state.floats.footer = M.create_floating_window(windows.footer)
  state.floats.body = M.create_floating_window(windows.body)

  for_each_float(function(_, float)
    vim.bo[float.buf].filetype = 'markdown'
  end)

  set_prez_keymaps()

  set_slide_content(state.current_slide)

  local restore = {
    cmdheight = {
      original = vim.o.cmdheight,
      present = 0,
    },
  }

  -- Set the options for presentation mode
  for option, config in pairs(restore) do
    vim.o[option] = config.present
  end

  vim.api.nvim_create_autocmd('BufLeave', {
    buffer = state.floats.body.buf,
    callback = function()
      vim.notify('Buffer left', 'info', {})

      -- Restore the original options
      for option, config in pairs(restore) do
        vim.o[option] = config.original
      end

      for_each_float(function(_, float)
        pcall(vim.api.nvim_win_close, float.win, true)
      end)
    end,
  })

  vim.api.nvim_create_autocmd('VimResized', {
    -- When resizing the terminal, rerender the slide
    group = vim.api.nvim_create_augroup('prez-resized', {}),
    callback = function()
      if not vim.api.nvim_win_is_valid(state.floats.body.win) or state.floats.body.win == nil then
        return
      end

      local updated_config = create_config_windows()

      for_each_float(function(name, float)
        vim.api.nvim_win_set_config(float.win, updated_config[name])
      end)

      set_slide_content(state.current_slide)
    end,
  })
end
-- parse_slides {
--   '## First',
--   'Hello',
--   'World',
--   '---',
--   '# Second Slide',
--   'World',
--   'aa---',
-- }

-- echo nvim_get_current_buf()
vim.keymap.set('n', '<leader>cP', M.start_prez, { desc = 'Start prez' })
-- M.start_prez { buf = 53 }
