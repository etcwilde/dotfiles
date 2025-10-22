vim.lsp.config('*', {
  root_markers = { '.git', },
})

vim.lsp.enable('sourcekit')
vim.lsp.enable('clangd')

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP Actions',
  callback = function(args)
    local wk = require('which-key')
    wk.register({
      K = { vim.lsp.buf.hover, "LSP hover info" },
      gd = { vim.lsp.buf.definition, "LSP go to definition" },
      gD = { vim.lsp.buf.declaration, "LSP go to declaration" },
      gi = { vim.lsp.buf.implementation, "LSP go to implementation" },
      gr = { vim.lsp.buf.references, "LSP list references" },
      gs = { vim.lsp.signature_help, "LSP signature help" },
      gn = { vim.lsp.buf.rename, "LSP rename" },
      ["[g"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
      ["g]"] = { vim.diagnostic.goto_next, "Go to next diagnostic" },
    }, {
      mode = 'n',
      silent = true,
    })
  end,
})
