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
			"franco-ruggeri/codecompanion-spinner.nvim",
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
									default = "claude-3.5-sonnet",
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
				inline = {
					auto_apply = false,
					show_diff = true,
				},
				extensions = {
					spinner = {},
				},
				prompt_library = {
					["Generate Comments"] = {
						interaction = "inline",
						opts = {
							is_slash_cmd = true,
							alias = "generate_comments",
							auto_submit = true,
						},
						description = "Generate comments",
						prompts = {
							{
								role = "system",
								content = [[
                Act as an expert software engineer. Review the following code and add detailed [Docstring Format, e.g., Python Docstrings or JSDoc] comments for all classes and functions.
Requirements:

    Purpose: Explain what the function does and its high-level intent.
    Parameters & Returns: Document every parameter with its type and expected value, and the return type/value.
    Exceptions: List any errors or exceptions it might raise.
    Logic: For complex logic, add brief inline comments explaining critical steps.
    Style: Follow [specific style, e.g., PEP 8 or Google Style] and ensure comments are concise and non-redundant.
                ]],
							},
							{
								role = "user",
								content = function(context)
									local text = require("codecompanion.helpers.actions").get_code(
										context.start_line,
										context.end_line
									)
									return "Please generate comment for code:\n\n```"
										.. context.filetype
										.. "\n"
										.. text
										.. "\n```"
								end,
							},
						},
					},
				},
			})
			local set = vim.keymap.set
			set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "CodeCompanion Chat" })
			set({ "n", "v" }, "<leader>cp", "<cmd>CodeCompanionChat Add<CR>", { desc = "CodeCompanion Add to context" })
			set({ "n", "v" }, "<leader>ci", "<cmd>CodeCompanion<CR>", { desc = "CodeCompanion Inline" })
			set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion Actions" })
			set("v", "<leader>ce", "<cmd>CodeCompanion /explain<CR>", { desc = "CodeCompanion Explain" })
			set("v", "<leader>cm", "<cmd>CodeCompanion /generate_comments<CR>", { desc = "CodeCompanion Comments" })

			-- Alternatively, using the following format:
		end,
	},
}
