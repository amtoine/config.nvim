return {
  {
    "theprimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      local nmap = require("custom._utils").nmap
      nmap("<leader>ha", mark.add_file, "[h]arpoon: [a]dd a file to the menu")
      nmap("<leader>he", ui.toggle_quick_menu, "[h]arpoon: toggle menu [e]ntries")
      nmap("<leader>hh", function() ui.nav_file(1) end, "[h]arpoon: go to first item (left [h])")
      nmap("<leader>hj", function() ui.nav_file(2) end, "[h]arpoon: go to second item (down [j])")
      nmap("<leader>hk", function() ui.nav_file(3) end, "[h]arpoon: go to third item (up [k])")
      nmap("<leader>hl", function() ui.nav_file(4) end, "[h]arpoon: go to fourth item (right [l])")
    end
  },
}
