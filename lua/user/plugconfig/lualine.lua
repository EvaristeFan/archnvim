require('lualine').setup {
  options = {
    theme = 'papercolor_light',
    icons_enabled = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch',
      { 'diagnostics',
        sources = { 'nvim_lsp' },
	sections = { 'error', 'warn', 'info', 'hint' },
	symbols = { error = " ", warn = " ", hint = " ", info = " " },
        colored = true,           -- Displays diagnostics status in color if set to true.
    },
  },
    lualine_c = {
    { 'filename',
      path = 3,
    },
    {
    function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },},
    'lsp_progress'
  },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
  },

  tabline = {},
  extensions = {}
}
