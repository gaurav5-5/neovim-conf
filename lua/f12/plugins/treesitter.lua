return {
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    main = 'nvim-treesitter.configs',

    dependencies = {
      -- 'nvim-treesitter/nvim-treesitter-context',
      'theHamsta/nvim-treesitter-pairs',
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = {
          enable_autocmd = false,
          languages = {
            c = { __default = '// %s', __multiline = '/* %s */' },
          },
        },
        config = function(_, opts)
          require('ts_context_commentstring').setup(opts)

          local get_option = vim.filetype.get_option
          vim.filetype.get_option = function(ft, opt)
            return 'commentstring' == opt and require('ts_context_commentstring.internal').calculate_commentstring() or get_option(ft, opt)
          end
        end,
      },
    },
    opts = {
      ensure_installed = {
        'arduino',
        'asm',
        'bash',
        'c',
        'cmake',
        'comment',
        'cpp',
        'css',
        'csv',
        'd',
        'diff',
        'disassembly',
        'doxygen',
        'go',
        'gitcommit',
        'gitignore',
        'gnuplot',
        'html',
        'http',
        'ini',
        'javascript',
        'json',
        'json5',
        'jsonc',
        'latex',
        'liquid',
        'linkerscript',
        'lua',
        'luadoc',
        'luap',
        'make',
        'markdown',
        'meson',
        'markdown_inline',
        'nasm',
        'nim',
        'ninja',
        'pioasm',
        'powershell',
        'printf',
        'properties',
        'python',
        'query',
        'r',
        'regex',
        'rst',
        'ruby',
        'rust',
        'scala',
        'scss',
        'svelte',
        'systemverilog',
        'toml',
        'tsx',
        'typescript',
        'verilog',
        'vhdl',
        'vim',
        'vimdoc',
        'vue',
        'xml',
        'yaml',
        'zig',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {
          'ruby',
          'go',
        },
      },
      indent = {
        enable = true,
        disable = {
          'ruby',
        },
      },
      incremental_selection = {
        enable = true,
      },
      -- treesitter_context = {
      --   enable = true,
      -- },
      pairs = {
        enable = true,
      },
    },

    config = function(_, opts)
      local ts_install = require 'nvim-treesitter.install'

      ts_install.prefer_git = true
      ts_install.compilers = {
        'gcc',
        'clang',
        'tcc',
        'cc',
        'zig',
      }

      require('nvim-treesitter').setup(opts)
    end,
  },

  -- Treewalker
  {
    'aaronik/treewalker.nvim',
    opts = {
      highlight = true,
      highlight_duration = 250,
    },
    keys = {
      { '<M-k>', '<CMD>Treewalker Up<CR>', { silent = true } },
      { '<M-j>', '<CMD>Treewalker Down<CR>', { silent = true } },
      { '<M-h>', '<CMD>Treewalker Left<CR>', { silent = true } },
      { '<M-l>', '<CMD>Treewalker Right<CR>', { silent = true } },

      { '<M-Up>', '<CMD>Treewalker Up<CR>', { silent = true } },
      { '<M-Down>', '<CMD>Treewalker Down<CR>', { silent = true } },
      { '<M-Left>', '<CMD>Treewalker Left<CR>', { silent = true } },
      { '<M-Right>', '<CMD>Treewalker Right<CR>', { silent = true } },

      { '<M-S-k>', '<CMD>Treewalker SwapUp<CR>', { silent = true } },
      { '<M-S-j>', '<CMD>Treewalker SwapDown<CR>', { silent = true } },
      { '<M-S-h>', '<CMD>Treewalker SwapLeft<CR>', { silent = true } },
      { '<M-S-l>', '<CMD>Treewalker SwapRight<CR>', { silent = true } },

      { '<M-S-Up>', '<CMD>Treewalker SwapUp<CR>', { silent = true } },
      { '<M-S-Down>', '<CMD>Treewalker SwapDown<CR>', { silent = true } },
      { '<M-S-Left>', '<CMD>Treewalker SwapLeft<CR>', { silent = true } },
      { '<M-S-Right>', '<CMD>Treewalker SwapRight<CR>', { silent = true } },
    },
  },

  -- Tabout
  {
    {
      'abecodes/tabout.nvim',
      lazy = true,
      config = function()
        require('tabout').setup {
          tabkey = '<Tab>',
          backwards_tabkey = '<S-Tab>',
          default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
          default_shift_tab = '<C-d>', -- reverse shift default action,
          tabouts = {
            { open = "'", close = "'" },
            { open = '"', close = '"' },
            { open = '`', close = '`' },
            { open = '(', close = ')' },
            { open = '[', close = ']' },
            { open = '{', close = '}' },
          },
          ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
          exclude = {}, -- tabout will ignore these filetypes
        }
      end,
      dependencies = { -- These are optional
        'nvim-treesitter/nvim-treesitter',
        'L3MON4D3/LuaSnip',
      },
      opt = true, -- Set this to true if the plugin is optional
      event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
      priority = 1000,
    },
  },
}
