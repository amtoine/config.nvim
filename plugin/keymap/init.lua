vim.keymap.set("n", "<Esc>", ":nohlsearch<CR><Esc>", { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("i", "<C-c>", "<Esc>", { silent = true })

vim.keymap.set(
    "n", "<leader>zr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "replace all occurences of the word under the cursor" }
)
vim.keymap.set("n", "<leader>zx", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>x", ":.lua<CR>", { silent = true })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { silent = true })
