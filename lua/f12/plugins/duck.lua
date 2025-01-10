return {
  'tamton-aquib/duck.nvim',
  config = function()
    local cdd = {
      '🦆',
      'ඞ ',
      '🦀',
      '🐈',
      '🐎',
      '🦖',
      '🐤',
    }

    local get_cand = function()
      return cdd[math.random(#cdd)]
    end

    vim.keymap.set('n', '<leader>mdd', function()
      require('duck').hatch(get_cand(), math.random() * math.random(1, 15))
    end, { desc = '[d]uck' })
    vim.keymap.set('n', '<leader>mdk', function()
      require('duck').cook()
    end, { desc = '[k]ook' })
    vim.keymap.set('n', '<leader>mda', function()
      require('duck').cook_all()
    end, { desc = 'kook [a]ll' })
  end,
}

