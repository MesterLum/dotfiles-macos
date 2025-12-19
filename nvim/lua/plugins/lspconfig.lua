return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local on_attach = function(client, bufnr)
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true, noremap = true })
			end
			map("n", "gr", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
			map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
			map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
			map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
			map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
			map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
			map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
			map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
			map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
			map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")
			map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
			map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			float = {
				border = "rounded",
				format = function(d)
					return ("%s (%s) [%s]"):format(
						d.message,
						d.source,
						d.code or (d.user_data and d.user_data.lsp and d.user_data.lsp.code) or ""
					)
				end,
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		local servers = {
			html = {},
			ts_ls = {},
			cssls = {},
			tailwindcss = {
				filetypes = {
					"aspnetcorerazor",
					"astro",
					"astro-markdown",
					"blade",
					"clojure",
					"django-html",
					"htmldjango",
					"edge",
					"eelixir",
					"elixir",
					"ejs",
					"erb",
					"eruby",
					"gohtml",
					"gohtmltmpl",
					"haml",
					"handlebars",
					"hbs",
					"html",
					"htmlangular",
					"html-eex",
					"heex",
					"jade",
					"leaf",
					"liquid",
					"markdown",
					"mdx",
					"mustache",
					"njk",
					"nunjucks",
					"php",
					"razor",
					"slim",
					"twig",
					"css",
					"less",
					"postcss",
					"sass",
					"scss",
					"stylus",
					"sugarss",
					"javascript",
					"javascriptreact",
					"reason",
					"rescript",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
					"templ",
				},
			},
			dockerls = {},
			docker_compose_language_service = {},
			prismals = {},
			graphql = {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			},
			emmet_ls = {
				filetypes = {
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"svelte",
					"pug",
					"typescriptreact",
					"vue",
				},
			},
			pyright = {},
			gopls = {},
			dartls = {},
			terraformls = {
				cmd = { "terraform-ls", "serve" },
			},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			},
		}

		for server, config in pairs(servers) do
			config.capabilities = capabilities
			config.on_attach = on_attach
			lspconfig[server].setup(config)
		end

		-- Svelte special autocmd for file change notification
		lspconfig["svelte"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						for _, lsp_client in ipairs(vim.lsp.get_clients({ bufnr = ctx.buf })) do
							if lsp_client.name == "svelte" then
								lsp_client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
							end
						end
					end,
				})
			end,
		})
	end,
}
