return {
  {
    'williamboman/mason.nvim',
    opts = {
      PATH = 'append',
      max_concurrent_installers = 5,
      ui = {
        border = 'single',
        keymaps = {
          toggle_package_expand = '<CR>',
          install_package = 'i',
          update_package = 'u',
          check_package_version = 'C',
          update_all_packages = 'U',
          check_outdated_packages = 'c',
          uninstall_package = 'x',
          cancel_installation = '<C-c>',
          apply_language_filter = '<C-f>',
          toggle_package_install_log = '<CR>',
          toggle_help = '?',
        },
      },
    },
    config = true,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = require 'f12.servers.extras',
    },
    config = true,
  },
}
