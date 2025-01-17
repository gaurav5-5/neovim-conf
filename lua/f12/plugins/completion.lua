return {
  -- 'hrsh7th/nvim-cmp',
  'iguanacucumber/magazine.nvim',
  name = 'nvim-cmp',

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
    'danymat/neogen',

    -- Sources
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    -- 'hrsh7th/cmp-path',
    'hrsh7th/cmp-calc',

    { 'iguanacucumber/mag-nvim-lsp', name = 'cmp-nvim-lsp', opts = {} },
    { 'iguanacucumber/mag-nvim-lua', name = 'cmp-nvim-lua' },
    { 'iguanacucumber/mag-buffer', name = 'cmp-buffer' },
    { 'iguanacucumber/mag-cmdline', name = 'cmp-cmdline' },
    -- 'hrsh7th/cmp-nvim-lsp',
    -- 'hrsh7th/cmp-buffer',
    -- 'hrsh7th/cmp-cmdline',
    {
      'FelipeLema/cmp-async-path',
      url = 'https://codeberg.org/FelipeLema/cmp-async-path',
    },
    'lukas-reineke/cmp-rg',
  },

  opts = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local neogen = require 'neogen'

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
      enabled = function()
        local disabled = false
        disabled = disabled or (vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt')
        disabled = disabled or (vim.fn.reg_recording() ~= '')
        disabled = disabled or (vim.fn.reg_executing() ~= '')
        return not disabled
      end,

      performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 500,
        filtering_context_budget = 3,
        confirm_resolve_timeout = 80,
        async_budget = 1,
        max_view_entries = 200,
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      completion = {
        -- autocomplete = {
        --   require('cmp.types').cmp.TriggerEvent.TextChanged,
        -- },
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
        entries = {
          name = 'custom',
          follow_cursor = true,
        },
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
          elseif neogen.jumpable() then
            neogen.jump_next()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          elseif neogen.jumpable() then
            neogen.jump_next()
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },
      sources = {
        { name = 'calc' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        {
          name = 'lazydev',
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = 'nvim_lsp' },
      },
      {
        -- { name = 'path' },
        { name = 'async_path' },
        { name = 'rg' },
        { name = 'buffer' },
      },
      sorting = {
        priority_weight = 2,
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
        { name = 'async_path' },
      }, {
        { name = 'buffer' },
      }),
    })
  end,
}
