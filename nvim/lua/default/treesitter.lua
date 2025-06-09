vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "bash", "lua", "nix", "python", "sql" },
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    },
  },
})
