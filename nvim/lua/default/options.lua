-- latency
vim.opt.updatetime = 250 -- decrease update time
vim.opt.timeoutlen = 300 -- decrease mapped sequence wait time

-- splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- appearance
vim.opt.guicursor = "" -- block cursor
vim.opt.cursorline = true -- highlight cursor line
vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers
vim.opt.wrap = false -- no wrap
vim.opt.signcolumn = "yes" -- gutter
vim.opt.laststatus = 0 -- hide status line
vim.opt.scrolloff = 10 -- minimum number of lines to keep above and below the cursor

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

-- edit
vim.opt.shiftwidth = 4 -- indent
vim.opt.inccommand = "split" -- preview offscreen substitutions
vim.opt.undofile = true -- preserve undo history

-- search
vim.opt.ignorecase = true -- ignore case
vim.opt.smartcase = true -- override for mixed case
