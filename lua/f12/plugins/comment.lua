return {
  'numToStr/Comment.nvim',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  opts = {
    padding = true,
    sticky = true,
    ignore = '^$',
    toggler = {
      line = 'gcc',
      block = 'gbc',
    },
    opleader = {
      line = 'gc',
      block = 'gb',
    },
    extra = {
      above = 'gcO',
      below = 'gco',
      eol = 'gcA',
    },
    mappings = {
      basic = true,
      extra = true,
    },
  },
  config = function(_, opts)
    opts.pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), require('Comment').setup(opts)
  end,
}
