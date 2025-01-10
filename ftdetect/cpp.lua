vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Set filetype to include doxygen for C++',
  group = vim.api.nvim_create_augroup('f12-ft-detect', { clear = false }),
  pattern = [[*.cpp]],
  command = [[set filetype=cpp.doxygen]],
})
