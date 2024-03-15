return { {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    { 'j-hui/fidget.nvim',       opts = {} },
    'folke/neodev.nvim',
  },
  config = function()
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>lrn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>lca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('<leader>lgd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      nmap('<leader>lgr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('<leader>lgI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      nmap('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      nmap('<leader>lds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>lws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('<leader>lh', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<leader>ls', vim.lsp.buf.signature_help, 'Signature Documentation')

      nmap('<leader>lgD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>lwf', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace list [F]olders')

      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require('mason').setup()
    require('mason-lspconfig').setup()

    local lspconfig = require('lspconfig')
    lspconfig.nushell.setup {}

    vim.filetype.add({
      extension = {
        nuon = "nu",
      }
    })

    local servers = {
      clangd = {},
      rust_analyzer = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          hint = { enable = true },
          -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    }

    -- Setup neovim lua configuration
    require('neodev').setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local mason_lspconfig = require 'mason-lspconfig'
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }
    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end,
    }
  end
} }