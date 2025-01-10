return {
  'p00f/godbolt.nvim',
  lazy = true,
  ft = {
    'c',
    'cpp',
    'rust',
    'h',
    'hpp',
  },
  opts = {
    auto_cleanup = true, -- remove highlights and autocommands on buffer close
    quickfix = {
      enable = true, -- whether to populate the quickfix list in case of errors
      auto_open = true, -- whether to open the quickfix list in case of errors
    },
  },
}
