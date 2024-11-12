return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  -- 'folke/tokyonight.nvim',
  -- priority = 1000, -- Make sure to load this before all the other start plugins.
  -- init = function()
  --   -- Load the colorscheme here.
  --   -- Like many other themes, this one has different styles, and you could load
  --   -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --   vim.cmd.colorscheme 'tokyonight-storm'
  --
  --   -- You can configure highlights by doing something like:
  --   vim.cmd.hi 'Comment gui=none'
  -- end,
  --
  'Mofiqul/vscode.nvim',
  config = function()
    local c = require('vscode.colors').get_colors()
    require('vscode').setup {
      -- Alternatively set style in setup
      -- style = 'light'

      -- Override highlight groups (see ./lua/vscode/theme.lua)
      group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
      },
    }
    require('vscode').load()
  end,
  -- If colorscheme plugins are lazy loaded need to be higher prioritized (https://lazy.folke.io/spec/lazy_loading)
  lazy = false,
  priority = 1000,
}
