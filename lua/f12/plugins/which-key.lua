return {
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
  opts = {
    preset = 'helix',
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrlWhlDwn> ',
        ScrollWheelUp = '<ScrlWhlUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<SPC> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },

    -- Document existing key chains
    spec = {
      { '<leader>md', group = '[d]ucks' },
      { '<leader>m', group = '[m]isc' },
      { '<leader>f', group = '[f]ind' },
      {
        '<localleader>w',
        group = '[w]indow',
        proxy = '<C-w>',
        expand = function()
          return require('which-key.extras').expand.win()
        end,
      },
      -- { '<leader>t', group = '[t]oggle' },
      { '<leader>b', group = '[b]uffer' },
      { '<leader>k', group = '[k]ill' },
      { '<leader><Tab>', group = '[Tab]' },
      { '<leader><leader>', group = 'Hop' },
      { '<localleader><localleader>', group = 'Hop' },
      { '<localleader>f', group = '[f]ind' },
      {
        '<localleader>b',
        group = '[b]uffer',
        expand = function()
          return require('which-key.extras').expand.buf()
        end,
      },
      { '<localleader>t', group = '[t]oggle' },
      { '<localleader>l', group = '[l]sp' },
      { '<localleader>c', group = '[c]onfigure' },
      { '<localleader>cn', group = '[n]eovim' },
    },
  },
}
