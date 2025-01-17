return {
  {
    'OXY2DEV/markview.nvim',
    -- lazy = false, -- Recommended
    ft = 'markdown', -- If you decide to lazy-load anyway

    opts = function()
      local presets = require 'markview.presets'
      return {
        checkboxes = presets.checkboxes.nerd,
        headings = presets.headings.slanted,
        horizontal_rules = presets.horizontal_rules.arrowed,
        modes = {
          'n',
          'no',
          'c',
          -- 'i'
        },
      }
    end,

    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },

    config = function(_, opts)
      require('markview').setup(opts)

      require('markview.extras.headings').setup()
      require('markview.extras.checkboxes').setup()
      require('markview.extras.editor').setup()
    end,
  },
}
