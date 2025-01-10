return {
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
}
