return {
  'nvim-telescope/telescope.nvim',
  -- branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return 1 == vim.fn.executable 'make'
      end,
    },
    {
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-symbols.nvim',
    },

    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  opts = {
    pickers = {
      themes = {
        initial_mode = 'normal',
      },
      find_files = {
        hidden = true,
      },
      live_grep = {
        only_sort_text = true,
      },
      colorscheme = {
        enable_preview = true,
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      },
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local actions = require 'telescope.actions'
    local action_state = require 'telescope.actions.state'

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[h]elp' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[k]eymaps' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]iles' })
    vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[s]elect Telescope' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'current [w]ord' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'by [g]rep' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[d]iagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[r]esume' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<localleader>ct', function()
      builtin.colorscheme(require('telescope.themes').get_ivy {
        initial_mode = 'normal',
        winblend = 10,
        previewer = true,
        attach_mappings = function(prompt_bufnr, map)
          map({ 'n', 'i' }, 't', function()
            if 'dark' == vim.o.background then
              vim.o.background = 'light'
            else
              vim.o.background = 'dark'
            end
          end)

          map({ 'n', 'i' }, '<CR>', function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if nil ~= selection then
              vim.cmd.colorscheme(selection[1])
              local f = io.open(vim.fn.stdpath 'config' .. '/lua/f12/colorscheme.lua', 'w')
              if nil ~= f then
                f:write(("vim.opt.background = '%s'\nvim.cmd.colorscheme('%s')\n"):format(vim.o.background, selection[1]))
                f:close()
              end
            end
          end)

          return true
        end,
      })
    end, { desc = '[t]heme' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzy search in current buffer' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<localleader>fn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
