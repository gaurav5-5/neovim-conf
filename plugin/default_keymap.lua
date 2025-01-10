vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', ';', ':')

vim.keymap.set('n', '<localleader>lq', vim.diagnostic.setloclist, { desc = 'diagnostic [q]uickfix' })

-- vim.keymap.set('n', '<localleader>tb', function()
--   local word = vim.fn.expand '<cword>'
--   if 'true' == word then
--     vim.cmd.norm [[ciwfalse]]
--   elseif 'false' == word then
--     vim.cmd.norm [[ciwtrue]]
--   elseif 'True' == word then
--     vim.cmd.norm [[ciwFalse]]
--   elseif 'False' == word then
--     vim.cmd.norm [[ciwTrue]]
--   else
--     vim.notify('Not a Boolean Value', vim.log.levels.ERROR)
--   end
-- end, { desc = '[b]oolean' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {})

vim.keymap.set('n', 'vv', 'V', {})

vim.cmd [[nnoremap <expr> j line(".") == line('$') ? '<C-e>':'j']]
vim.cmd [[nnoremap <expr> <Down> line(".") == line('$') ? '<C-e>':'j']]

vim.keymap.set('n', '<leader>b1', '<CMD>bfirst<CR>', { desc = 'first' })
vim.keymap.set('n', '<leader>bb', '<CMD>bnext<CR>', { desc = 'next' })
vim.keymap.set('n', '<leader>bn', '<CMD>bnext<CR>', { desc = '[n]ext' })
vim.keymap.set('n', '<leader>bp', '<CMD>bprev<CR>', { desc = '[p]revious' })
vim.keymap.set('n', '<leader>be', '<CMD>blast<CR>', { desc = '[e]nd' })

vim.keymap.set('n', '<leader>kb', '<CMD>bdelete %<CR>', { desc = '[b]uffer' })
vim.keymap.set('n', '<leader>kw', '<CMD>q<CR>', { desc = '[w]indow' })
vim.keymap.set('n', '<leader>kt', '<CMD>tabclose<CR>', { desc = '[t]ab' })

require 'f12.config'
