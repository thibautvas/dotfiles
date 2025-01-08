return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
  },

  config = function()
    require("telescope").setup {
      extensions = {
        fzf = {}
      },
    }
    require("telescope").load_extension("fzf")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope find files in buffers" })
    vim.keymap.set("n", "<leader>fr", builtin.git_files, { desc = "Telescope find files in git repo" })
    vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Telescope find files in $(git status)" })
    vim.keymap.set("n", "<leader>fa", function()
      builtin.find_files { cwd = vim.fn.getenv("RD") }
    end,
    { desc = "Telescope find files in root directory" })

    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>fw", function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string { search = word }
    end,
    { desc = "Telescope live grep at cursor" })
    vim.keymap.set("n", "<leader>fW", function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string { search = word }
    end,
    { desc = "Telescope live grep at cursor" })
  end
}
