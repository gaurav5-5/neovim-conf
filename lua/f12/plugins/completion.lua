if 'blink' == vim.g.completion_plugin then
  return {
    'saghen/blink.cmp',
    version = '*',

    dependencies = {
      'L3M0N4D3/LuaSnip',
      'folke/lazydev.nvim',
      'abecodes/tabout.nvim',
      'onsails/lspkind.nvim',
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ['<C-n>'] = {
          function(cmp)
            if luasnip.choice_active() then
              luasnip.change_choice(1)
            end
          end,
          'fallback',
        },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },

      snippets = { preset = 'luasnip' },

      completion = {
        accept = {
          create_undo_point = true,
          auto_brackets = {
            enabled = true,
            kind_resolution = {
              enabled = true,
            },
            semantic_token_resolution = {
              enabled = true,
            },
          },
        },
        keyword = {
          range = 'full',
        },
        trigger = {
          prefetch_on_insert = true,
          show_in_snippet = false,
          show_on_keyword = false,
          show_on_trigger_character = false,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        ghost_text = {
          enabled = true,
        },
        menu = {
          border = 'single',
          winblend = 10,
          auto_show = false,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 450,
          window = {
            border = 'single',
          },
        },
      },

      signature = {
        enabled = true,
        window = {
          border = 'single',
        },
      },

      sources = {
        default = {
          'snippets',
          'lsp',
          'buffer',
          'path',
        },

        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    },
  }
else
  return {
    'hrsh7th/nvim-cmp',
    -- 'iguanacucumber/magazine.nvim',
    -- name = 'nvim-cmp',

    event = { 'InsertEnter', 'InsertCharPre' },

    dependencies = {
      -- Snippet Engine
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- symbols
      'onsails/lspkind.nvim',

      -- tabout
      'abecodes/tabout.nvim',

      -- neogen
      -- 'danymat/neogen',

      -- Sources
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      {
        'FelipeLema/cmp-async-path',
        url = 'https://codeberg.org/FelipeLema/cmp-async-path',
      },
    },

    opts = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      -- local neogen = require 'neogen'

      local plain_text_comp = {
        window = {
          documentation = cmp.config.disable,
        },
        sources = {
          { name = 'buffer' },
          -- { name = 'path' },
          { name = 'async_path' },
        },
      }

      local normal_comp = {

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        completion = {
          autocomplete = false,
          completeopt = 'menu,menuone,noinsert',
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        preselect = cmp.PreselectMode.None,

        confirmation = {
          get_commit_characters = function(commit_characters)
            return commit_characters
          end,
        },

        view = {
          docs = {
            auto_open = true,
          },
        },

        experimental = {
          ghost_text = true,
        },

        formatting = {
          expandable_indicator = true,
          fields = { 'kind', 'abbr', 'menu' },
        },

        matching = {
          disallow_fuzzy_matching = false,
          disallow_fullfuzzy_matching = false,
          disallow_partial_fuzzy_matching = true,
          disallow_partial_matching = false,
          disallow_prefix_unmatching = false,
          disallow_symbol_nonprefix_matching = true,
        },

        mapping = {
          ['<C-n>'] = cmp.mapping(function(_)
            if luasnip.choice_active() then
              luasnip.change_choice(1)
            elseif cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end, { 'i', 's' }),

          ['<C-p>'] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
              luasnip.change_choice(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<C-N>'] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
              luasnip.change_choice(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-d>'] = function(fallback)
            if cmp.visible_docs() then
              cmp.close_docs()
            elseif not cmp.visible_docs() then
              cmp.open_docs()
            end
          end,
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          ['<C-y>'] = cmp.mapping.confirm { select = true },

          ['<CR>'] = cmp.mapping(function(fallback)
            if luasnip.expandable() then
              luasnip.expand()
            elseif cmp.visible() then
              cmp.confirm { select = false }
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<C-Space>'] = cmp.mapping(function(fallback)
            if not cmp.visible() then
              cmp.complete()
            elseif not cmp.visible_docs() then
              cmp.open_docs()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable() then
              luasnip.jump(1)
              -- elseif neogen.jumpable() then
              -- neogen.jump_next()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            -- elseif neogen.jumpable() then
            --   neogen.jump_next()
            else
              fallback()
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'calc' },
          -- { name = 'path' },
          { name = 'async_path' },
          { name = 'buffer' },
        },
        sorting = {
          comparators = {
            cmp.config.compare.kind,
            cmp.config.compare.scopes,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require 'clangd_extensions.cmp_scores',
            cmp.config.compare.locality,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      }

      plain_text_comp.mapping = normal_comp.mapping

      return {
        all = normal_comp,
        cmake = normal_comp,
        markdown = plain_text_comp,
        txt = plain_text_comp,
        help = plain_text_comp,
        rst = plain_text_comp,
      }
    end,

    config = function(_, opts)
      local cmp = require 'cmp'

      -- vim.cmd [[inoremap <C-x><C-o> <Cmd>lua require('cmp').complete()<CR>]]
      -- vim.cmd [[inoremap <C-x><C-n> <Cmd>lua require('cmp').complete()<CR>]]
      vim.cmd [[inoremap <C-n> <Cmd>lua require('cmp').complete()<CR>]]

      cmp.setup(opts.all)

      for k, v in pairs(opts) do
        if k ~= 'all' then
          cmp.setup.filetype({ k }, v)
        end
      end

      -- cmp.setup.filetype({ 'markdown', 'help', 'rst', 'txt' }, opts.txt)

      require('cmp').setup.cmdline('/', {
        sources = cmp.config.sources({
          { name = 'nvim_lsp_document_symbol' },
        }, {
          { name = 'buffer' },
        }),
      })
    end,
  }
end
