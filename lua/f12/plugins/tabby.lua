return {
  'nanozuki/tabby.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = function()
    vim.o.showtabline = 2
    return {
      preset = 'active_wins_at_tail',
      nerdfont = true,
      buf_name = {
        mode = 'unique',
      },
    }
  end,
  config = function(_, opts)
    require('tabby').setup(opts)
    vim.keymap.set(
      'n',
      '<leader><Tab>r',
      vim.schedule_wrap(function()
        vim.ui.input({ prompt = 'TabRenamer v1.0' }, function(input)
          vim.notify(input)
          vim.cmd([[Tabby rename_tab ]] .. input)
        end)
      end),
      { desc = '[tab] [r]ename' }
    )
    vim.keymap.set('n', '<Tab>', '<CMD>tabnext<CR>', { desc = '[tab] next' })
    vim.keymap.set('n', '<leader><Tab><Tab>', '<CMD>tabnext<CR>', { desc = '[tab] next' })
    vim.keymap.set('n', '<leader><Tab>n', '<CMD>tabnext<CR>', { desc = '[tab] [n]ext' })
    vim.keymap.set('n', '<leader><Tab>p', '<CMD>tabprev<CR>', { desc = '[tab] [p]revious' })
    vim.keymap.set('n', '<leader><Tab>j', '<CMD>Tabby jump_to_tab<CR>', { desc = '[tab] [j]ump' })
    vim.keymap.set('n', '<leader><Tab>x', '<CMD>tabclose<CR>', { desc = '[tab] close' })
    vim.keymap.set('n', '<leader><Tab>l', '<CMD>+tabmove<CR>', { desc = '[tab] movve right' })
    vim.keymap.set('n', '<leader><Tab>h', '<CMD>-tabmove<CR>', { desc = '[tab] move left' })

    vim.api.nvim_create_user_command('Tabclose', function(args)
      local api = require 'tabby.module.api'
      local tabs = api.get_tab_wins(api.get_current_tab())

      for _, v in ipairs(tabs) do
        local buffer = api.get_win_buf(v)
        vim.cmd([[bdelete ]] .. buffer)
      end
    end, { nargs = '*', desc = 'Delete buffers and close tab' })
  end,
}
