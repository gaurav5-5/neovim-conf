return {
  'echasnovski/mini.nvim',
  config = function()
    local hipatterns = require 'mini.hipatterns'
    local ai = require 'mini.ai'

    ai.setup { n_lines = 500 }

    hipatterns.setup {
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}
