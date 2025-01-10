local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local extras = require 'luasnip.extras'
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require 'luasnip.extras.expand_conditions'
local postfix = require('luasnip.extras.postfix').postfix
local types = require 'luasnip.util.types'
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet
local k = require('luasnip.nodes.key_indexer').new_key

require('luasnip.session.snippet_collection').clear_snippets 'c'

ls.add_snippets('c', {
  s('hst', {
    t 'HAL_StatusTypeDef status;',
    i(0),
  }),

  s(
    'ifd',
    fmt(
      [[
#{} {}
#define {}

{}

#endif // {}
]],
      {
        c(1, {
          t 'if',
          t 'ifdef',
          t 'ifndef',
        }),
        c(2, {
          f(function(args, snip)
            return '_' .. (snip.env.TM_FILENAME:gsub('[%.%-%$]', '_'):upper())
          end),
          i(nil, '_MEOW_H'),
        }),
        rep(2),
        i(0, '// code'),
        rep(2),
      }
    )
  ),

  s('inc', {
    c(1, {
      sn(nil, {
        t '#include "',
        i(1),
        t '"',
        i(0),
      }),
      sn(nil, {
        t '#include <',
        i(1),
        t '>',
        i(0),
      }),
    }),
  }),

  s('inl', {
    c(1, {
      t 'static inline',
      t 'inline',
      t 'static',
    }),
    t ' ',
    i(0),
  }),

  s('csv', {
    t '(void)',
  }),

  s('vv', {
    t 'volatile ',
  }),

  s('def', {
    t '#define ',
    c(1, {
      sn(nil, {
        i(1, 'defterm'),
        t ' ',
        i(2, 'defvalue'),
      }),

      sn(nil, {
        i(1, 'macro_name'),
        t '(',
        c(2, {
          t '...',
          i(1, 'macro_args'),
        }),
        t ') ',
        i(3, 'defvalue'),
      }),
    }),
    i(0),
  }),

  s('cst', {
    t '(',
    c(1, {
      i(1, '<type>'),

      t 'void',

      t 'uint8_t',
      t 'uint16_t',
      t 'uint32_t',

      t 'int8_t',
      t 'int16_t',
      t 'int32_t',

      t 'int',
      t 'float',
      t 'double',
    }),
    c(2, {
      t '*',
      t '',
    }),
    t ')',
    i(0),
  }),
})
