return {
  "neovim/nvim-lspconfig",
  dependencies = "saghen/blink.cmp",

  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    require("lspconfig").pyright.setup { capabilities = capabilities }
    require("lspconfig").ruff.setup {}

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        local opts = { buffer = args.buf, noremap = true, silent = true }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gn", vim.lsp.buf.rename, opts)

        if vim.bo.filetype == "python" then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end
          })
        end
      end
    })
  end
}
