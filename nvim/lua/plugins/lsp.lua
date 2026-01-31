return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()
		-- 1. AUTOMATE LSP INSTALLATION
		local lsp_servers = { "gopls", "basedpyright", "lua_ls", "ruff", "docker_language_server", "templ" }
		require("mason-lspconfig").setup({
			ensure_installed = lsp_servers, -- Auto-install these LSPs
		})
		-- 2. Automate Formatter/Linter installation
		require("mason-tool-installer").setup({
			ensure_installed = {
				"stylua", -- Lua formatter
				"prettier",
				"gofumpt", -- Go formatter
				"goimports", -- Go import organizer
				"golines", -- Go line formatter
			},
		})

		-- 2. GLOBAL DEFAULTS (The 0.11 Magic)
		-- Instead of passing capabilities to every server, we set it once for ALL servers.
		-- blink.cmp provides the capabilities function.
		vim.lsp.config("*", {
			root_markers = { ".git" }, -- Optional: faster root detection
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		-- 3. SERVER CONFIGURATIONS
		-- Use vim.lsp.config() to customize specific servers.
		-- Note: You don't need to define 'cmd' or 'filetypes' manually;
		-- nvim-lspconfig provides those defaults in the background.

		-- Go: gopls
		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		-- Python: basedpyright (The modern choice over pyright)
		vim.lsp.config("basedpyright", {
			settings = {
				basedpyright = {
					disableOrganizeImports = true,
					python = {
						analysis = {
							-- Ignore all files for analysis to exclusively use Ruff for linting
							ignore = { "*" },
						},
					},
					analysis = {
						typeCheckingMode = "standard",
					},
				},
			},
		})

		-- 4. ENABLE SERVERS
		-- This tells Neovim to start these servers when the matching filetypes are opened.
		for _, server in ipairs(lsp_servers) do
			vim.lsp.enable(server)
		end

		--Diagnostics settings
		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "󰋼",
					[vim.diagnostic.severity.HINT] = "󰌵",
				},
			},
			float = {
				border = "rounded",
				format = function(d)
					return ("%s (%s) [%s]"):format(d.message, d.source, d.code or d.user_data.lsp.code)
				end,
			},
			underline = true,
			jump = {
				float = true,
			},
		})

		-- LSP Attach function
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				-- 'event.buf' is the specific buffer number where LSP attached
				local opts = { buffer = event.buf }

				-- 1. DEFINITION & NAVIGATION
				vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
				vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)

				-- 2. INFORMATION
				vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

				-- 3. ACTIONS
				vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

				-- 4. CONDITIONAL LOGIC (The "Smart" Part)
				-- You can check what capabilities the server has here
				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- Example: Only map formatting if the client supports it
				-- (Though we usually prefer Conform.nvim for this now)
				if client and client.supports_method("textDocument/formatting") then
					-- vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
				end
			end,
		})
	end,
}
