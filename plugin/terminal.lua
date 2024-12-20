local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local open_terminal = function(pos, size)
  return function()
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

local open_floating_terminal = function(opts)
  opts = opts or {}

  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  vim.cmd("startinsert")

  return { buf = buf, win = win }
end

local toggle_floating_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = open_floating_terminal { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<leader>tt", vim.cmd.term, { silent = true })
vim.keymap.set("n", "<leader>tj", open_terminal("J", { height = 12 }), { silent = true })
vim.keymap.set("n", "<leader>tk", open_terminal("K", { height = 12 }), { silent = true })
vim.keymap.set("n", "<leader>tl", open_terminal("L", { width = 50 }), { silent = true })
vim.keymap.set("n", "<leader>th", open_terminal("H", { width = 50 }), { silent = true })

vim.api.nvim_create_user_command('Floaterminal', toggle_floating_terminal, {})
vim.keymap.set({ "n", "t" }, "<leader>tf", toggle_floating_terminal)

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
    vim.cmd("startinsert")
  end,
})
