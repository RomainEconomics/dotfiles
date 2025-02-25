---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
  local args_str = type(args) == 'table' and table.concat(args, ' ') or args --[[@as string]]

  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input('Run with args: ', args_str)) --[[@as string]]
    if config.type and config.type == 'java' then
      ---@diagnostic disable-next-line: return-type-mismatch
      return new_args
    end
    return require('dap.utils').splitstr(new_args)
  end
  return config
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap-python',
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = { commented = true },
      },
    },

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dq", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
    config = function()
      --   vim.notify('DAP config is being loaded', vim.log.levels.INFO)
      --
      local dap = require 'dap'
      local dapui = require 'dapui'
      local dap_python = require 'dap-python'
      --   -- dap_python.setup 'python3'
      --
      vim.fn.sign_define('DapBreakpoint', {
        text = '',
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      })

      vim.fn.sign_define('DapBreakpointRejected', {
        text = '', -- or "❌"
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      })

      vim.fn.sign_define('DapStopped', {
        text = '', -- or "→"
        texthl = 'DiagnosticSignWarn',
        linehl = 'Visual',
        numhl = 'DiagnosticSignWarn',
      })

      -- setup dap config by VsCode launch.json file
      local vscode = require 'dap.ext.vscode'
      local json = require 'plenary.json'
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },
  {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'nvim-neotest/nvim-nio' },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
      opts = {},
      config = function(_, opts)
        local dap = require 'dap'
        local dapui = require 'dapui'
        dapui.setup(opts)
        dap.listeners.after.event_initialized['dapui_config'] = function()
          dapui.open {}
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
          dapui.close {}
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
          dapui.close {}
        end
      end,
    },

    -- mason.nvim integration
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = 'mason.nvim',
      cmd = { 'DapInstall', 'DapUninstall' },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'python',
        },
      },
      -- mason-nvim-dap is loaded when nvim-dap loads
      config = function()
        require('dap-python').setup 'uv'
      end,
    },
  },
}
-- return {
--   -- NOTE: Yes, you can install new plugins here!
--   'mfussenegger/nvim-dap',
--   -- NOTE: And you can specify dependencies as well
--   dependencies = {
--     -- Creates a beautiful debugger UI
--     'rcarriga/nvim-dap-ui',
--
--     -- Required dependency for nvim-dap-ui
--     'nvim-neotest/nvim-nio',
--
--     -- Installs the debug adapters for you
--     'williamboman/mason.nvim',
--     'jay-babu/mason-nvim-dap.nvim',
--
--     -- Add your own debuggers here
--     'leoluz/nvim-dap-go',
--   },
--   keys = function(_, keys)
--     local dap = require 'dap'
--     local dapui = require 'dapui'
--     return {
--       -- Basic debugging keymaps, feel free to change to your liking!
--       { '<F5>', dap.continue, desc = 'Debug: Start/Continue' },
--       { '<F1>', dap.step_into, desc = 'Debug: Step Into' },
--       { '<F2>', dap.step_over, desc = 'Debug: Step Over' },
--       { '<F3>', dap.step_out, desc = 'Debug: Step Out' },
--       { '<leader>b', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
--       {
--         '<leader>B',
--         function()
--           dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
--         end,
--         desc = 'Debug: Set Breakpoint',
--       },
--       -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
--       { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
--       unpack(keys),
--     }
--   end,
--   config = function()
--     local dap = require 'dap'
--     local dapui = require 'dapui'
--
--     require('mason-nvim-dap').setup {
--       -- Makes a best effort to setup the various debuggers with
--       -- reasonable debug configurations
--       automatic_installation = true,
--
--       -- You can provide additional configuration to the handlers,
--       -- see mason-nvim-dap README for more information
--       handlers = {},
--
--       -- You'll need to check that you have the required things installed
--       -- online, please don't ask me how to install them :)
--       ensure_installed = {
--         -- Update this to ensure that you have the debuggers for the langs you want
--         'delve',
--       },
--     }
--
--     -- Dap UI setup
--     -- For more information, see |:help nvim-dap-ui|
--     dapui.setup {
--       -- Set icons to characters that are more likely to work in every terminal.
--       --    Feel free to remove or use ones that you like more! :)
--       --    Don't feel like these are good choices.
--       icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
--       controls = {
--         icons = {
--           pause = '⏸',
--           play = '▶',
--           step_into = '⏎',
--           step_over = '⏭',
--           step_out = '⏮',
--           step_back = 'b',
--           run_last = '▶▶',
--           terminate = '⏹',
--           disconnect = '⏏',
--         },
--       },
--     }
--
--     dap.listeners.after.event_initialized['dapui_config'] = dapui.open
--     dap.listeners.before.event_terminated['dapui_config'] = dapui.close
--     dap.listeners.before.event_exited['dapui_config'] = dapui.close
--
--     -- Install golang specific config
--     require('dap-go').setup {}
--   end,
-- }
