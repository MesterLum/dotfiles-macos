local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.scrolloff = 7
opt.backspace = "indent,eol,start"
opt.cmdheight = 1

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- opt.cursorline = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.fileformat = "unix"

opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
-- opt.signcolumn = "yes" -- show sign column so that text doesn't shift
