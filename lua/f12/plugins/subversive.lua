return {
  'svermeulen/vim-subversive',
  config = function()
    vim.keymap.set({ 'n', 'x' }, '<localleader>s', '<plug>(SubversiveSubstituteRange)')
    vim.keymap.set({ 'n' }, '<localleader>ss', '<plug>(SubversiveSubstituteWordRange)')
  end,
}
