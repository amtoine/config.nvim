return {
  {
    "nvim-telescope/telescope-bibtex.nvim",
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    ft = "tex",
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("bibtex")

      vim.keymap.set("n", "<leader>bbt", telescope.extensions.bibtex.bibtex, { silent = true, })
    end,
  },

  { "lervag/vimtex" },
}
