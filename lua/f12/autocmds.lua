-- Highlight on Yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = [[doc/*.txt]],
  desc = 'Move help to right split',
  group = vim.api.nvim_create_augroup('f12', { clear = false }),
  callback = function()
    if 100 <= vim.o.columns then
      vim.cmd [[wincmd L]]
    end
  end,
})
