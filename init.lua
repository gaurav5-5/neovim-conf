if nil ~= vim.loader then
  vim.loader.enable()
end

-- Setup RNG
math.randomseed(os.time())
math.random()
math.random()
math.random()

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.have_nerd_font = true

vim.schedule(function()
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.mouse = 'a'
  vim.opt.showmode = true

  vim.opt.clipboard:prepend { 'unnamedplus', 'unnamedplus' }

  vim.opt.breakindent = true
  vim.opt.undofile = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.signcolumn = 'yes'
  vim.opt.updatetime = 250
  vim.opt.timeoutlen = 300
  vim.opt.splitright = true
  vim.opt.splitbelow = true
  vim.opt.list = true
  vim.opt.listchars = {
    tab = '⎸ ',
    trail = '·',
    nbsp = '␣',
    -- eob = '~',
  }
  vim.opt.inccommand = 'split'
  vim.opt.cursorline = true
  vim.opt.scrolloff = 10
  vim.opt.laststatus = 3
  vim.opt.modeline = false
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4

  -- shellopts
  if 1 == vim.fn.has 'win32' then
    vim.opt.shell = vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell'
    vim.opt.shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    vim.opt.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
    vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.opt.shellquote = ''
    vim.opt.shellxquote = ''
  end
end)

-- completion
vim.g.completion_plugin = 'cmp'

require 'f12.lazy'
require 'f12.colorscheme'
