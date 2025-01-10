-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = {
    (('blink' ~= vim.g.completion_plugin) and 'hrsh7th/nvim-cmp' or 'saighen/blink.cmp'),
    -- 'iguanacucumber/magazine.nvim',
  },
  config = function()
    require('nvim-autopairs').setup {
      check_ts = true,
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        before_key = 'h',
        after_key = 'l',
        cursor_pos_before = true,
        avoid_move_to_end = true, -- stay for direct end_key use
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        manual_position = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
      },
    }

    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'
    local cmp = require 'cmp'

    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    npairs.add_rule(Rule('{%', '%', 'html'))
    npairs.add_rule(Rule('$$', '$$', 'tex'))
  end,
}
