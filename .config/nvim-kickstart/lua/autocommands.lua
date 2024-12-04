-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('user_close_with_q', { clear = true }),
  pattern = {
    'toggleterm',
    'gitgraph',
    'DiffviewFiles',
    'git-blame', -- custom type for the git blame cmd
    'Avente',
    'k8s_*',
  },
  callback = function(event)
    ---@type string|function
    local closeCommand = function()
      vim.api.nvim_buf_delete(event.buf, {})
    end
    if event.match == 'DiffviewFiles' then
      closeCommand = '<cmd>DiffviewClose<CR>'
      -- elseif event.match:match 'k8s_.*' ~= '' then
      --   closeCommand = function()
      --     require('kubectl').close()
      --   end
    else
      vim.bo[event.buf].buflisted = false
    end
    vim.keymap.set('n', 'q', closeCommand, { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  callback = function()
    if require('nvim-treesitter.parsers').has_parser() then
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    else
      vim.opt.foldmethod = 'syntax'
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})
