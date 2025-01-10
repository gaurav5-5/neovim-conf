return {
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   opts = {
  --     render_modes = true,
  --     anti_conceal = {
  --       enabled = true,
  --     },
  --     pipe_table = {
  --       preset = 'round',
  --     },
  --     -- preset = 'lazy',
  --     quote = {
  --       repeat_linebreak = true,
  --     },
  --     callout = { note = { quote_icon = '█' } },
  --     checkbox = {
  --       position = 'overlay',
  --     },
  --     code = {
  --       position = 'right',
  --       width = 'block',
  --       min_width = 45,
  --       right_pad = 10,
  --       left_pad = 2,
  --       language_pad = 1,
  --     },
  --     heading = {
  --       border = true,
  --     },
  --     indent = {
  --       enabled = true,
  --       skip_level = 0,
  --       per_level = 2,
  --     },
  --     win_options = {
  --       showbreak = {
  --         default = '',
  --         rendered = '    ',
  --       },
  --       breakindent = {
  --         default = false,
  --         rendered = false,
  --       },
  --       breakindentopt = {
  --         default = '',
  --         rendered = '',
  --       },
  --     },
  --   },
  -- },

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
