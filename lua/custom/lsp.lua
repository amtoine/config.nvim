local nmap = require("custom._utils").nmap

nmap('[d', vim.diagnostic.goto_prev)
nmap(']d', vim.diagnostic.goto_next)

nmap('<leader>le', vim.diagnostic.open_float)
nmap('<leader>lq', vim.diagnostic.setloclist)

nmap("<leader>lf", vim.lsp.buf.format)

nmap('<leader>li', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)

local on_attach = function(_, bufnr)
  nmap('<leader>lr', vim.lsp.buf.rename, bufnr)
  nmap('<leader>lc', vim.lsp.buf.code_action, bufnr)

  local telescope = require('telescope.builtin')
  nmap('<leader>lgd', telescope.lsp_definitions, bufnr)
  nmap('<leader>lgr', telescope.lsp_references, bufnr)
  nmap('<leader>lgI', telescope.lsp_implementations, bufnr)
  nmap('<leader>lD', telescope.lsp_type_definitions, bufnr)
  nmap('<leader>lds', telescope.lsp_document_symbols, bufnr)
  nmap('<leader>lws', telescope.lsp_dynamic_workspace_symbols, bufnr)

  -- See `:help K` for why this keymap
  nmap('<leader>lh', vim.lsp.buf.hover, bufnr)
  nmap('<leader>ls', vim.lsp.buf.signature_help, bufnr)

  nmap('<leader>lgD', vim.lsp.buf.declaration, bufnr)
  nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, bufnr)
  nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, bufnr)
  nmap('<leader>lwf', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufnr)

  vim.api.nvim_buf_create_user_command(
    bufnr, 'Format', vim.lsp.buf.format, {}
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

--------------------------------------------------------------------------------
local trouble = require("trouble")

trouble.setup {
  icons = true,
}

local toggle = function(mode --[[string]])
  return function() trouble.toggle(mode) end
end
nmap("<leader>lto", toggle(nil), "Open diagnostics")
nmap("<leader>ltw", toggle("workspace_diagnostics"), "Open workspace diagnostics")
nmap("<leader>ltd", toggle("document_diagnostics"), "Open document diagnostics")
nmap("<leader>ltl", toggle("loclist"), "Open loclist")
nmap("<leader>ltq", toggle("quickfix"), "Open quickfix list")
nmap("<leader>ltr", toggle("lsp_references"), "Open references")

local jump = function(fn)
  return function() fn({skip_groups = true, jump = true}) end
end
nmap("<leader>ltj", jump(trouble.next), "Jump to next item")
nmap("<leader>ltk", jump(trouble.previous), "Jump to previous item")
nmap("<leader>ltg", jump(trouble.first), "Jump to first item")
nmap("<leader>ltG", jump(trouble.last), "Jump to last item")

--------------------------------------------------------------------------------
local goto_preview = require('goto-preview')
goto_preview.setup {}

nmap("<leader>lgd", goto_preview.goto_preview_definition, "Goto definition")
nmap("<leader>lgt", goto_preview.goto_preview_type_definition, "Goto type")
nmap("<leader>lgi", goto_preview.goto_preview_implementation, "Goto implementation")
nmap("<leader>lgc", goto_preview.close_all_win, "Close all windows")
nmap("<leader>lgr", goto_preview.goto_preview_references, "Goto references")
