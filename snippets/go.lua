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

require('luasnip.session.snippet_collection').clear_snippets 'go'

ls.add_snippets('go', {
  s('rerr', {
    t {
      'if nil != err {',
      '  return err',
      '}',
    },
    i(0),
  }),
  s('paerr', {
    t {
      'if nil != err {',
      '  panic(err)',
      '}',
    },
    i(0),
  }),
  s('perr', {
    t {
      'if nil != err {',
      '\tfmt.Println("Error: %s", err)',
      '\treturn',
      '}',
    },
    i(0),
  }),

  s('sterr', {
    t 'if err := ',
    i(1, 'nil'),
    t '; nil != err {',
    t {
      '\tfmt.Fprintf(os.Stderr, "Error: %s", err)',
      '\tos.Exit(1)',
      '}',
    },
    i(0),
  }),

  postfix('.pkg', {
    f(function(_, parent)
      return [[package ]] .. parent.snippet.env.POSTFIX_MATCH
    end, {}),
  }),
})
