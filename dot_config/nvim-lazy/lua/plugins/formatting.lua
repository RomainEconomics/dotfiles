return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ["python"] = { "ruff_format", "ruff_fix", "black" },
      ["rust"] = { "rustfmt" },
    },
  },
  -- opts = {
  --   formatters = {
  --     rufo = {
  --       command = "rufo",
  --     },
  --   },
  --   formatters_by_ft = {
  --     python = { "ruff_format" },
  --     json = { { "deno_fmt", "prettierd" } },
  --     markdown = { { "deno_fmt", "prettierd" } },
  --     lua = { "stylua" },
  --   },
  -- },
  -- keys = {
  --   {
  --     "<leader>lf",
  --     function()
  --       require("conform").format()
  --     end,
  --     desc = "Format",
  --   },
  -- },
  -- config = true,
}
