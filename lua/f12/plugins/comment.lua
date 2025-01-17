return {
  -- Comment
  {
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
  },

  -- Comment-Bok
  {
    'LudoPinelli/comment-box.nvim',
    opts = {
      comment_style = 'auto',
    },
    config = function()
      vim.g.cb_default_line = 1
      vim.g.cb_default_box = 1

      vim.keymap.set('n', ']b', '/\\S\\zs\\s*╭<CR>zt', { desc = 'Next Comment Box' })
      vim.keymap.set('n', '[b', '?\\S\\zs\\s*╭<CR>zt', { desc = 'Previous Comment Box' })

      local opts = { noremap = true, silent = true }
      local cb = require 'comment-box'
      local modes = { 'n', 'v' }

      vim.keymap.set(modes, '<localleader>/b', function()
        cb.llbox(vim.g.cb_default_line)
      end, opts)
      vim.keymap.set(modes, '<localleader>/l', function()
        cb.lline(vim.g.cb_default_box)
      end, opts)
      vim.keymap.set(modes, '<localleader>/c', function()
        cb.catalog()
      end, opts)
    end,
  },
}
