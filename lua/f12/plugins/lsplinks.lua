return {
  'icholy/lsplinks.nvim',
  opts = {},
  config = function(_, opts)
    local lsplinks = require 'lsplinks'
    lsplinks.setup(opts)
    vim.keymap.set('n', 'gx', lsplinks.gx)
  end,
}

