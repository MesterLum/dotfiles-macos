return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				current_line_blame = true,
			})

			-- Gitsigns keymaps
			vim.keymap.set({ "n", "v" }, "<leader>ss", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
			vim.keymap.set({ "n", "v" }, "<leader>sS", ":Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
			vim.keymap.set({ "n", "v" }, "<leader>sr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
			vim.keymap.set("n", "<leader>su", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
			vim.keymap.set("n", "<leader>sp", gitsigns.preview_hunk, { desc = "Preview hunk" })
			vim.keymap.set("n", "<leader>sb", gitsigns.blame, { desc = "blame" })
			vim.keymap.set("n", "<leader>sd", gitsigns.diffthis, { desc = "Diff this" })
			vim.keymap.set("n", "<leader>sD", function()
				gitsigns.diffthis("~")
			end, { desc = "Diff this against last commit" })
		end,
	},
	{
		"tpope/vim-fugitive",
	},
}
