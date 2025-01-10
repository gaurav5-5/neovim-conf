return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = function()
    return {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          -- {
          --   'buffers',
          --   mode = 2,
          --   filetype_names = {
          --     TelescopePrompt = 'Telescope',
          --     dashboard = 'Dashboard',
          --     packer = 'Packer',
          --     fzf = 'FZF',
          --     alpha = 'Alpha',
          --   },
          --   use_mode_colors = true,
          --   symbols = {
          --     modified = ' ●',
          --     alternate_file = '#',
          --     directory = '',
          --   },
          -- },
        },
        lualine_c = { 'branch', 'diff', 'diagnostics' },
        lualine_x = { 'filename', 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}