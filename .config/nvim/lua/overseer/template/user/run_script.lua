return {
  name = 'run script',
  builder = function()
    vim.notify('Run Script Build', vim.log.INFO)
    local file = vim.fn.expand '%:p'
    local cmd = { file }
    vim.notify(file, vim.log.INFO)
    if vim.bo.filetype == 'go' then
      cmd = { 'go', 'run', file }
    end
    return {
      cmd = cmd,
      components = {
        { 'on_output_quickfix', set_diagnostics = true },
        'on_result_diagnostics',
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'sh', 'python', 'go' },
  },
}
