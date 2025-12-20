-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- General
keymap.set("n", "<leader>w", "<cmd>:w<cr>", { desc = "Save file" })
keymap.set("n", "<leader>q", "<cmd>:q<cr>", { desc = "Quit file" })
keymap.set("n", "<leader>x", "<cmd>:bd<cr>", { desc = "Close window in buffer" })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left in buffers", noremap = true, silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right in buffers", noremap = true, silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down in buffers", noremap = true, silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up in buffers", noremap = true, silent = true })
keymap.set("n", "<leader>vs", "<cmd>:vs<cr>", { desc = "vertical split", noremap = true, silent = true })
keymap.set("n", "<leader>hs", "<cmd>:split<cr>", { desc = "horizontal split", noremap = true, silent = true })
keymap.set("n", "<C-A-k>", "<cmd>:resize -2<cr>", { noremap = true, silent = true })
keymap.set("n", "<C-A-j>", "<cmd>:resize +2<cr>", { noremap = true, silent = true })
keymap.set("n", "<C-A-l>", "<cmd>:vertical resize +2<cr>", { noremap = true, silent = true })
keymap.set("n", "<C-A-h>", "<cmd>:vertical resize -2<cr>", { noremap = true, silent = true })
-- nnoremap <A-k>  :resize -2<CR>
-- nnoremap <A-j>  :resize +2<CR>
-- nnoremap <A-h>  :vertical resize -2<CR>
-- nnoremap <A-l>  :vertical resize +2<CR>

-- Terraform
--keymap.set("n", "<leader>tfi", "<cmd>:te terraform init<CR>", { desc = "Terraform Init" })
--keymap.set("n", "<leader>tfp", "<cmd>:te terraform plan<CR>", { desc = "Terraform Plan" })
--keymap.set("n", "<leader>tfa", "<cmd>:te terraform apply<CR>", { desc = "Terraform Apply" })
--keymap.set("n", "<leader>tfd", "<cmd>:te terraform destroy<CR>", { desc = "Terraform Destroy" })
--keymap.set("n", "<leader>tfs", "<cmd>:te terraform show<CR>", { desc = "Terraform Show" })

