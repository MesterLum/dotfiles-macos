return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set(
      "n",
      "<leader>ss",
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
      { desc = "Mark file with harpoon" }
    )
    keymap.set(
      "n",
      "<leader>sa",
      "<cmd>lua require('harpoon.mark').add_file()<cr>",
      { desc = "Mark file with harpoon" }
    )
    keymap.set("n", "<leader>s1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "Go to harpoon file 1" })
    keymap.set("n", "<leader>s2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "Go to harpoon file 2" })
    keymap.set("n", "<leader>s3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "Go to harpoon file 3" })
    keymap.set("n", "<leader>s4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { desc = "Go to harpoon file 4" })
  end,
}
