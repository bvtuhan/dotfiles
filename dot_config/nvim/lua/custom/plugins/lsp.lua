return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'saghen/blink.cmp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        -- lsp keybindings based on doom emacs
        local tb = require 'telescope.builtin'

        map('<leader>ca', vim.lsp.buf.code_action, 'LSP Code Action', { 'n', 'x' })
        map('<leader>cr', vim.lsp.buf.rename, 'LSP Rename')

        map('<leader>cf', function()
          vim.lsp.buf.format { async = true }
        end, 'LSP Format')

        map('<leader>cd', tb.lsp_definitions, 'LSP Definition')
        map('gd', tb.lsp_definitions, 'LSP Definition')
        map('<leader>cD', vim.lsp.buf.declaration, 'LSP Declaration')
        map('<leader>ci', tb.lsp_implementations, 'LSP Implementation')
        map('<leader>ct', tb.lsp_type_definitions, 'LSP Type Definition')
        map('<leader>cR', tb.lsp_references, 'LSP References')

        map('<leader>cs', tb.lsp_document_symbols, 'Document Symbols')
        map('<leader>cS', tb.lsp_dynamic_workspace_symbols, 'Workspace Symbols')

        map('<leader>ck', vim.lsp.buf.hover, 'LSP Documentation')
        map('<leader>cK', vim.lsp.buf.signature_help, 'Signature Help')

        map('<leader>cx', tb.diagnostics, 'List Diagnostics')
        map('<leader>cj', vim.diagnostic.goto_next, 'Next Diagnostic')
        map('<leader>cJ', vim.diagnostic.goto_prev, 'Prev Diagnostic')

        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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
              vim.api.nvim_clear_autocmds {
                group = 'kickstart-lsp-highlight',
                buffer = event2.buf,
              }
            end,
          })
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end
      end,
    })

    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          return diagnostic.message
        end,
      },
    }

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
    local servers = {
      clangd = {},
      pyright = {},
      rust_analyzer = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, { 'stylua' })

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }

    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
