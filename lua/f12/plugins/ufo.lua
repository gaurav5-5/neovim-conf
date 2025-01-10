return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  opts = {
    open_fold_hl_timeout = 150,
    close_fold_kinds_for_ft = {
      -- default = { 'imports', 'comment' },
      -- c = { 'comment', 'region' },
    },
    provider_selector = function(bufnr, filetype, buftype)
      local client = vim.lsp.get_clients { bufnr = bufnr }
      if vim.tbl_isempty(client) then
        return { 'treesitter', 'indent' }
      else
        return { 'lsp', 'treesitter' }
      end
    end,
  },
  config = function(_, opts)
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    require('ufo').setup(opts)
  end,
}
