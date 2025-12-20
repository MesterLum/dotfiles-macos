local function set_filetype(pattern, filetype)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = pattern,
		command = "set filetype=" .. filetype,
	})
end

set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")
set_filetype({ "compose.yml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.yaml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.yaml" }, "yaml.docker-compose")
set_filetype({ "compose.override.yaml" }, "yaml.docker-compose")
set_filetype({ "compose.override.yaml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.override.yaml" }, "yaml.docker-compose")
set_filetype({ "docker-compose.override.yaml" }, "yaml.docker-compose")
