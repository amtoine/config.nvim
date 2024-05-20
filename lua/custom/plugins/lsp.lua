return {
  {
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

        nmap('<leader>lr', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>lc', vim.lsp.buf.code_action, '[C]ode [A]ction')

        local telescope = require('telescope.builtin')
        nmap('<leader>lgd', telescope.lsp_definitions, '[G]oto [D]efinition')
        nmap('<leader>lgr', telescope.lsp_references, '[G]oto [R]eferences')
        nmap('<leader>lgI', telescope.lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>lD', telescope.lsp_type_definitions, 'Type [D]efinition')
        nmap('<leader>lds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>lws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('<leader>lh', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<leader>ls', vim.lsp.buf.signature_help, 'Signature Documentation')

        nmap('<leader>lgD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>lwf', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace list [F]olders')

        vim.api.nvim_buf_create_user_command(
          bufnr, 'Format', vim.lsp.buf.format, { desc = 'Format current buffer with LSP' }
        )
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
        pylsp = {},
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
  },

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      local trouble = require("trouble")

      require("trouble").setup {
        icons = true,
      }

      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { silent = true, noremap = true, desc = desc })
      end

      local toggle = function(mode --[[string]])
        return function() trouble.toggle(mode) end
      end

      require('which-key').register {
        ['<leader>lt'] = { name = '[L]SP [T]rouble', _ = 'which_key_ignore' },
      }

      nmap("<leader>lto", toggle(nil), "Open diagnostics")
      nmap("<leader>ltw", toggle("workspace_diagnostics"), "Open workspace diagnostics")
      nmap("<leader>ltd", toggle("document_diagnostics"), "Open document diagnostics")
      nmap("<leader>ltl", toggle("loclist"), "Open loclist")
      nmap("<leader>ltq", toggle("quickfix"), "Open quickfix list")
      nmap("<leader>ltr", toggle("lsp_references"), "Open references")
    end
  },

  {
    'rmagatti/goto-preview',
    config = function()
      local goto_preview = require('goto-preview')
      goto_preview.setup {}

      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { silent = true, desc = desc })
      end

      require('which-key').register {
        ['<leader>lg'] = { name = '[L]SP [G]oto', _ = 'which_key_ignore' },
      }

      nmap("<leader>lgd", goto_preview.goto_preview_definition, "Goto definition")
      nmap("<leader>lgt", goto_preview.goto_preview_type_definition, "Goto type")
      nmap("<leader>lgi", goto_preview.goto_preview_implementation, "Goto implementation")
      nmap("<leader>lgc", goto_preview.close_all_win, "Close all windows")
      nmap("<leader>lgr", goto_preview.goto_preview_references, "Goto references")
    end
  },
}
