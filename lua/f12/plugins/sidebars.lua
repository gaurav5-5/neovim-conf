-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  {
    'nvim-neo-tree/neo-tree.nvim',

    version = '*',

    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },

    cmd = 'Neotree',

    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },

    opts = {
      source_selector = {
        winbar = true,
        statusline = true,
      },
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    },
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      layout = {
        default_direction = 'prefer_right',
      },
      close_automatic_events = {
        'unfocus',
        'switch_buffer',
        'unsupported',
      },
      close_on_seleect = true,
    },
    config = function(_, opts)
      require('aerial').setup(opts)
      require('telescope').load_extension 'aerial'
    end,
  },
}
