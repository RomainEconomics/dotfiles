return {
  { 'towolf/vim-helm', ft = 'helm' },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'helm' } },
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        helm_ls = {},
      },
      setup = {
        yamlls = function()
          local helper_lsp = require 'modules.lsp-helper'
          helper_lsp.on_attach(function(client, buffer)
            if vim.bo[buffer].filetype == 'helm' then
              vim.schedule(function()
                vim.cmd 'LspStop ++force yamlls'
              end)
            end
          end, 'yamlls')
        end,
      },
    },
  },
}
