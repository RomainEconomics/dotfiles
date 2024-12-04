return {
  "mfussenegger/nvim-dap-python",
  -- stylua: ignore
  keys = {
    { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
    { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
  },
  config = function()
    -- local path = require("mason-registry").get_package("debugpy"):get_install_path()
    -- require("dap-python").setup(path .. "/venv/bin/python")

    local dap = require("dap")

    require("dap-python").setup("/home/rjouhameau/.local/share/nvim-lazy/mason/packages/debugpy/venv/bin/python")
    -- require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

    table.insert(require("dap").configurations.python, {
      type = "python",
      request = "launch",
      name = "My custom launch configuration",
      program = "${workspaceFolder}",
      -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
    })

    --         local dap_python_path = "/home/rjouhameau/.local/share/nvim-lazy/mason/packages/debugpy/venv/bin/python"
    -- vim.api.nvim_echo({ { "Using path for dap-python: " .. dap_python_path, "None" } }, false, {})
    --
    -- require("dap-python").setup(dap_python_path)
    --
    --   dap.adapters.python = {
    --     type = "executable",
    --     -- command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
    --     command = vim.fn.exepath("debugpy-adapter"),
    --     args = { "-m", "debugpy.adapter" },
    --   }
    --
    --   dap.configurations.python = {
    --     {
    --       type = "python",
    --       request = "launch",
    --       name = "Launch file from SUPER config",
    --       program = "${file}",
    --       cwd = "${workspaceFolder}",
    --       -- pythonPath = function()
    --       --   return "/home/rjouhameau/.local/share/nvim-lazy/mason/packages/debugpy/venv/bin/python"
    --       -- end,
    --     },
    --   }
  end,
}
