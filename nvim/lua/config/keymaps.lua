-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- General
keymap.set("n", "<leader>w", "<cmd>:w<cr>", { desc = "Save file" })
keymap.set("n", "<leader>q", "<cmd>:q<cr>", { desc = "Quit file" })
keymap.set("n", "<leader>x", "<cmd>:bd<cr>", { desc = "Close window in buffer" })
-- Terraform
keymap.set("n", "<leader>tfi", "<cmd>:te terraform init<CR>", { desc = "Terraform Init" })
keymap.set("n", "<leader>tfp", "<cmd>:te terraform plan<CR>", { desc = "Terraform Plan" })
keymap.set("n", "<leader>tfa", "<cmd>:te terraform apply<CR>", { desc = "Terraform Apply" })
keymap.set("n", "<leader>tfd", "<cmd>:te terraform destroy<CR>", { desc = "Terraform Destroy" })
keymap.set("n", "<leader>tfs", "<cmd>:te terraform show<CR>", { desc = "Terraform Show" })
