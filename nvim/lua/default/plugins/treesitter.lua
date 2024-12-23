return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "bash", "lua", "python", "sql", "vim", "vimdoc" },
        auto_install = false,
        highlight = { enable = true, additional_vim_regex_highlighting = { "markdown" } },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
            }
          }
        }
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",

    init = function()
    end
  }
}
