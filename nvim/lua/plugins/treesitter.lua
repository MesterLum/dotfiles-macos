return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "master",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"dockerfile",
				"gitignore",
				"go",
				"gomod",
				"gowork",
				"javascript",
				"json",
				"lua",
				"markdown",
				"proto",
				"python",
				"rego",
				"ruby",
				"sql",
				"svelte",
				"yaml",
				"htmldjango",
				"terraform",
				"hcl",
			},
			sync_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
