return {
  {
    'smoka7/hop.nvim',
    version = '*',
    dependencies = {
      'tpope/vim-repeat',
    },
    opts = {
      keys = 'sdfghjkwertyuioqpxcvbnmz',
    },
    config = function(_, opts)
      local hop = require 'hop'
      hop.setup(opts)
      local directions = require('hop.hint').HintDirection

      local maps = {
        w = 'Word',
        f = 'Char1',
        s = 'Char2',
        l = 'Line',
        L = 'LineStart',
        v = 'Vertical',
        'Word',
      }

      for k, v in pairs(maps) do
        vim.keymap.set('n', '<localleader><localleader>' .. k, '<CMD>Hop' .. v .. '<CR>', { desc = 'hop ' .. v:lower() })
        vim.keymap.set('n', '<leader><leader>' .. k, '<CMD>Hop' .. v .. '<CR>', { desc = 'hop ' .. v:lower() })
      end
      vim.keymap.set('n', maps[1], '<localleader><localleader><localleader>', {})
      vim.keymap.set('n', maps[1], '<leader><leader><leader>', {})
    end,
  },
}
