return {
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = 'luvit-meta/library', words = { 'vim%.uv' } },
			},
		},
	},
	{ 'Bilal2453/luvit-meta', lazy = true },

	{
		-- Main LSP Configuration
		-- # TODO: improve lsp config
		-- see: https://www.reddit.com/r/neovim/comments/1khidkg/mind_sharing_your_new_lsp_setup_for_nvim_011/
		'neovim/nvim-lspconfig',
		-- event = { "BufReadPre", "BufNewFile" },

		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ 'mason-org/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
			'mason-org/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			{
				'antosha417/nvim-lsp-file-operations',
				config = true,
			},

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim', opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			-- 'hrsh7th/cmp-nvim-lsp',
			'saghen/blink.cmp',
		},
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					-- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
					-- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
					-- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
					-- map('<leader>DD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
					-- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
					-- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
					map('gdv', ':vsplit | lua vim.lsp.buf.definition()<CR>', '[G]oto [D]efinition (VSplit)')

					map('<C-m>', vim.lsp.buf.hover, 'Hover into', 'n') -- HACK: was using <C-i> but bad idea, map to tab actually

					-- Rename the variable under your cursor.
					map('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
						vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd('LspDetach', {
							group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
							end,
						})
					end

					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map(
							'<leader>th',
							function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end,
							'[T]oggle Inlay [H]ints'
						)
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
			local capabilities = require('blink.cmp').get_lsp_capabilities()

			local servers = {
				clangd = {},
				taplo = {},
				gopls = {},
				pyright = {},
				-- basedpyright = {
				-- 	settings = {
				-- 		analysis = {
				-- 			autoSearchPaths = true,
				-- 			diagnosticMode = 'openFilesOnly',
				-- 			useLibraryCodeForTypes = true,
				-- 		},
				-- 	},
				-- },
				-- ty = {},
				ruff = {},
				tailwindcss = {},
				ts_ls = {},
				lua_ls = {
					settings = {
						Lua = {
							hint = { enable = true },
							completion = {
								callSnippet = 'Replace',
							},
						},
					},
				},
				marksman = {},
				tinymist = {
					settings = {
						formatterMode = 'typstyle',
						exportPdf = 'onType',
						semanticTokens = 'disable',
					},
				},
				rubocop = {},
				ruby_lsp = {},
				zls = {},
				jdtls = {
					settings = {
						java = {},
					},
				},
			}

			require('mason').setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				'stylua', -- Used to format Lua code
			})

			-- very slow on start up
			-- require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

			for server, cfg in pairs(servers) do
				vim.lsp.config(server, cfg)
			end

			-- mason lsp does it already
			vim.lsp.enable(vim.tbl_keys(servers))
		end,
	},
}
