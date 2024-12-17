local nmap = require("custom._utils").nmap

nmap('[d', vim.diagnostic.goto_prev)
nmap(']d', vim.diagnostic.goto_next)

nmap('<leader>le', vim.diagnostic.open_float)
nmap('<leader>lq', vim.diagnostic.setloclist)

nmap("<leader>lf", vim.lsp.buf.format)

nmap('<leader>li', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
