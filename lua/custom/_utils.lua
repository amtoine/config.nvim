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

return M
