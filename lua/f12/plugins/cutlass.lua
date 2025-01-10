return {
  'gbprod/cutlass.nvim',
  opts = {
    cut_key = 'd',
    override_del = true,
    exclude = {
      'ns',
      'nS',
    },
    registers = {
      select = '_',
      delete = '*',
      change = '_',
    },
  },
  config = function(_, opts)
    require('cutlass').setup(opts)
  end,
}
