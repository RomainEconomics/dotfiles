return {
  'Mofiqul/vscode.nvim',
  config = function()
    local c = require('vscode.colors').get_colors()
    require('vscode').setup {
      group_overrides = {
        Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
        SnacksPickerDir = { fg = '#D7BA7D' },
      },
    }
    require('vscode').load()
  end,
  lazy = false,
  priority = 1000,
}
