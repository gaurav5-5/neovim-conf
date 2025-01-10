return {
  'toppair/peek.nvim',
  event = { 'VeryLazy' },
  build = 'deno task --quiet build:fast',
  opts = {
    auto_load = false,
    close_on_bdelete = true,
    theme = vim.opt.background:get(),
  },
  config = function(_, opts)
    require('peek').setup(opts)
    vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
  end,
}
