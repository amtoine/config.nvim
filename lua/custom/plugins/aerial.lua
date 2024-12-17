return {
  {
    'stevearc/aerial.nvim',
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      local aerial = require("aerial")
      aerial.setup({
        on_attach = function(bufnr)
          vim.keymap.set('n', '<leader>ap', aerial.prev, { buffer = bufnr })
          vim.keymap.set('n', '<leader>an', aerial.next, { buffer = bufnr })
        end
      })
      vim.keymap.set('n', '<leader>at', aerial.toggle, { silent = true })
    end
  },
}
