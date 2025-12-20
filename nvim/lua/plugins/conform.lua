return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		-- Map filetypes to formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_organize_imports", "ruff_format" },
			go = { "gofumpt", "goimports", "golines" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			graphql = { "prettier" },
		},
		-- Format on save settings
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback", -- Use LSP (like gopls) if no formatter (like stylua) is available
		},
	},
}
