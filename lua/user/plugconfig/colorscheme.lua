local onedarkpro = require("onedarkpro")

onedarkpro.setup({
	--dark_theme = "onedark", -- The default dark theme
	options = {
		underline = true, -- Use cursorline highlighting?
		transparency = true, -- Use a transparent background?
		--terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
		--window_unfocussed_color = false, -- When the window is out of focus, change the normal background?
	},
	highlights = {
		-- Filetypes highlights
		-- ["@field.lua"] = { fg = "${cyan}" },
		FidgetTask = { fg = "${purple}" },
		MatchParen = { bg = "${gray}" },
		CursorLine = { style = "underline" },
		CursorLineNr = { fg = "${purple}", style = "underline" },
		TSAAAEmphasis = { fg = "${purple}" },
		TSAAAReference = { bg = "${gray}", fg = "${yellow}" },
		LspSignatureActiveParameter = { bg = "${gray}", fg = "${purple}" },
		TelescopePreviewTitle = { fg = "${purple}", },
		TelescopePromptTitle = { fg = "${purple}", },
		TelescopePromptBorder = { fg = "${orange}" },
		TelescopePreviewBorder = { fg = "${green}" },
		TelescopeResultsBorder = { fg = "${cyan}" },
		CmpItemMenu = { fg = "#af8fe9" },
		WhichKeyFloat = { fg = "NONE" },
		GitSignsCurrentLineBlame = { fg = "${yellow}" },
		GitSignsAddPreview = { bg = "NONE", fg = "${green}" },
		GitSignsDeletePreview = { bg = "NONE", fg = "${red}" },
	},
})

vim.cmd("colorscheme onedark")
