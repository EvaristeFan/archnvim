return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"nvim-treesitter/nvim-treesitter"
	},
	config = function()
		local cmp = require 'cmp' or {}
		local compare = require 'cmp.config.compare'
		local luasnip = require('luasnip')
		local lspkind = require('lspkind')

		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and
			    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		cmp.setup({
			snippet = {
				expand = function(args)
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = 'symbol_text', -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					before = function(entry, vim_item)
						vim_item.menu = ({
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							path = "[Path]"
						})[entry.source.name]
						return vim_item
					end
				})
			},
			mapping = {
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<CR>'] = cmp.mapping.confirm({ select = true }),
				['<C-p>'] = cmp.mapping.close(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				-- Rime
				['<Space>'] = cmp.mapping(function(fallback)
					local entry = cmp.get_selected_entry()
					if entry and entry.source.name == "nvim_lsp"
					    and entry.source.source.client.name == "rime_ls" then
						cmp.confirm({
							behavior = cmp.ConfirmBehavior.Replace,
							select = true,
						})
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				-- { name = 'buffer' },
				{ name = 'path' },
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
			sorting = {
				comparators = {
					compare.sort_text,
					compare.offset,
					compare.exact,
					compare.score,
					compare.recently_used,
					compare.kind,
					compare.length,
					compare.order,
				}
			},
		})
		-- Setup lspconfig.
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline({
				['<CR>'] = cmp.mapping.confirm({ select = true }),
			}),
			sources = {
				{ name = 'cmdline',         priority_weight = 1000000 },
				{ name = 'cmdline_history', priority_weight = 0 },
			}
		})
		cmp.setup.cmdline('/', {
			sources = {
				{ name = 'buffer' }
			},
			mapping = cmp.mapping.preset.cmdline()
		})
	end
}
