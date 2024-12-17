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
        },
        git_files = {
          theme = "ivy"
        }
      },
    }

    vim.keymap.set("n", "<leader>fd", function()
      local opts = { prompt_title = "Find project files..." }

      vim.fn.system("git rev-parse --is-inside-work-tree")

      if vim.v.shell_error == 0 then
        builtin.git_files(opts)
      else
        builtin.find_files(opts)
      end
    end
    )
    vim.keymap.set("n", "<leader>fh", builtin.help_tags)
    vim.keymap.set("n", "<leader>fg", builtin.live_grep)
    vim.keymap.set("n", "<leader>fp", function()
      local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
      builtin.find_files {
        prompt_title = "Explore LazyVim plugin files from " .. lazypath .. "...",
        results_title = false,
        preview_title = false,
        cwd = lazypath,
      }
    end)
    vim.keymap.set("n", "<leader>fm", require("telescope.multigrep").multigrep)
  end
} }
