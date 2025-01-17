return {
  'danymat/neogen',
  opts = {
    snippet_engine = 'luasnip',
    languages = {
      ['c.doxygen'] = require 'neogen.configurations.c',
    },
  },
  config = true,
}
