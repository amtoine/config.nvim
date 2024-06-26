local M = {}

function M.nmap(keys, func, desc, bufnr)
  vim.keymap.set('n', keys, func, { buffer = bufnr, silent = true, noremap = true, desc = desc })
end


-- return true if the `value` is inside the `list`, false otherwise
function M.is_in(value, list)
    for _, item in ipairs(list) do
        if value == item then
            return true
        end
    end
    return false
end

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
function M.find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')
  [1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

return M
