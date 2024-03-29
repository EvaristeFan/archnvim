local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local r = ls.restore_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local util = require("luasnip.util.util")
local node_util = require("luasnip.nodes.util")
local postfix = require("luasnip.extras.postfix").postfix


local snippets, autosnippets = {}, {} --}}}


local function column_count_from_string(descr)
	-- this won't work for all cases, but it's simple to improve
	-- (feel free to do so! :D )
	return #(descr:gsub("[^clm]", ""))
end

-- function for the dynamicNode.
local tab = function(args, snip)
	local cols = column_count_from_string(args[1][1])
	-- snip.rows will not be set by default, so handle that case.
	-- it's also the value set by the functions called from dynamic_node_external_update().
	if not snip.rows then
		snip.rows = 1
	end
	local nodes = {}
	-- keep track of which insert-index we're at.
	local ins_indx = 1
	for j = 1, snip.rows do
		-- use restoreNode to not lose content when updating.
		table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, t " & ")
			table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, t { "\\\\", "" })
	end
	-- fix last node.
	nodes[#nodes] = t ""
	return sn(nil, nodes)
end

-- Item environment snippet {{{
local rec_ls
rec_ls = function()
	return sn(nil, {
		c(1, {
			-- important!! Having the sn(...) as the first choice will cause infinite recursion.
			t({ "" }),
			-- The same dynamicNode as in the snippet (also note: self reference).
			sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
		}),
	});
end


local ls_snippet = s("ls", {
	t("\\begin{"), c(1, { t("itemize"), t("enumrate"), t("description") }), t({ "}",
		"\t\\item " }), i(2), d(3, rec_ls, {}),
	t({ "", "\\end{itemize}" }), i(0)
})
--}}}

-- condition for latex context {{{
local function is_comment()
	return vim.fn["vimtex#syntax#in_comment"]() == 1
end

local function in_env(name)
	return function()
		return vim.fn["vimtex#env#is_inside"](name)[1] ~= 0 and vim.fn["vimtex#env#is_inside"](name)[2] ~= 0
	end
end

local function is_math()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

-- }}}

local pac_snippet = s(-- {{{
	"pac",
	fmt([[
	\usepackage{}{{{}}}
	]], { c(1, { t(""), r(1, "pacopt", sn(nil, {t("["), i(1, "pacopt"), t("]")})) }), i(2, "packagename") })) --}}}

local beg_snippet = s(-- {{{
	"beg",
	fmt([[
\begin{{{}}}
	{}
\end{{{}}}]], { i(1, "env"), i(2), rep(1) }
	)
) --}}}

-- Imply and implyed by {{{
local imply_snippet = s("=>", t("\\implies"))
local impliedby_snippet = s("=<", t("\\impliedby"))
table.insert(autosnippets, impliedby_snippet)
table.insert(autosnippets, imply_snippet)
--}}}

-- Math environment snippets {{{

-- Auto spand snippets{{{
local symfrac_snippet = postfix(
	{ trig = "./", match_pattern = "[%w%.%^%_%-%(%)\\%{%}]+$" },
	d(1, function(_, parent)
		return sn(nil, { t("\\frac{" .. parent.snippet.env.POSTFIX_MATCH .. "}{"), i(1), t "}" })
	end
	),
	{ condition = is_math })
local iff_snippet = s("iff", t("\\iff"), { condition = is_math })
-- local frac_snippet = s("//", fmt("\\frac{{{}}}{{{}}}", { i(1, "molecule"), i(2, "denominator") }),
-- 	{ condition = is_math })
local sq_snippet = s(
	{ trig = "sr", wordTrig = false },
	t("^2"),
	{ condition = is_math }
)
local td_snippet = s(
	{ trig = "td", wordTrig = false },
	fmt("^{{{}}}", i(1)),
	{ condition = is_math }
)
table.insert(autosnippets, iff_snippet)
-- table.insert(autosnippets, frac_snippet)
table.insert(autosnippets, symfrac_snippet)
table.insert(autosnippets, sq_snippet)
table.insert(autosnippets, td_snippet)
--}}}

-- Normal spand snippets{{{

--}}}

-- }}}


-- Table snippet {{{
local table_snippet = s({ trig = "tab", name = "tabular", dscr = "Add a table env dynamically" }, fmt([[
\begin{{tabular}}{{{}}}
{}
\end{{tabular}}
]], { i(1, "c"), d(2, tab, { 1 }, {
	user_args = {
		-- Pass the functions used to manually update the dynamicNode as user args.
		-- The n-th of these functions will be called by dynamic_node_external_update(n).
		-- These functions are pretty simple, there's probably some cool stuff one could do
		-- with `ui.input`
		function(snip) snip.rows = snip.rows + 1 end,
		-- don't drop below one.
		function(snip) snip.rows = math.max(snip.rows - 1, 1) end
	}
}) }))
--}}}

table.insert(snippets, beg_snippet)
table.insert(snippets, ls_snippet)
table.insert(snippets, table_snippet)
table.insert(snippets, pac_snippet)

return snippets, autosnippets

-- vim: fdm=marker fdl=0
