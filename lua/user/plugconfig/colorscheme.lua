local onedarkpro = require("onedarkpro")
local hlgroups = {
  DiagnosticUnderlineError = { style = "underline" },
  DiagnosticUnderlineWarn = { style = "underline" },
  DiagnosticUnderlineInfo = { style = "underline" },
  DiagnosticUnderlineHint = { style = "underline" },
}
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
    --cursorline = true, -- Use cursorline highlighting?
    transparency = true, -- Use a transparent background?
    --terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
    --window_unfocussed_color = false, -- When the window is out of focus, change the normal background?
  },
  hlgroups = hlgroups,
  filetype_hlgroups = {
    markdown = markdown,
    lua = lua,
  }
})
onedarkpro.load()
-- Lua
require('onedark').setup  {
    -- Main options --
    style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
    -- toggle theme style ---
    toggle_style_key = '<leader>ts', -- Default keybinding to toggle
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}

