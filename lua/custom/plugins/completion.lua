--[[local cmp = require('cmp')

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- `select = false` confirms only explicit selection
    ['<Down>'] = cmp.mapping(function(fallback)
        cmp.close()
        fallback()
    end, { 'i' }),
    ['<Up>'] = cmp.mapping(function(fallback)
        cmp.close()
        fallback()
    end, { 'i' }),
  }),
})]]--

return {}
