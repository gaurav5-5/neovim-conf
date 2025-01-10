vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Set filetype to include doxyge for C',
  pattern = [[*.c]],
  command = [[set filetype=c.doxygen]],
})
