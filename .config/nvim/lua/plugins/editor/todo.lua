return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      '<leader>st',
      function()
        Snacks.picker.todo_comments()
      end,
      desc = 'Todo',
    },
    {
      '<leader>sT',
      function()
        Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
      end,
      desc = 'Todo/Fix/Fixme',
    },
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

    todo.setup(opts)
  end,
}
