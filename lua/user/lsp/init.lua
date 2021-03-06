-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
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
local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'rounded'
  return opts
end
-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = 'rounded'}),
  ['textDocument/references'] = require'lsputil.locations'.references_handler
}
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  local optsbuf = { noremap=true, silent=true, buffer = bufnr}
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', optsbuf)
  keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', optsbuf)
  keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', optsbuf)
  keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', optsbuf)
  keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', optsbuf)
  keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', optsbuf)
  keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', optsbuf)
  keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', optsbuf)
  keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', optsbuf)
  keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', optsbuf)
  keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', optsbuf)
  keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', optsbuf)
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
  require "lsp_signature".on_attach({
	  hi_parameter = "LspSignatureActiveParameter",
  })  -- Note: add in lsp client on-attach
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'clangd', 'texlab', 'sumneko_lua', 'rust_analyzer'}
local serversopts = {
    pyright = {},
    clangd = {},
    texlab = {},
    rust_analyzer = {},
    sumneko_lua = {
	    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
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
    handlers=handlers,
    settings = serversopts[lsp]
  }
end
