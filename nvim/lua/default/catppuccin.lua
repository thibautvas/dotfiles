vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin.nvim",
  },
})

require("catppuccin").setup({
  flavour = "mocha",
  term_colors = true,
  transparent_background = true,
})

vim.cmd.colorscheme("catppuccin")
