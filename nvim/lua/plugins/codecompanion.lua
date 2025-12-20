return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		opts = {
			preview = {
				filetypes = { "markdown", "codecompanion" },
				ignore_buftypes = {},
			},
		},
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"zbirenbaum/copilot.lua",
				event = "InsertEnter",
				build = ":Copilot auth",
				config = function()
					require("copilot").setup({
						suggestion = {
							enabled = true,
							auto_trigger = true,
							keymap = {
								accept = "<C-l>",
							},
						},
						panel = { enabled = false },
					})
				end,
			},
		},
		config = function()
			local codecompanion = require("codecompanion")
			local adapters = require("codecompanion.adapters")
			codecompanion.setup({
				strategies = {
					chat = { adapter = "copilot" },
					inline = { adapter = "copilot" },
					agent = { adapter = "copilot" },
				},
				adapters = {
					copilot = function()
						return adapters.extend("copilot", {
							schema = {
								model = {
									default = "gpt-4o",
								},
							},
						})
					end,
				},
				chat = {
					save_history = true,
					max_history = 50,
				},
				agent = {
					default_prompt = "You are a helpful coding assistant.",
				},
				ui = {
					border = "rounded",
					winblend = 10,
					width = 0.5,
					height = 0.5,
					thinking_message = "⏳ CodeCompanion is thinking...",
					spinner = {
						frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
						interval = 80,
					},
				},
				inline = {
					auto_apply = true,
					show_diff = true,
				},
			})
			local set = vim.keymap.set
			local mappings = {
				{ "n", "<leader>cc", "<cmd>CodeCompanionChat<CR>", "CodeCompanion: Chat" },
				{ "v", "<leader>cC", "<cmd>CodeCompanion chat<CR>", "CodeCompanion: Chat" },
				{ "v", "<leader>ci", "<cmd>CodeCompanion inline<CR>", "CodeCompanion: Inline" },
				{ "n", "<leader>ca", "<cmd>CodeCompanion agent<CR>", "CodeCompanion: Agent" },
				{ "n", "<leader>ch", "<cmd>CodeCompanion history<CR>", "CodeCompanion: Chat History" },
				{ "n", "<leader>cp", "<cmd>CodeCompanion palette<CR>", "CodeCompanion: Action Palette" },
				{ "n", "<leader>cw", "<cmd>CodeCompanion workflows<CR>", "CodeCompanion: Workflows" },
				{ "n", "<leader>ce", "<cmd>CodeCompanion explain<CR>", "CodeCompanion: Explain Selection" },
				{ "v", "<leader>ce", "<cmd>CodeCompanion explain<CR>", "CodeCompanion: Explain Selection (Visual)" },
				{ "n", "<leader>cr", "<cmd>CodeCompanion refactor<CR>", "CodeCompanion: Refactor Selection" },
				{ "v", "<leader>cr", "<cmd>CodeCompanion refactor<CR>", "CodeCompanion: Refactor Selection (Visual)" },
			}
			for _, map in ipairs(mappings) do
				set(map[1], map[2], map[3], { desc = map[4] })
			end
		end,
	},
}
