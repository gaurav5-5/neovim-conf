vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Set filetype to help for doc/',
  group = vim.api.nvim_create_augroup('f12-ft-detect', { clear = false }),
  pattern = [[**/doc/**.txt]],
  command = [[set filetype=help]],
})
