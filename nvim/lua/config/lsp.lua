vim.lsp.config('*', {
  root_markers = { '.git', },
})

vim.lsp.enable('sourcekit')
vim.lsp.enable('clangd')
vim.lsp.enable('pyls')

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP Actions',
  callback = function(args)
    require('which-key').add({
      mode = { "n" },
      { "K", vim.lsp.buf.hover, desc = "LSP Hover Info" },
      { "gd", vim.lsp.buf.definition, desc = "LSP go to definition" },
      { "gD", vim.lsp.buf.declaration, desc = "LSP go to declaration" },
      { "gi", vim.lsp.buf.implementation, desc = "LSP go to implementation" },
      { "gr", vim.lsp.buf.references, desc = "LSP list references" },
      { "gs", vim.lsp.signature_help, desc = "LSP signature help" },
      { "gn", vim.lsp.buf.rename, desc = "LSP rename" },
      { "[g", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
      { "g]", vim.diagnostic.goto_next, desc = "Go to next diagnostic" },
    })
  end,
})
