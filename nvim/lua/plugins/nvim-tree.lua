return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      actions = {
        open_file = {
        quit_on_open = true,
        },
      },
    }
    
    --nmap <leader>nt :NERDTreeToggle<CR>
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>nt", "<cmd>NvimTreeToggle<cr>", { desc = "Fuzzy find files in cwd" })
  end,
}
