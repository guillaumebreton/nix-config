vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

-- move the screen one page downward and center the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- move the screen one page backward and center the cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- unknow
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
