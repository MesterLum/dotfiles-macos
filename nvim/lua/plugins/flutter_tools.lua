return {
	"akinsho/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local flutter_tools = require("flutter-tools")
		local telescope = require("telescope")

		flutter_tools.setup({
			fvm = true,
		})

		telescope.load_extension("flutter")

		local keymap = vim.keymap -- for conciseness

		keymap.set(
			"n",
			"<leader>mff",
			"<cmd>lua require('telescope').extensions.flutter.commands()<cr>",
			{ desc = "Open flutter available commands" }
		)
		keymap.set(
			"n",
			"<leader>mfv",
			"<cmd>lua require('telescope').extensions.flutter.fvm()<cr>",
			{ desc = "Open flutter version" }
		)
	end,
}
