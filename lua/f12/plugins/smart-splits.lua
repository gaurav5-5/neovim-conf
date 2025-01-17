return {
  {
    'kwkarlwang/bufresize.nvim',
    opts = {},
  },
  {
    'mrjones2014/smart-splits.nvim',
    dependencies = {
      'kwkarlwang/bufresize.nvim',
    },
    opts = {
      resize_mode = {
        hooks = {
          on_enter = function()
            vim.notify('Entering Resize Mode', 3)
          end,

          on_leave = function()
            vim.notify('Exiting Resize Mode', 3)
            require('bufresize').register()
          end,
        },
      },
    },
  },
}
