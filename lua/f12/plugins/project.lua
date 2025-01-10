return {}
--[[ return {
  'ahmedkhalf/project.nvim',
  opts = {
    detection_methods = {
      'pattern',
      'lsp',
    },
    ptterns = {
      '.git',
      '.clang-format',
      'CMakeLists.txt',
      'Makefile',
      'package.json',
      '.svn',
      '.gitignore',
      '=src',
      '=Core',
    },
    show_hidden = true,
  },
  config = function(_, opts)
    require('project_nvim').setup(opts)
    require('telescope').load_extension 'projects'
  end,
} ]]
