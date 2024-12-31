vim.cmd [[
  aunmenu PopUp

  amenu PopUp.Inspect            <cmd>Inspect<CR>
  amenu PopUp.-1-                <NOP>
  amenu PopUp.Definition         <cmd>lua vim.lsp.buf.definition()<CR>
  amenu PopUp.References         <cmd>lua vim.lsp.buf.references()<CR>
  amenu PopUp.-2-                <NOP>
  nmenu PopUp.Back               <c-t>
  amenu PopUp.URL                gx
]]

local popup_menu_group = vim.api.nvim_create_augroup("nvim_popupmenu", { clear = true })

local disable = function(x) vim.cmd("amenu disable " .. x) end
local enable = function(x) vim.cmd("amenu enable " .. x) end

vim.api.nvim_create_autocmd("MenuPopup", {
  pattern = "*",
  group = popup_menu_group,
  desc = "LOL: Custom Menu PopUp",
  callback = function()
    disable("PopUp.Definition")
    disable("PopUp.References")
    disable("PopUp.URL")

    if vim.lsp.get_clients { bufnr = 0 }[1] then
      enable("PopUp.Definition")
      enable("PopUp.References")
    end

    local urls = require("vim.ui")._get_urls()
    if vim.startswith(urls[1], "http") then
      enable("PopUp.URL")
    end
  end
})
