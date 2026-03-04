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
vim.keymap.set("n", "<leader>fg", fl.live_grep_native, { desc = "FzfLua live grep" })

local work_dir = vim.fn.getenv("WORK_DIR")
vim.keymap.set("n", "<leader>fa", function()
  fl.files { cwd = work_dir }
end, { desc = "FzfLua WORK_DIR files" })

vim.keymap.set("n", "<leader>fp", function()
  fl.fzf_exec("fd -t d -d 1 -L --base-directory " .. work_dir, {
    winopts = { title = " Projects " },
    actions = {
      ["default"] = function(selected)
        if selected[1] then
          local dir = table.concat({
            work_dir,
            vim.fn.fnameescape(selected[1])
          }, "/")
          vim.cmd("cd " .. dir)
        end
      end,
    },
  })
end, { desc = "FzfLua change directory" })

require("oil").setup({
  view_options = { show_hidden = true },
  skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Oil in parent directory" })

local gs = require("gitsigns")
gs.setup()

local nav_hunk = function(keymap, dir)
  vim.keymap.set({ "n", "v" }, keymap, function()
    gs.nav_hunk(dir, { target = "all" }, function()
      vim.cmd("norm! zz")
    end)
  end, { desc = "Gitsigns " .. dir .. " hunk" })
end
nav_hunk("<M-h>", "next")
nav_hunk("<M-H>", "prev")

local hunk_action = function(keymap, action)
  vim.keymap.set("n", keymap, gs[action .. "_hunk"], {
    desc = "Gitsigns " .. action .. " hunk"
  })
  vim.keymap.set("v", keymap, function()
    gs[action .. "_hunk"]({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Gitsigns " .. action .. " hunk (visual)" })
end
hunk_action("<leader>ha", "stage")
hunk_action("<leader>hr", "reset")

vim.keymap.set("n", "<leader>hd", gs.preview_hunk_inline, { desc = "Gitsigns diff hunk" })

vim.keymap.set({ "o", "x" }, "ih", "<Cmd>Gitsigns select_hunk<CR>")

local gu = require("gitutils")
gu.setup()

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  pattern = "*",
  callback = require("gitutils.helpers").refresh_head
})

vim.opt.rulerformat = '%66(%{g:gitutils_head}%= %l,%c%)'

vim.keymap.set("n", "<leader>hc", gu.commit, { desc = "Gitutils commit" })
vim.keymap.set("n", "<leader>he", gu.extend, { desc = "Gitutils extend" })
vim.keymap.set("n", "<leader>hb", gu.checkout, { desc = "Gitutils checkout" })
vim.keymap.set("n", "<leader>hx", gu.rebase, { desc = "Gitutils interactive rebase" })
vim.keymap.set("n", "<leader>hv", gu.continue, { desc = "Gitutils rebase continue" })

local stage_range = function(mode)
  if mode == "v" then
    return { vim.fn.line("."), vim.fn.line("v") }
  end
end

for _, mode in ipairs({ "n", "v" }) do
  vim.keymap.set(mode, "<leader>hf", function()
    gs.stage_hunk(stage_range(mode), {}, function()
      gu.extend()
    end)
  end, { desc = "Gitsigns stage and Gitutils extend" })
end

vim.keymap.set("n", "<leader>ht", gu.diffthis, { desc = "Gitutils diff buffer" })
vim.keymap.set("n", "<leader>hg", gu.diff, { desc = "Gitutils diff repo" })
vim.keymap.set("n", "]g", function()
  gu.qf_diff("next")
end, { desc = "Gitutils next diff" })
vim.keymap.set("n", "[g", function()
  gu.qf_diff("prev")
end, { desc = "Gitutils prev diff" })

require("kanagawa").setup({
  transparent = true,
  statementStyle = { bold = false },
  overrides = function()
    local t = {}
    for _, key in ipairs({
      "ModeMsg",
      "CursorLineNr",
      "Boolean",
      "@keyword.operator",
      "@string.escape",
    }) do
      t[key] = { bold = false }
    end
    return t
  end,
})

vim.cmd.colorscheme("kanagawa")
