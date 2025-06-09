vim.pack.add({ "https://github.com/catppuccin/nvim" })

require("catppuccin").setup({
  flavour = "mocha",
  term_colors = true,
  transparent_background = true,
})

vim.cmd.colorscheme("catppuccin")
