return {
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
}
