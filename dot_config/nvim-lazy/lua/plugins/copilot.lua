return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = false,
      keymap = {
        accept = "<c-o>",
        next = "<c-j>",
        prev = "<c-k>",
        dismiss = "<c-h>",
      },
    },
    panel = { enabled = true },
    filetypes = {
      yaml = true,
      go = true,
      lua = true,
      markdown = true,
      python = true,
      javascript = true,
      typescript = true,
      rust = true,
      help = true,
    },
  },
}
