return {
  {
    'ggandor/leap.nvim',
    lazy = false,
    dependencies = {
      'tpope/vim-repeat',
    },
    config = function()
      vim.keymap.set('n', '<leader>s', '<Plug>(leap)', { desc = 'leap' })
      vim.keymap.set('n', '<leader>S', '<Plug>(leap-from-window)', { desc = 'leap from window' })
      vim.keymap.set({ 'x', 'o' }, '<leader>s', '<Plug>(leap-forward)', { desc = 'leap' })
      vim.keymap.set({ 'x', 'o' }, '<leader>S', '<Plug>(leap-backward)', { desc = 'leap backward' })
    end,
  },
  {
    'ggandor/flit.nvim',
    dependencies = {
      'ggandor/leap.nvim',
      'tpope/vim-repeat',
    },
    opts = {
      keys = {
        f = 'f',
        F = 'F',
        t = 't',
        T = 'T',
      },
      clever_repeat = true,
      multiline = true,
      opts = {},
    },
  },
}
