local nmap = require("custom._utils").nmap

-- Maximize, close and equalize
nmap("<leader>wm", "<C-w>_<C-w>|")
nmap("<leader>wc", "<C-w>o")
nmap("<leader>we", "<C-w>=")

-- Focus
nmap("<leader>wh", "<C-w>h")
nmap("<leader>wj", "<C-w>j")
nmap("<leader>wk", "<C-w>k")
nmap("<leader>wl", "<C-w>l")

-- Move around
nmap("<leader>wH", "<C-w>H")
nmap("<leader>wJ", "<C-w>J")
nmap("<leader>wK", "<C-w>K")
nmap("<leader>wL", "<C-w>L")

-- Control the size
nmap("<leader>ww", "<c-w>5>")
nmap("<leader>wn", "<c-w>5<")
nmap("<leader>wt", "<C-W>+")
nmap("<leader>ws", "<C-W>-")
