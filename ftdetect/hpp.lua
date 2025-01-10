vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Set filetype to include doxygen for H',
  group = vim.api.nvim_create_augroup('f12-ft-detect', { clear = false }),
  pattern = [[*.h]],
  command = [[set filetype=c.doxygen]],
})
