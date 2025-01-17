return {
  'echasnovski/mini.nvim',
  config = function()
    local hipatterns = require 'mini.hipatterns'
    local ai = require 'mini.ai'
    local align = require 'mini.align'

    ai.setup { n_lines = 500 }

    hipatterns.setup {
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }

    align.setup {
      mappings = {
        start = 'ga',
        start_with_preview = 'gA',
      },
    }
  end,
}
