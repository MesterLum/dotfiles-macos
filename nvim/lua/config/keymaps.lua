-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>w", "<cmd>:w<cr>", { desc = "Save file" })
keymap.set("n", "<leader>q", "<cmd>:q<cr>", { desc = "Quit file" })
