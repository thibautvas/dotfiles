vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.guicursor = ""
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 0
vim.opt.scrolloff = 10
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth = 4
  end,
})
vim.opt.inccommand = "split"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "half page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "half page up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "next result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "previous result and center" })
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "clear highlights" })
vim.keymap.set("v", "<leader>y", [["+y]], { desc = "yank to system clipboard" })
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "escape out of terminal mode" })

require("blink.cmp").setup({
  fuzzy = {
    prebuilt_binaries = { force_version = "v1.8.0" },
  },
  keymap = { preset = "default" },
  appearance = { use_nvim_cmp_as_default = true },
  signature = { enabled = true },
})

vim.lsp.config.ty = {
  cmd = { "ty", "server" },
  filetypes = { "python" },
}

vim.lsp.config.ruff = {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
}

local nls = require("null-ls")
nls.setup({
  sources = {
    nls.builtins.formatting.sqlfluff,
    nls.builtins.diagnostics.sqlfluff,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  pattern = { "*.py", "*.sql" },
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end
    if not client.server_capabilities.documentFormattingProvider then return end

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
      end,
    })
  end,
})

vim.lsp.enable({ "ty", "ruff" })
vim.diagnostic.config({ virtual_text = true })

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

local fl = require("fzf-lua")
fl.setup({
  winopts = {
    scrollbar = { hidden = true },
  },
  buffers = { previewer = false },
  files = {
    cwd_prompt = false,
    previewer = false,
  },
  keymap = {
    fzf = { ["ctrl-q"] = "select-all+accept" },
  },
})

vim.keymap.set("n", "<leader>fd", fl.files, { desc = "FzfLua files" })
vim.keymap.set("n", "<leader>ff", fl.buffers, { desc = "FzfLua buffers" })
vim.keymap.set("n", "<leader>fs", fl.git_status, { desc = "FzfLua git status" })
vim.keymap.set("n", "<leader>fa", function()
  fl.files { cwd = vim.fn.getenv("WORK_DIR") }
end,
{ desc = "FzfLua WORK_DIR files" })
vim.keymap.set("n", "<leader>fg", fl.live_grep_native, { desc = "FzfLua live grep" })

require("oil").setup({
  view_options = { show_hidden = true },
  skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Oil in parent directory" })

local ng = require("neogit")
ng.setup({
  kind = "replace",
  disable_insert_on_commit = true,
  commit_editor = {
    kind = "replace",
    show_staged_diff = false,
    spell_check = false,
  },
  commit_select_view = { kind = "replace" },
  log_view = { kind = "replace" },
})

vim.keymap.set("n", "<leader>hs", ng.open, { desc = "Neogit status" })
vim.keymap.set("n", "<leader>hc", ng.action("commit", "commit", { "--verbose" }), { desc = "Neogit commit" })
vim.keymap.set("n", "<leader>he", ng.action("commit", "extend"), { desc = "Neogit extend" })

local gs = require("gitsigns")
gs.setup()

local nav_hunk = function(dir)
  gs.nav_hunk(dir, { target = "all" })
  vim.defer_fn(function()
    vim.cmd("norm! zz")
  end, 10)
end
vim.keymap.set("n", "<M-h>", function()
  nav_hunk("next")
end, { desc = "Gitsigns next hunk" })
vim.keymap.set("n", "<M-H>", function()
  nav_hunk("prev")
end, { desc = "Gitsigns previous hunk" })

vim.keymap.set("n", "<leader>ha", gs.stage_hunk, { desc = "Gitsigns stage hunk" })
vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Gitsigns reset hunk" })

vim.keymap.set("n", "<leader>hd", gs.preview_hunk_inline, { desc = "Gitsigns diff hunk" })
vim.keymap.set("n", "<leader>ht", function()
  gs.diffthis("HEAD", {
    vertical = true,
    split = "belowright",
  })
end, { desc = "Gitsigns diff file" })
vim.keymap.set("n", "<leader>hb", gs.blame, { desc = "Gitsigns blame file" })

require("catppuccin").setup({
  flavour = "mocha",
  term_colors = true,
  transparent_background = true,
  float = { transparent = true },
})

vim.cmd.colorscheme("catppuccin")
