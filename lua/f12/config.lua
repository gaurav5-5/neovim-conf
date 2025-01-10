local config_fn = function(base, path_ext)
  vim.cmd.tabnew()
  vim.cmd.tcd(base)
  vim.cmd.edit(path_ext)
end

local conf = vim.fn.stdpath 'config'

local check_for_existing_tab = function(name)
  local tabs = require('tabby.module.api').get_tabs()
  local tab_name = require 'tabby.feature.tab_name'

  if tab_name.get(0) ~= name then
    for _, el in ipairs(tabs) do
      if name == tab_name.get(el) then
        vim.cmd(tostring(el) .. [[gt]])
      end
    end
  end
end

vim.keymap.set('n', '<localleader>cw', function()
  check_for_existing_tab 'Wezterm'
  config_fn('~/.config/wezterm', './wezterm.lua')
  require('tabby').tab_rename 'Wezterm'
end, { desc = '[w]ezterm' })

vim.keymap.set('n', '<localleader>ci', function()
  check_for_existing_tab 'Neovide'
  config_fn('~/AppData/Roaming/neovide/', './config.toml')
  require('tabby').tab_rename 'Neovide'
end, { desc = 'neov[i]de' })

vim.keymap.set('n', '<localleader>cnn', function()
  check_for_existing_tab 'Neovim'
  config_fn(conf, '.')
  require('tabby').tab_rename 'Neovim'
end, { desc = '[n]eovim' })

vim.keymap.set('n', '<localleader>cnp', function()
  check_for_existing_tab 'Neovim'
  config_fn(conf, 'lua/f12/plugins')
  require('tabby').tab_rename 'Neovim'
end, { desc = '[p]lugins' })

vim.keymap.set('n', '<localleader>cnm', function()
  check_for_existing_tab 'Neovim'
  config_fn(conf, 'lua/f12')
  require('tabby').tab_rename 'Neovim'
end, { desc = '[m]eowzer' })

return {
  goto_config_tree = config_fn,
}
