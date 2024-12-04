return {
  {
    'ramilito/kubectl.nvim',
    config = function()
      require('kubectl').setup()
      vim.cmd 'nmap k k' -- avoid line wrap
    end,
  },
}
