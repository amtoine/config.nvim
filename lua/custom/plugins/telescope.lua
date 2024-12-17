return { {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.setup {
      defaults = {
        mappings = {
          n = {
            ['L'] = actions.select_vertical,
            ['H'] = actions.select_vertical,
            ['J'] = actions.select_horizontal,
            ['K'] = actions.select_horizontal,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "ivy"
        }
      },
    }

    vim.keymap.set("n", "<leader>fd", builtin.find_files)
    vim.keymap.set("n", "<leader>fh", builtin.help_tags)
    vim.keymap.set("n", "<leader>fg", builtin.live_grep)
  end
} }
