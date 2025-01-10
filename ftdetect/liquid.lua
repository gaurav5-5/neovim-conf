vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Liquid templates',
  pattern = [[*.html]],
  callback = vim.schedule_wrap(function(ev)
    if '---' == vim.fn.getline(1) or nil ~= vim.fn.expand('%:p:h:t'):match '^_%w+' then
      vim.cmd [[set filetype=liquid.html]]
    end
  end),
})
