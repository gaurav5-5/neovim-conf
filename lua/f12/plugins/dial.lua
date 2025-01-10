return {
  'monaqa/dial.nvim',
  lazy = false,
  opts = function()
    local augend = require 'dial.augend'
    return {
      default = {
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.integer.alias.octal,
        augend.integer.alias.binary,
        augend.semver.alias.semver,
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.date.alias['%Y/%m/%d'],
        augend.date.alias['%H:%M:%S'],
        augend.date.alias['%H:%M'],
        augend.constant.new {
          elements = { 'true', 'false' },
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'True', 'False' },
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'LOW', 'HIGH' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'org', 'com', 'net', 'dev', 'io', 'in' },
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'http', 'https' },
          cyclic = true,
        },
        augend.constant.new {
          elements = {
            'Thin',
            'ExtraLight',
            'Light',
            'Regular',
            'Medium',
            'Semibold',
            'Bold',
            'Black',
          },
          cyclic = true,
        },
      },
      c = {
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.integer.alias.octal,
        augend.integer.alias.binary,
        augend.semver.alias.semver,
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.constant.new {
          elements = {
            'uint',
            'int',
          },
          cyclic = true,
          word = true,
        },
        augend.constant.new {
          elements = {
            'HAL_OK',
            'HAL_ERROR',
            'HAL_TIMEOUT',
          },
          cyclic = true,
        },
        augend.constant.new {
          elements = {
            'GPIO_PIN_SET',
            'GPIO_PIN_RESET',
          },
          cyclic = true,
          word = true,
        },
        augend.constant.new {
          elements = { '&&', '||' },
          cyclic = true,
        },
      },
      visual = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias['%Y/%m/%d'],
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
      },
    }
  end,
  config = function(_, opts)
    require('dial.config').augends:register_group(opts)
    vim.keymap.set('n', '<C-a>', function()
      require('dial.map').manipulate('increment', 'normal')
    end)
    vim.keymap.set('n', '<C-x>', function()
      require('dial.map').manipulate('decrement', 'normal')
    end)
    vim.keymap.set('n', 'g<C-a>', function()
      require('dial.map').manipulate('increment', 'gnormal')
    end)
    vim.keymap.set('n', 'g<C-x>', function()
      require('dial.map').manipulate('decrement', 'gnormal')
    end)
    vim.keymap.set('v', '<C-a>', function()
      require('dial.map').manipulate('increment', 'visual')
    end)
    vim.keymap.set('v', '<C-x>', function()
      require('dial.map').manipulate('decrement', 'visual')
    end)
    vim.keymap.set('v', 'g<C-a>', function()
      require('dial.map').manipulate('increment', 'gvisual')
    end)
    vim.keymap.set('v', 'g<C-x>', function()
      require('dial.map').manipulate('decrement', 'gvisual')
    end)
  end,
}
