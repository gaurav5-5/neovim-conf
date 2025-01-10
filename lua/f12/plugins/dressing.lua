return {
  'stevearc/dressing.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    input = {
      enabled = true,
      default_prompt = '[ Meow   ]',
      title_pos = 'right',
      border = 'single',
      relative = 'editor',
    },
    select = {
      enabled = true,
      backend = {
        'telescope',
        'nui',
        'builtin',
        'fzf',
        'fzf-lua',
      },
      telescope = require('telescope.themes').get_dropdown {},
      get_config = function(opts)
        if 'codeaction' == opts.kind then
          return {
            backend = 'nui',
            nui = {
              -- relative = 'cursor',
              max_width = 40,
            },
          }
        end
        return nil
      end,
    },
  },
}
