-- see https://github.com/nushell/integrations/blob/main/nvim/init.lua
-- for complementary information and comments for these options
vim.opt.shell = "nu"
vim.opt.shelltemp = false
vim.opt.shellredir = "out+err> %s"
vim.opt.shellcmdflag = "--stdin --no-newline -c"
vim.opt.shellxescape = ""
vim.opt.shellxquote = ""
vim.opt.shellquote = ""
vim.opt.shellpipe = '' ..
    '| complete' ..
    '| update stderr { ansi strip }' ..
    '| tee { get stderr | save --force --raw %s }' ..
    '| into record'

vim.filetype.add {
  extension = {
    nuon = "nu",
  }
}
