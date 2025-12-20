return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup()

		local function set_terminal_keymaps()
			local opts = { noremap = true }
			vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", opts)
			vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", opts)
			vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", opts)
			vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>ToggleTerm<CR>", opts)
			vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], opts)
		end
		set_terminal_keymaps()
	end,
}
