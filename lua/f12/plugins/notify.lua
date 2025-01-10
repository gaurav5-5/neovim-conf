return {
    'rcarriga/nvim-notify',
    opts = {},
    config = function(_, opts)
        vim.opt.termguicolors = true
        require('notify').setup(opts)
        vim.notify = require 'notify'
    end,
}
