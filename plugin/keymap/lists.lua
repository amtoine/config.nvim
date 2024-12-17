local nmap = require("custom._utils").nmap

-- quickfix
nmap("<leader>co", "<cmd>copen<CR>")
nmap("<leader>cc", "<cmd>cclose<CR>")
nmap("<leader>cj", "<cmd>copen<CR><cmd>cnext<CR>zz")
nmap("<leader>ck", "<cmd>copen<CR><cmd>cprev<CR>zz")

-- loc list
nmap("<leader>lo", "<cmd>lopen<CR>")
nmap("<leader>lc", "<cmd>lclose<CR>")
nmap("<leader>lj", "<cmd>lopen<CR><cmd>lnext<CR>zz")
nmap("<leader>lk", "<cmd>lopen<CR><cmd>lprev<CR>zz")
