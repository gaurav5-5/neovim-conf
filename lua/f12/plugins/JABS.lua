return {}
--[[
return {
  {
    'matbme/JABS.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      position = {
        'center',
        'bottom',
      },
      relative = 'editor',
      border = 'shadow',
      keymap = {
        close = '<Esc>',
        jump = '<CR>',
        h_split = 'h',
        v_split = 'v',
        preview = 'p',
      },
      use_devicons = true,
    },
    config = function(_, opts)
      require('jabs').setup(opts)

      vim.keymap.set('n', '<leader>bP', '<CMD>JABSOpen<CR>', { desc = 'JABS' })
    end,
  },
}
--]]
