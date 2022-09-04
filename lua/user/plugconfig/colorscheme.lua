local onedarkpro = require("onedarkpro")

local markdown = {
	TSTitle = { fg = "${orange}", style = "bold" },
	TSPunctSpecial = { fg = "${red}" },
	TSStrong = { style = "bold" },
	TSLiteral = { fg = "${green}" },
	TSPunctDelimiter = { fg = "#848b98" },
	TSEmphasis = { style = "italic" },
	TSURI = { style = "underline" },
	TSTextReference = { "${blue}" },
	TSStringEscape = { fg = "${red}" },
}

local lua = {
	TSField = { fg = "${cyan}" },
}

onedarkpro.setup({
	--dark_theme = "onedark", -- The default dark theme
	options = {
		underline = true, -- Use cursorline highlighting?
		undercurl = true,
		transparency = true, -- Use a transparent background?
		--terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
		--window_unfocussed_color = false, -- When the window is out of focus, change the normal background?
	},
	highlights = {
		MatchParen = { bg = "${gray}" },
		CursorLine = { bg = "NONE", style = "underline" },
		TSAAAEmphasis = { fg = "${purple}" },
		TSAAAReference = { bg = "${gray}", fg = "${yellow}" },
		LspSignatureActiveParameter = { bg = "${gray}", fg = "${purple}" },
		TelescopePreviewTitle = { fg = "${purple}", bg = "${NONE}" },
		TelescopePromptTitle = { fg = "${purple}", bg = "${NONE}" },
		TelescopePromptBorder = { fg = "${orange}" },
		TelescopePreviewBorder = { fg = "${green}" },
		TelescopeResultsBorder = { fg = "${cyan}" },
		CmpItemMenu = { fg = "#af8fe9" },
	},
	ft_highlights = {
		markdown = markdown,
		lua = lua,
		python = {},
		rust = {},
		tex = {},
		c = {},
	}
})

vim.cmd("colorscheme onedarkpro")
