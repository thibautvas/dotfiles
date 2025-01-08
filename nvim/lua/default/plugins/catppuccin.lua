return
{
  "catppuccin/nvim",
  name = "catppuccin.nvim",
  priority = 1000,
  opts = {
    flavour = "mocha",
    term_colors = true,
    transparent_background = true,
  },

  config = function(_, opts)
    require("catppuccin").setup(opts)
    require("catppuccin").load()
  end
}
