return {
  {
    "theprimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      local nmap = require("custom._utils").nmap

      nmap("<leader>ha", mark.add_file)
      nmap("<leader>he", ui.toggle_quick_menu)
      nmap("<leader>hh", function() ui.nav_file(1) end)
      nmap("<leader>hj", function() ui.nav_file(2) end)
      nmap("<leader>hk", function() ui.nav_file(3) end)
      nmap("<leader>hl", function() ui.nav_file(4) end)
    end
  },
}
