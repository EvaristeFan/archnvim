local options = {
	showmode = false,
	cursorline = true,
	number = true,
	relativenumber = true,
	smartcase = true,
	ignorecase = true,
	scrolloff = 8,
	autochdir = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
