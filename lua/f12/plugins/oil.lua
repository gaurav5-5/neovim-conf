return {
  'stevearc/oil.nvim',
  opts = {
    constrain_cursor = 'name',
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, '.')
      end,
      is_always_hidden = function(name, bufnr)
        return false
      end,
      natural_order = true,
      case_insensitive = false,
      sort = {
        { 'type', 'asc' },
        { 'name', 'asc' },
      },
    },
  },
  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '<localleader>o', '<CMD>Oil<CR>', { desc = 'open [o]il' })
  end,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
