vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = "v1.6.0",
  },
})

require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = { use_nvim_cmp_as_default = true },
  signature = { enabled = true },
})
