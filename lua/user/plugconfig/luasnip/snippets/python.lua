local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local fmt = require("luasnip.extras.fmt").fmt
-- local m = require("luasnip.extras").m
-- local lambda = require("luasnip.extras").l
-- local postfix = require("luasnip.extras.postfix").postfix

local snippets, autosnippets = {}, {}

local function generic_pfdoc(ilevel, args)
	local nodes = { t({ "'''", string.rep('\t', ilevel) }) }
	nodes[#nodes + 1] = i(1, 'Small Description.')
	nodes[#nodes + 1] = t({ '', '', string.rep('\t', ilevel) })
	nodes[#nodes + 1] = i(2, 'Long Description')
	nodes[#nodes + 1] = t({ '', '', string.rep('\t', ilevel) .. 'Args:' })

	local a = vim.tbl_map(function(item)
		local trimed = vim.trim(item)
		return trimed
	end, vim.split(
		args[1][1],
		',',
		true
	))

	if args[1][1] == '' then
		a = {}
	end

	for idx, v in pairs(a) do
		nodes[#nodes + 1] = t({ '', string.rep('\t', ilevel + 1) .. v .. ': ' })
		nodes[#nodes + 1] = i(idx + 2, 'Description For ' .. v)
	end

	return nodes, #a
end
local function generic_pcdoc(ilevel, args)
	local nodes = { t({ '"""', string.rep('\t', ilevel) }) }
	nodes[#nodes + 1] = i(1, 'Small Description.')
	nodes[#nodes + 1] = t({ '', '', string.rep('\t', ilevel) })
	nodes[#nodes + 1] = i(2, 'Long Description')
	nodes[#nodes + 1] = t({ '', '', string.rep('\t', ilevel) .. 'Attributes:' })

	local a = vim.tbl_map(function(item)
		local trimed = vim.trim(item)
		return trimed
	end, vim.split(
		args[1][1],
		',',
		true
	))

	if args[1][1] == '' then
		a = {}
	end

	for idx, v in pairs(a) do
		nodes[#nodes + 1] = t({ '', string.rep('\t', ilevel + 1) .. v .. ': ' })
		nodes[#nodes + 1] = i(idx + 2, 'Description For ' .. v)
	end

	return nodes, #a
end

local function pyfdoc(args, _)
	local nodes, a = generic_pfdoc(1, args)
	nodes[#nodes + 1] = c(a + 2 + 1, { t(''), sn(nil, {t{ '', '', '\tReturns: ' }, r(1, "nodeforreturn",i(1))})})
	nodes[#nodes + 1] = c(a + 2 + 2, { t(''), sn(nil, {t{ '', '', '\tRaises: ' }, r(1, "nodeforraise",i(1))})})
	nodes[#nodes + 1] = t({ '', '\t"""', '\t' })
	local snip = sn(nil, nodes)
	return snip
end

local function pycdoc(args, _)
	local nodes, _ = generic_pcdoc(2, args)
	nodes[#nodes + 1] = t({ '', '\t"""', '' })
	local snip = sn(nil, nodes)
	return snip
end

local clsdoc_snippet = s({ trig = 'cls', dscr = 'Documented Class Structure' }, {
	t('class '),
	i(1, { 'CLASS' }),
	t('('),
	i(2, { '' }),
	t({ '):', '\t' }),
	d(4, pycdoc, { 3 }, { user_args = {2} }),
	t({ '\tdef init(self,' }),
	i(3),
	t({ '):', '' }),
	t('\t\t"""'),
	i(5, "Init function Description"),
	t({'"""',''}),
	f(function(args)
		if not args[1][1] or args[1][1] == '' then
			return { '' }
		end
		local a = vim.tbl_map(function(item)
			local trimed = vim.trim(item)
			return '\t\tself.' .. trimed .. ' = ' .. trimed
		end, vim.split(
			args[1][1],
			',',
			true
		))
		return a
	end, {
		3,
	}),
	i(0),
})

local fndoc_snippet = s({ trig = 'fn', dscr = 'Documented Function Structure' }, {
	t('def '),
	i(1, { 'function' }),
	t('('),
	i(2),
	t({ '):', '\t' }),
	d(3, pyfdoc, { 2 }),
})

table.insert(snippets, clsdoc_snippet)
table.insert(snippets, fndoc_snippet)

return snippets, autosnippets
