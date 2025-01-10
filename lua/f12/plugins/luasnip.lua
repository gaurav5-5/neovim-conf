return {
  'L3MON4D3/LuaSnip',

  build = (function()
    if 0 == vim.fn.executable 'make' then
      return
    end
    return 'make install_jsregexp'
  end)(),

  dependencies = {
    -- {
    --   'rafamadriz/friendly-snippets',
    --   config = function()
    --     require('luasnip.loaders.from_vscode').lazy_load()
    --   end,
    -- },
  },

  opts = {
    exit_roots = true,
    delete_check_events = 'TextChanged',
  },

  config = function(_, opts)
    local luasnip = require 'luasnip'
    luasnip.setup(opts)

    require('luasnip.loaders.from_lua').lazy_load {
      paths = {
        vim.fn.stdpath 'config' .. '/snippets/',
      },
    }
  end,
}
