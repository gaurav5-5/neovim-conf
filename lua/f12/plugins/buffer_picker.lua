return {
  'nvimdev/flybuf.nvim',
  cmd = 'FlyBuf',
  keys = {
    { '<localleader>b', '<CMD>FlyBuf<CR>', desc = '[b]ufjump' },
  },
  opts = {
    border = 'rounded',
    mark = 'x',
    delete = 'X',
  },
}
--[[
return {
  'leath-dub/snipe.nvim',
  keys = {
    {
      '<leader>bs',
      function()
        require('snipe').open_buffer_menu()
      end,
      desc = 'Open Snipe buffer menu',
    },
  },
  opts = {},
}
--]]
