require('which-key').add {
  { "<leader>t", group = "[T]erminal" },
  { "<leader>t_", hidden = true },
}

-- Easily hit escape in terminal mode.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- Open terminals
local open_terminal = function (pos, size)
  return function ()
    vim.cmd.new()
    vim.cmd.wincmd(pos)
    if size.height then
      vim.api.nvim_win_set_height(0, size.height)
      vim.wo.winfixheight = true
    end
    if size.width then
      vim.api.nvim_win_set_width(0, size.width)
      vim.wo.winfixwidth = true
    end
    vim.cmd.term()
  end
end
vim.keymap.set("n", "<leader>tt", vim.cmd.term, { silent = true })
vim.keymap.set("n", "<leader>tj", open_terminal("J", { height = 12 }), { silent = true })
vim.keymap.set("n", "<leader>tk", open_terminal("K", { height = 12 }), { silent = true })
vim.keymap.set("n", "<leader>tl", open_terminal("L", { width = 50 }), { silent = true })
vim.keymap.set("n", "<leader>th", open_terminal("H", { width = 50 }), { silent = true })

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})
