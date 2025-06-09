vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
  view_options = { show_hidden = true },
  skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Oil in parent directory" })
