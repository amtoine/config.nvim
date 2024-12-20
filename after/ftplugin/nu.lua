local format = function()
  if vim.bo.filetype ~= "nu" then
    print "not a Nushell buffer"
  else
    print "formatting"
    pcall(function() vim.cmd([[:%s/\([a-zA-Z"\])}0-9]\)\s*|\s*/\1\r    | /g]]) end)

    pcall(function() vim.cmd([[%s/^\s*|/    |/]]) end)
  end
end

vim.keymap.set("n", "<leader>lf", format)
