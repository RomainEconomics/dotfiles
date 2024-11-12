return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.files').setup {
      windows = {
        preview = true,
        width_focus = 50,
        -- Width of non-focused window
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 75,
      },
    }

    require('mini.ai').setup { n_lines = 500 }

    -- require('mini.indentscope').setup()

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      mappings = {
        add = 'ma', -- Add surrounding in Normal and Visual modes
        delete = 'md', -- Delete surrounding
        replace = 'mr', -- Replace surrounding
        -- find = 'mf', -- Find surrounding (to the right)
        -- find_left = 'mF', -- Find surrounding (to the left)
        -- highlight = 'mh', -- Highlight surrounding
        -- update_n_lines = 'mn', -- Update `n_lines`
      },
    }

    require('mini.pairs').setup {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { 'string' },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    }

    require('mini.splitjoin').setup {
      keys = {
        {
          'gS',
          function()
            require('mini.splitjoin').toggle()
          end,
          desc = 'Split/join arrays, argument lists, etc. from one vs. multiline and vice versa',
        },
      },
    }

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}