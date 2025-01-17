return {
  -- LSPConfig
  {

    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'j-hui/fidget.nvim',
      'p00f/clangd_extensions.nvim',
      (('blink' == vim.g.completion_plugin) and 'saghen/blink.cmp' or 'hrsh7th/cmp-nvim-lsp'),
    },

    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')

          map('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')

          map('gI', require('telescope.builtin').lsp_implementations, '[g]oto [i]mplementation')
          map('<localleader>lm', require('telescope.builtin').lsp_implementations, '[g]oto [i]mplementation')

          map('<localleader>ld', require('telescope.builtin').lsp_definitions, '[d]efinition')
          map('<F12>', function()
            if 120 >= vim.o.columns then
              vim.cmd.split()
            else
              vim.cmd.vsplit()
            end
            require('telescope.builtin').lsp_definitions()
          end, '[d]efinition')

          map('<localleader>ls', require('telescope.builtin').lsp_document_symbols, 'document [s]ymbols')

          map('<localleader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace symbols')

          map('<F2>', vim.lsp.buf.rename, 'LSP Rename')
          map('<localleader>lr', vim.lsp.buf.rename, '[r]ename')

          map('<F4>', vim.lsp.buf.code_action, 'Code Actions', { 'n', 'x' })
          map('<localleader>lc', vim.lsp.buf.code_action, '[c]ode actions', { 'n', 'x' })

          map('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
          map('<localleader>lD', vim.lsp.buf.declaration, '[D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<localleader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[t]oggle Inlay [h]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      if 'blink' == vim.g.completion_plugin then
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
      else
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      end

      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local configured, server = pcall(require, 'f12.servers.' .. server_name)
            if not configured or nil == server then
              server = {}
            end
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            if 'clangd' == server_name then
              server.cmd = {
                'clangd',
              }
              local cwd = vim.fn.getcwd()
              local ioc = vim.fn.glob(cwd .. '/*.ioc')
              if '' ~= ioc and nil ~= ioc then
                local gcc_path = vim.fn.exepath('arm-none-eabi-gcc'):gsub('\\', '/')
                server.cmd = vim.list_extend(server.cmd, {
                  vim.fn.executable 'arm-none-eabi-gcc' and '--query-driver=' .. gcc_path,
                })
              else
                local gcc_path = vim.fn.exepath('gcc'):gsub('\\', '/')
                server.cmd = vim.list_extend(server.cmd, {
                  -- '--query-driver=/ucrt64/bin/gcc',
                  vim.fn.executable 'gcc' and '--query-driver=' .. gcc_path,
                })
              end

              server.cmd = vim.list_extend(server.cmd, {
                '--background-index',
                -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
                -- to add more checks, create .clang-tidy file in the root directory
                -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
                '--clang-tidy',
                '--completion-style=detailed',
                '--function-arg-placeholders',
                '--header-insertion=iwyu',
                '--fallback-style=llvm',
              })
            end

            require('lspconfig')[server_name].setup(server)

            if 'clangd' == server_name then
              require('clangd_extensions.inlay_hints').setup_autocmd()
              require('clangd_extensions.inlay_hints').set_inlay_hints()
            end
          end,
        },
      }
    end,
  },

  -- LSP Signature
  {
    'ray-x/lsp_signature.nvim',
    event = 'InsertEnter',
    opts = {
      bind = true,
      wrap = true,
      handler_opts = {
        border = 'double',
      },
    },
    config = function(_, opts)
      require('lsp_signature').setup(opts)

      vim.keymap.set({ 'i' }, '<C-d>', function()
        require('lsp_signature').toggle_float_win()
      end)
    end,
  },

  -- LSPKinds
  {
    'onsails/lspkind.nvim',

    opts = {
      mode = 'text_symbol',
      preset = 'default',
      symbol_map = {
        Text = '󰉿',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '',
        Field = '󰜢',
        Variable = '󰀫',
        Class = '󰠱',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '󰑭',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '󰈇',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '󰙅',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '',
      },
    },
  },

  -- LSPLinks
  {
    'icholy/lsplinks.nvim',
    opts = {},
    config = function(_, opts)
      local lsplinks = require 'lsplinks'
      lsplinks.setup(opts)
      vim.keymap.set('n', 'gx', lsplinks.gx)
    end,
  },

  -- LSPSaga
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
    opts = {
      symbol_in_winbar = {
        enable = true,
      },
      code_action = {
        num_shortcut = true,
        show_server_name = true,
      },
    },
  },

  -- Mason
  {
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
  },

  -- luvit
  { 'Bilal2453/luvit-meta', lazy = true },

  -- Rust
  { {
    'saecki/crates.nvim',
    tag = 'stable',
    config = function()
      require('crates').setup {}
    end,
  } },
}
