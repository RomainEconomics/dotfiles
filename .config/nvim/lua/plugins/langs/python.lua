return {
	{
		'nvim-treesitter/nvim-treesitter',
		opts = { ensure_installed = { 'ninja', 'rst' } },
	},
	-- {
	--   'neovim/nvim-lspconfig',
	--   opts = {
	--     servers = {
	--       pyright = {
	--         enabled = true,
	--       },
	--       ruff = {
	--         enabled = true,
	--         -- keys = {
	--         -- {
	--         --   '<leader>co',
	--         --   vim.lsp.buf.code_action['source.organizeImports'],
	--         --   desc = 'Organize Imports',
	--         -- },
	--         -- },
	--       },
	--     },
	--     -- setup = {
	--     --   ['ruff'] = function()
	--     --     LazyVim.lsp.on_attach(function(client, _)
	--     --       -- Disable hover in favor of Pyright
	--     --       client.server_capabilities.hoverProvider = false
	--     --     end, ruff)
	--     --   end,
	--     -- },
	--   },
	-- },
	{
		'nvim-neotest/neotest',
		optional = true,
		dependencies = {
			'nvim-neotest/neotest-python',
		},
		opts = {
			adapters = {
				['neotest-python'] = {
					-- Here you can specify the settings for the adapter, i.e.
					-- runner = "pytest",
					-- python = ".venv/bin/python",
				},
			},
		},
	},
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'mfussenegger/nvim-dap-python',
      -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
        { "<leader>dPc", function() require('dap-python').test_class() end,  desc = "Debug Class",  ft = "python" },
      },
			config = function()
				--   -- require('dap-python').setup()
				require('dap-python').setup('uv')
				--
				--   -- require('dap-python').setup(LazyVim.get_pkg_path('debugpy', '/venv/bin/python'))
			end,
		},
	},

	{
		'linux-cultist/venv-selector.nvim',
		branch = 'regexp', -- Use this branch for the new version
		cmd = 'VenvSelect',
		opts = {
			settings = {
				options = {
					notify_user_on_venv_activation = true,
				},
			},
		},
		ft = 'python',
		keys = { { '<leader>cv', '<cmd>:VenvSelect<cr>', desc = 'Select VirtualEnv', ft = 'python' } },
	},

	{
		'hrsh7th/nvim-cmp',
		optional = true,
		opts = function(_, opts)
			opts.auto_brackets = opts.auto_brackets or {}
			table.insert(opts.auto_brackets, 'python')
		end,
	},

	-- Don't mess up DAP adapters provided by nvim-dap-python
	-- {
	--   'jay-babu/mason-nvim-dap.nvim',
	--   optional = true,
	--   opts = {
	--     handlers = {
	--       python = function() end,
	--     },
	--   },
	-- },
	{
		'geg2102/nvim-python-repl',
		dependencies = 'nvim-treesitter',
		ft = { 'python', 'lua' },
		config = function()
			require('nvim-python-repl').setup({
				execute_on_send = true,
				vsplit = true,
			})

			vim.keymap.set(
				'n',
				'<leader>rr',
				function() require('nvim-python-repl').send_statement_definition() end,
				{ desc = 'Send semantic unit to REPL' }
			)
			vim.keymap.set(
				'v',
				'<leader>rr',
				function() require('nvim-python-repl').send_visual_to_repl() end,
				{ desc = 'Send visual selection to REPL' }
			)
			-- vim.keymap.set("n", [your keyamp], function() require('nvim-python-repl').send_buffer_to_repl() end, { desc = "Send entire buffer to REPL"})
			-- vim.keymap.set("n", [your keymap], function() require('nvim-python-repl').toggle_execute() end, { desc = "Automatically execute command in REPL after sent"})
			-- vim.keymap.set("n", [your keymap], function() require('nvim-python-repl').toggle_vertical() end, { desc = "Create REPL in vertical or horizontal split"})
			-- vim.keymap.set("n", "<leader>r", function()
			--   require("nvim-python-repl").open_repl()
			-- end, { desc = "Opens the REPL in a window split" })
		end,
	},
	{
		'geg2102/nvim-jupyter-client',
		config = function()
			require('nvim-jupyter-client').setup({})

			-- Add cells
			vim.keymap.set('n', '<leader>ja', '<cmd>JupyterAddCellBelow<CR>', { desc = 'Add Jupyter cell below' })
			vim.keymap.set('n', '<leader>jA', '<cmd>JupyterAddCellAbove<CR>', { desc = 'Add Jupyter cell above' })

			-- Cell operations
			vim.keymap.set('n', '<leader>jd', '<cmd>JupyterRemoveCell<CR>', { desc = 'Remove current Jupyter cell' })
			vim.keymap.set('n', '<leader>jm', '<cmd>JupyterMergeCellAbove<CR>', { desc = 'Merge with cell above' })
			vim.keymap.set('n', '<leader>jM', '<cmd>JupyterMergeCellBelow<CR>', { desc = 'Merge with cell below' })
			vim.keymap.set('n', '<leader>jt', '<cmd>JupyterConvertCellType<CR>', { desc = 'Convert cell type (code/markdown)' })
			vim.keymap.set('v', '<leader>jm', '<cmd>JupyterMergeVisual<CR>', { desc = 'Merge selected cells' })
			vim.keymap.set('n', '<leader>jD', '<cmd>JupyterDeleteCell<CR>', { desc = 'Delete cell under cursor and store in register' })
		end,
	},
	{
		'benomahony/uv.nvim',
		config = function() require('uv').setup() end,
	},
}
