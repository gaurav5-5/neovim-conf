return {
  'lewis6991/hover.nvim',
  opts = {
    init = function()
      -- Require providers
      require 'hover.providers.lsp'
      require 'hover.providers.gh'
      require 'hover.providers.gh_user'
      -- require('hover.providers.jira')
      -- require('hover.providers.dap')
      require 'hover.providers.fold_preview'
      require 'hover.providers.diagnostic'
      -- require('hover.providers.man')
      -- require('hover.providers.dictionary')
    end,
    preview_opts = {
      border = 'double',
    },
    -- Whether the contents of a currently open hover window should be moved
    -- to a :h preview-window when pressing the hover keymap.
    preview_window = true,
    title = true,
    mouse_providers = {
      'LSP',
    },
    mouse_delay = 1000,
  },
  config = function(_, opts)
    require('hover').setup(opts)

    -- Setup keymaps
    vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
    vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })

    -- Mouse support
    vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
    vim.o.mousemoveevent = true
  end,
}
