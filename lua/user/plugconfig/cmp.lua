local cmp = require'cmp'
cmp.setup {
  sources = {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline' },
  },
}
cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})
require'cmp'.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
