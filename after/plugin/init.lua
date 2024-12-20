-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

vim.cmd.colorscheme("rose-pine")

-- Highlight trailing whitespaces
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  pattern = "*",
  callback = function()
    local extra_whitespaces = ""

    if require("custom._utils").is_in(vim.bo.filetype, {
          "", "aerial", "help", "presenting_markdown", "neo-tree", "git"
        }) then
      extra_whitespaces = "//"
    else
      extra_whitespaces = "/\\s\\+$\\|\\t/"
    end

    local color = "darkred"

    vim.cmd {
      cmd = "highlight",
      args = {
        "ExtraWhitespace",
        string.format("ctermbg=%s", color),
        string.format("guibg=%s", color)
      },
      bang = false,
    }

    vim.cmd {
      cmd = "match",
      args = { "ExtraWhitespace", extra_whitespaces },
      bang = false,
    }
  end
})

vim.cmd([[
    command! Browser :!qutebrowser --target window
]])

vim.cmd([[
    autocmd BufNewFile,BufRead .envrc :set filetype=bash
]])
