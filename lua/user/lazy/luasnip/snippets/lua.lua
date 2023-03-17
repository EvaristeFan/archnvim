local ls = require("luasnip") --{{{
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"

local function cs(trigger, nodes, opts) --{{{
	local snippet = s(trigger, nodes)
	local target_table = snippets

	local pattern = file_pattern
	local keymaps = {}

	if opts ~= nil then
		-- check for custom pattern
		if opts.pattern then
			pattern = opts.pattern
		end

		-- if opts is a string
		if type(opts) == "string" then
			if opts == "auto" then
				target_table = autosnippets
			else
				table.insert(keymaps, { "i", opts })
			end
		end

		-- if opts is a table
		if opts ~= nil and type(opts) == "table" then
			for _, keymap in ipairs(opts) do
				if type(keymap) == "string" then
					table.insert(keymaps, { "i", keymap })
				else
					table.insert(keymaps, keymap)
				end
			end
		end

		-- set autocmd for each keymap
		if opts ~= "auto" then
			for _, keymap in ipairs(keymaps) do
				vim.api.nvim_create_autocmd("BufEnter", {
					pattern = pattern,
					group = group,
					callback = function()
						vim.keymap.set(keymap[1], keymap[2], function()
							ls.snip_expand(snippet)
						end, { noremap = true, silent = true, buffer = true })
					end,
				})
			end
		end
	end

	table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

-- Start Refactoring --

cs("CMD", { -- [CMD] multiline vim.cmd{{{
	t({ "vim.cmd[[", "  " }),
	i(1, ""),
	t({ "", "]]" }),
}) --}}}
cs("cmd", fmt("vim.cmd[[{}]]", { i(1, "") })) -- single line vim.cmd
cs({ -- github import for packer{{{
	trig = "https://github%.com/([%w-%._]+)/([%w-%._]+)!",
	regTrig = true,
	hidden = true,
}, {
	t([[use "]]),
	f(function(_, snip)
		return snip.captures[1]
	end),
	t("/"),
	f(function(_, snip)
		return snip.captures[2]
	end),
	t({ [["]], "" }),
	i(1, ""),
}, "auto") --}}}

cs( -- {regexSnippet} LuaSnippet{{{
	"regexSnippet",
	fmt(
		[=[
cs( -- {}
{{ trig = "{}", regTrig = true, hidden = true }}, fmt([[ 
{}
]], {{
  {}
}}))
      ]=],
		{
			i(1, "Description"),
			i(2, ""),
			i(3, ""),
			i(4, ""),
		}
	),
	{ pattern = "*/snippets/*.lua", "<C-d>" }
) --}}}
cs( -- [luaSnippet] LuaSnippet{{{
	"luaSnippet",
	fmt(
		[=[
cs( -- {}
"{}", fmt(
[[
{}
]], {{
  {}
  }}){})
    ]=],
		{
			i(2, "Description"),
			i(1, "trigger"),
			i(3),
			i(4),
			c(5, {
				t(""),
				fmt([[, "{}"]], { i(1, "keymap") }),
				fmt([[, {{ pattern = "{}", {} }}]], { i(1, "*/snippets/*.lua"), i(2, "keymap") }),
			}),
		}
	),
	{ pattern = "*/snippets/*.lua", "jcs" }
) --}}}

cs( -- choice_node_snippet luaSnip choice node{{{
	"luaSnip_choice_node",
	fmt(
		[[ 
c({}, {{ {} }}),
]],
		{
			i(1, ""),
			i(2, ""),
		}
	),
	{ pattern = "*/snippets/*.lua", "jcn" }
) --}}}
cs( -- LuaSnip local fmt{{{
	"fmt",
	fmt(
		[=[
local {}_fmt = fmt([[
{}
]], {{
{}
}})
]=],
		{
			i(1, ""),
			i(2, ""),
			i(3, ""),
		}
	),
	{ pattern = "*/snippets/*.lua", "jfm" }
) --}}}

-- Lua Basic Snippets --

-- local declarations and functions
cs( -- [function] Lua function snippet{{{
	"function",
	fmt(
		[[ 
function {}({})
  {}
end
]],
		{
			i(1, ""),
			i(2, ""),
			i(3, ""),
		}
	),
	"jff"
) --}}}
cs( -- [local_function] Lua function snippet{{{
	"local_function",
	fmt(
		[[ 
local function {}({})
  {}
end
]],
		{
			i(1, ""),
			i(2, ""),
			i(3, ""),
		}
	),
	"jlf"
) --}}}
cs( -- [local] Lua local variable snippet{{{
	"local",
	fmt(
		[[ 
local {} = {}
  ]],
		{ i(1, ""), i(2, "") }
	),
	"jj"
) --}}}

-- For Loops
local for_in_fmt = fmt( --{{{
	[[
for {} in {} do
  {}
end
]],
	{ i(1, "item"), i(2, "table"), i(3, "-- TODO:") }
) --}}}
local for_ipairs_fmt = fmt( --{{{
	[[
{}for {}, {} in ipairs({}) do
  {}
end
]],
	{
		i(1, ""),
		c(2, { t("_"), i("index"), i("idx") }),
		i(3, "value"),
		i(4, "table"),
		i(5, "-- TODO:"),
	}
) --}}}
local for_pairs_fmt = fmt( --{{{
	[[
{}for {}, {} in pairs({}) do
  {}
end
]],
	{
		i(1, ""),
		i(2, "key"),
		i(3, "value"),
		i(4, "table"),
		i(5, "-- TODO:"),
	}
) --}}}
cs( -- Lua For loop{{{
	"for",
	c(1, { for_ipairs_fmt, for_pairs_fmt, for_in_fmt }),
	"jfor"
) --}}}

-- If Statements
cs( -- Lua If Statement{{{
	"if",
	fmt(
		[[
if {} then
  {}
end
]],
		{
			i(1, "condition"),
			i(2, "-- TODO:"),
		}
	),
	"jif"
) --}}}

-- TODOS:
cs( -- basic TODO comments{{{
	"todo",
	fmt(
		[[
-- {}: {}
]],
		{
			c(1, { t("TODO:"), t("QUESTION"), t("HACK"), t("FIX"), t("BUG") }),
			i(2, ""),
		}
	),
	{ "jtod", "jkt" }
) --}}}

-- Nvim Related --
cs( --{{{ -- Nvim Augroup in Lua
	"augroup",
	fmt(
		[[
local {} = vim.api.nvim_create_augroup("{}", {{ clear = true }})
]],
		{
			i(1, "group"),
			i(2, "Augroup Name"),
		}
	)
) --}}}
cs( -- Nvim Autocmd in Lua{{{
	"autocmd",
	fmt(
		[[
vim.api.nvim_create_autocmd("{}", {{
  {},
  group = {},
  callback = function()
    {}
  end,
}})
    ]],
		{
			i(1, "BufEnter"),
			c(2, { fmt([[pattern = "{}"]], { i(1) }), fmt([[buffer = {}]], { i(1, "0") }) }),
			i(3, "group"),
			i(4, "-- callback"),
		}
	)
) --}}}
cs( -- Nvim Set Keymap - vim.keymap.set{{{
	"keymap",
	fmt(
		[[
vim.keymap.set({}, "{}", {}, {})
]],
		{
			c(1, { fmt([["{}"]], { i(1, "n") }), fmt([[{{"{}", "{}"}}]], { i(1, "n"), i(2, "x") }) }),
			i(2, "keymap"),
			c(3, {
				fmt([["{}"]], { i(1, "right_hand_side") }),
				fmt(
					[[
function()
  {}
end
      ]],
					{
						i(1, "-- Do something here"),
					}
				),
			}),
			c(4, {
				t("{ noremap = true, silent = true }"),
				t("{ noremap = true, buffer = true, silent = true }"),
				t("{ silent = true }"),
				t("{ noremap = true }"),
				t("opts"),
			}),
		}
	)
) --}}}

-- Tutorial Snippets go here --

-- End Refactoring --

return snippets, autosnippets

