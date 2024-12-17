return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")

    oil.setup {
      columns = { "icon", },
      keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
      },
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set("n", "-", oil.open)
    vim.keymap.set("n", "<leader>-", oil.toggle_float)
  end,
}
