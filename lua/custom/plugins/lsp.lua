return { {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { "j-hui/fidget.nvim", opts = {} },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lc = require("lspconfig")

    lc.lua_ls.setup {}

    vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
    vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'grr', vim.lsp.buf.references)
    vim.keymap.set('n', 'grf', vim.lsp.buf.format)

    -- format on save
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end

        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end
          })
        end
      end
    })
  end,
} }
