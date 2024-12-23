-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "paste from system clipboard" })

-- navigate
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "half page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "half page up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "next result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "previous result and center" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move down visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move up visual selection" })
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "move down in quickfix list" })
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>", { desc = "move up in quickfix list" })

-- search
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "clear higlight" })
