return {
	-- Extend auto completion
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		dependencies = {
			{
				"Saecki/crates.nvim",
				event = { "BufRead Cargo.toml" },
				opts = {
					completion = {
						cmp = { enabled = true },
					},
				},
			},
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, { name = "crates" })
		end,
	},

	-- Add Rust & related to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "rust", "ron" } },
	},

	-- Ensure Rust debugger is installed
	{
		"williamboman/mason.nvim",
		optional = true,
		opts = { ensure_installed = { "codelldb" } },
	},

	{
		"mrcjkb/rustaceanvim",
		version = vim.fn.has("nvim-0.10.0") == 0 and "^5" or false,
		ft = { "rust" },
		lazy = false,
		opts = {
			server = {
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "<leader>cR", function()
						vim.cmd.RustLsp("codeAction")
					end, { desc = "Code Action", buffer = bufnr })
					vim.keymap.set("n", "<leader>dr", function()
						vim.cmd.RustLsp("debuggables")
					end, { desc = "Rust Debuggables", buffer = bufnr })
				end,
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						-- Add clippy lints for Rust.
						checkOnSave = true,
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
		end,
	},

	-- Correctly setup lspconfig for Rust 🚀
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	opts = {
	-- 		servers = {
	-- 			taplo = {
	-- 				keys = {
	-- 					{
	-- 						"K",
	-- 						function()
	-- 							if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
	-- 								require("crates").show_popup()
	-- 							else
	-- 								vim.lsp.buf.hover()
	-- 							end
	-- 						end,
	-- 						desc = "Show Crate Documentation",
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },

	{
		"nvim-neotest/neotest",
		optional = true,
		opts = {
			adapters = {
				["rustaceanvim.neotest"] = {},
			},
		},
	},
}
