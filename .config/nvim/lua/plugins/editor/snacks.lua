return {
  'folke/snacks.nvim',
  lazy = false,
  opts = {
    debug = { enabled = true },
    notifier = { enabled = true },
    rename = { enabled = true },
  },
  keys = {
    {
      '<leader>ch',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Show Notification History',
    },
    {
      '<leader>cR',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename File',
    },
  },
}
