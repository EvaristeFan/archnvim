local homepath = vim.fn.expand"~"
local options = {
	termguicolors = true,
	showmode = false,
	mouse = "nvi",
	cursorline = true,
	number = true,
	relativenumber = true,
	smartcase = true,
	ignorecase = true,
	scrolloff = 8,
	autochdir = true,
	hidden = true,
	backup = true,
	undofile = true,
	backupdir = homepath.."/Document/backupdir",
	undodir = homepath.."/Document/undofile",
	guifont = "FiraCode Nerd font:h15",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
