return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				current_line_blame = true,
			})

			-- Gitsigns keymaps
			vim.keymap.set({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
			vim.keymap.set({ "n", "v" }, "<leader>gS", ":Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
			vim.keymap.set({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
			vim.keymap.set("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
			vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
			vim.keymap.set("n", "<leader>gb", gitsigns.blame, { desc = "blame" })
			vim.keymap.set("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this" })
			vim.keymap.set("n", "<leader>gD", function()
				gitsigns.diffthis("~")
			end, { desc = "Diff this against last commit" })
		end,
	},
	{
		"tpope/vim-fugitive",
	},
}
