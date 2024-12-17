vim.keymap.set("n", "<Esc>", ":nohlsearch<CR><Esc>", { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("i", "<C-c>", "<Esc>", { silent = true })

vim.keymap.set(
    "n", "<leader>xs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "replace all occurences of the work under the cursor" }
)
vim.keymap.set(
    "n", "<leader>xx", "<cmd>!chmod +x %<CR>",
    { silent = true, desc = "make the current buffer executable" }
)
