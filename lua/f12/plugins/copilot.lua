return {
  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = 'Copilot',
  --   event = 'InsertEnter',
  --   dependencies = {
  --     'zbirenbaum/copilot-cmp',
  --   },
  --   config = function()
  --     require('copilot').setup {

  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = false, -- Disable auto trigger
  --         keymap = {
  --           accept = '<M-l>', -- Alt+l to accept suggestion
  --           next = '<M-n>', -- Alt+] to get next suggestion
  --           prev = '<M-p>', -- Alt+[ to get previous suggestion
  --           dismiss = '<C-]>', -- Ctrl+] to dismiss suggestion
  --         },
  --       },
  --       panel = {
  --         enabled = true,
  --         auto_refresh = true,
  --         keymap = {
  --           jump_prev = '[[',
  --           jump_next = ']]',
  --           accept = '<CR>',
  --           refresh = 'gr',
  --           open = '<M-o>', -- Alt+o to open panel
  --           close = '<M-c>',
  --         },
  --       },
  --     }

  --     -- Create commands to enable/disable Copilot
  --     vim.api.nvim_create_user_command('CopilotEnable', function()
  --       vim.cmd 'Copilot enable'
  --       vim.notify('Copilot enabled', vim.log.levels.INFO)
  --     end, {})

  --     vim.api.nvim_create_user_command('CopilotDisable', function()
  --       vim.cmd 'Copilot disable'
  --       vim.notify('Copilot disabled', vim.log.levels.INFO)
  --     end, {})

  --     -- Optional: Set up a keymap to toggle Copilot
  --     vim.keymap.set('n', '<leader>cp', ':Copilot<CR>', { silent = true, desc = 'Toggle Copilot' })
  --   end,
  -- },
  -- {
  --   'zbirenbaum/copilot-cmp',
  --   dependencies = {
  --     -- 'hrsh7th/nvim-cmp',
  --   },
  --   config = function()
  --     require('copilot_cmp').setup {
  --       formatters = {
  --         label = require('copilot_cmp.format').format_label_text,
  --         insert_text = require('copilot_cmp.format').format_insert_text,
  --         preview = require('copilot_cmp.format').deindent,
  --       },
  --     }

  --     -- Set up separate keymapping for copilot-cmp
  --     local cmp = require 'cmp'
  --     cmp.setup {
  --       mapping = cmp.mapping.preset.insert {
  --         -- Your specific Copilot CMP mapping at C-g
  --         ['<C-g>'] = cmp.mapping(function()
  --           if cmp.visible() and cmp.get_active_entry() then
  --             cmp.confirm { select = true }
  --           else
  --             cmp.complete {
  --               config = {
  --                 sources = {
  --                   { name = 'copilot' },
  --                 },
  --               },
  --             }
  --           end
  --         end),
  --       },
  --     }

  --     -- Create a separate source group for Copilot
  --     local copilot_source_group = {
  --       name = 'copilot',
  --       group_index = 1,
  --       priority = 100,
  --     }

  --     -- Register the source group
  --     cmp.setup.filetype({ '*' }, {
  --       sources = {
  --         copilot_source_group,
  --       },
  --     })
  --   end,
  -- },
}
