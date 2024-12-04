return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change a keymap
    -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
    -- disable a keymap
    keys[#keys + 1] = { "K", false } -- disable bc used for navigation already
    keys[#keys + 1] = { "<c-k>", false, mode = { "i" } } -- use for copilot, gK still available in normal mode
    -- add a keymap
    keys[#keys + 1] = { "<c-K>", vim.lsp.buf.hover, desc = "Hover" }
  end,

  opts = {
    inlay_hints = {
      enabled = false,
    },

    servers = {
      lua_ls = {
        settings = {
          Lua = {
            hint = { enable = true },
          },
        },
      },
      taplo = {
        keys = {}, -- overwrite the keymap added by lazyvim.plugins.extras.lang.rust which add a "K", which I already map
        -- keys = {
        --   "K",
        --   false,
        --   desc = "Disable whatever it does",
        -- },
      },
    },
  },
}
