return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function(_, opts)
    local todo = require 'todo-comments'

    vim.keymap.set('n', ']t', function()
      todo.jump_next()
    end, { desc = 'Next todo comment' })

    vim.keymap.set('n', '[t', function()
      todo.jump_prev()
    end, { desc = 'Previous todo comment' })

    -- You can also specify a list of valid jump keywords
    -- vim.keymap.set("n", "]t", function()
    --   todo.jump_next({keywords = { "ERROR", "WARNING" }})
    -- end, { desc = "Next error/warning todo comment" })

    vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<cr>', { desc = 'Toggle todo comment' })

    todo.setup(opts)
  end,
}
