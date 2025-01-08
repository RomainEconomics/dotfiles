return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    -- { "nushell/tree-sitter-nu", build = ":TSUpdate nu" },
  },
  build = ':TSUpdate',
  event = { 'BufRead', 'BufNewFile' },
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts

  opts = {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'nu',
      'query',
      'json',
      'go',
      'javascript',
      'typescript',
      'tsx',
      'yaml',
      'dockerfile',
      'vim',
      'vimdoc',
      'python',
      'go',
    },
    auto_install = true,
    highlight = {
      enable = true,
      disable = { 'nu' },
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['am'] = { query = '@function.outer', desc = 'Select outer function' },
          ['im'] = { query = '@function.inner', desc = 'Select inner function' },
          ['ac'] = { query = '@class.outer', desc = 'Select outer class' },
          ['ic'] = { query = '@class.inner', desc = 'Select inner class' },
          ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop' },
          ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },
        },
      },
      move = {
        enable = true,
        goto_next_start = {
          [']f'] = { query = '@function.outer', desc = 'Function start' },
          [']c'] = { query = '@class.outer', desc = 'Class start' },
          [']a'] = { query = '@parameter.inner', desc = 'Parameter start' },
          [']l'] = { query = '@loop.outer', desc = 'Loop start' },
          [']i'] = { query = '@conditional.outer', desc = 'Conditional start' },
        },
        goto_next_end = {
          [']F'] = { query = '@function.outer', desc = 'Function end' },
          [']C'] = { query = '@class.outer', desc = 'Class end' },
          [']A'] = { query = '@parameter.inner', desc = 'Parameter end' },
          [']L'] = { query = '@loop.outer', desc = 'Loop end' },
          [']I'] = { query = '@conditional.outer', desc = 'Conditional end' },
        },
        goto_previous_start = {
          ['[f'] = { query = '@function.outer', desc = 'Function start' },
          ['[c'] = { query = '@class.outer', desc = 'Class start' },
          ['[a'] = { query = '@parameter.inner', desc = 'Parameter start' },
          ['[l'] = { query = '@loop.outer', desc = 'Loop start' },
          ['[i'] = { query = '@conditional.outer', desc = 'Conditional start' },
        },
        goto_previous_end = {
          ['[F'] = { query = '@function.outer', desc = 'Function end' },
          ['[C'] = { query = '@class.outer', desc = 'Class end' },
          ['[A'] = { query = '@parameter.inner', desc = 'Parameter end' },
          ['[L'] = { query = '@loop.outer', desc = 'Loop end' },
          ['[I'] = { query = '@conditional.outer', desc = 'Conditional end' },
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

    vim.keymap.set({ 'n', 'x', 'o' }, 'q', ts_repeat_move.repeat_last_move)
    vim.keymap.set({ 'n', 'x', 'o' }, 'Q', ts_repeat_move.repeat_last_move_opposite)

    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr)
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr)
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr)
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr)
  end,
}
