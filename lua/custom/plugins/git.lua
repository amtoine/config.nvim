return {
  {
    "tpope/vim-fugitive",
    dependencies = { 'tpope/vim-rhubarb' },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        map('n', '<leader>gp', function () gs.nav_hunk("prev") end)
        map('n', '<leader>gn', function () gs.nav_hunk("next") end)
        map('n', '<leader>gs', gs.stage_hunk)
        map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end)
        map('n', '<leader>gr', gs.reset_hunk)
        map('n', '<leader>gu', gs.undo_stage_hunk)
        map('n', '<leader>gS', gs.stage_buffer)
        map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end)
        map('n', '<leader>gR', gs.reset_buffer)
        map('n', '<leader>gP', gs.preview_hunk)
        map('n', '<leader>gb', function() gs.blame_line { full = false } end)
        map('n', '<leader>gd', gs.diffthis)
        map('n', '<leader>gD', function() gs.diffthis '~' end)
        map('n', '<leader>gtb', gs.toggle_current_line_blame)
        map('n', '<leader>gtd', gs.toggle_deleted)

        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
       { "<leader>glg", "<cmd>LazyGit<cr>" }
    }
  }
}
