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

require('luasnip.session.snippet_collection').clear_snippets 'markdown'

ls.add_snippets('markdown', {
  s('h1', { t '# ' }),
  s('h2', { t '## ' }),
  s('h3', { t '### ' }),
  s('h4', { t '#### ' }),
  s('h5', { t '##### ' }),

  s('img', {
    t '![',
    i(1),
    t ']',
    t '(',
    i(2),
    t ')',
    i(0),
  }),

  postfix('.lnk', {
    f(function(_, parent)
      return sn(nil, { t('[' .. parent.snippet.env.POSTFIX_MATCH .. ']('), i(0), t ')' })
    end, {}),
  }),
  postfix('.hl', {
    f(function(_, parent)
      return '<' .. parent.snippet.env.POSTFIX_MATCH .. '>'
    end, {}),
  }),
})
