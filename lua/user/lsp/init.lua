-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
local navic = require("nvim-navic")
local keymap = vim.keymap.set
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
vim.diagnostic.config({
	virtual_text = true,
	float = {
		source = "always",
	},
})
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=None guibg=None]]
-- lspinfo border
require('lspconfig.ui.windows').default_options.border = 'rounded'

-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
	['textDocument/references'] = require 'lsputil.locations'.references_handler,
	['textDocument/documentSymbol'] = require 'lsputil.symbols'.document_handler
}
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local optsbuf = { noremap = true, silent = true, buffer = bufnr, desc = "Lsp operation:" }
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	keymap('n', 'gD', vim.lsp.buf.declaration, optsbuf)
	keymap('n', 'gd', vim.lsp.buf.definition, optsbuf)
	keymap('n', 'K', vim.lsp.buf.hover, optsbuf)
	keymap('n', 'gi', vim.lsp.buf.implementation, optsbuf)
	keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, optsbuf)
	keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, optsbuf)
	keymap('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, optsbuf)
	keymap('n', '<space>D', vim.lsp.buf.type_definition, optsbuf)
	keymap('n', '<space>rn', vim.lsp.buf.rename, optsbuf)
	keymap('n', '<space>sy', vim.lsp.buf.document_symbol, optsbuf)
	keymap('n', '<space>ca', vim.lsp.buf.code_action, optsbuf)
	keymap('n', 'gr', vim.lsp.buf.references, optsbuf)
	keymap('n', '<space>f', function() vim.lsp.buf.format { async = true } end, optsbuf)
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local hoveropts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = 'rounded',
				source = 'always',
				prefix = ' ',
				scope = 'cursor',
			}
			vim.diagnostic.open_float(nil, hoveropts)
		end
	})
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
	-- require "lsp_signature".on_attach({
	--         hi_parameter = "LspSignatureActiveParameter",
	-- })  -- Note: add in lsp client on-attach
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'clangd', 'texlab', 'lua_ls', 'rust_analyzer' }
local serversopts = {
	pyright = {},
	clangd = {},
	texlab = {},
	rust_analyzer = {},
	lua_ls = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}
for _, lsp in pairs(servers) do
	require('lspconfig')[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
		settings = serversopts[lsp]
	}
end

vim.g.rime_enabled = false


local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
configs.rime_ls = {
	default_config = {
		name = "rime_ls",
		cmd = { '/usr/bin/rime_ls' },
		filetypes = { '*' },
		single_file_support = true,
	},
	settings = {},
	docs = {
		description = [[
https://www.github.com/wlh320/rime-ls

A language server for librime
]],
	}
}

local rime_on_attach = function(client, _)
	local toggle_rime = function()
		client.request('workspace/executeCommand',
			{ command = "rime-ls.toggle-rime" },
			function(_, result, ctx, _)
				if ctx.client_id == client.id then
					vim.g.rime_enabled = result
				end
			end
		)
	end
	-- keymaps for executing command
	vim.keymap.set('n', '<space>rr', function() toggle_rime() end, { desc = "Toggle rime_ls" })
	vim.keymap.set('i', '<C-x>', function() toggle_rime() end, { desc = "Toggle rime_ls" })
	vim.keymap.set('n', '<leader>rs',
		function() vim.lsp.buf.execute_command({ command = "rime-ls.sync-user-data" }) end)
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers

local capabilities_rime = require('cmp_nvim_lsp').default_capabilities()

lspconfig.rime_ls.setup {
	init_options = {
		enabled = vim.g.rime_enabled,
		shared_data_dir = "/usr/share/rime-data",
		user_data_dir = "~/.local/share/rime-ls-cmp",
		log_dir = "~/.local/share/rime-ls-log",
		trigger_characters = {},
		schema_trigger_character = "&" -- [since v0.2.0] 当输入此字符串时请求补全会触发 “方案选单”
	},
	on_attach = rime_on_attach,
	capabilities = capabilities_rime,
}
