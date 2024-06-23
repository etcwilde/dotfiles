local function sklsp_register_cap()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
  return capabilities
end

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require('lspconfig')

      lspconfig.clangd.setup {}
      lspconfig.rust_analyzer.setup {}
      lspconfig.sourcekit.setup({
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
      })

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP Actions',
      callback = function(args)
        -- Once we've attached, configure the keybindings
        local wk = require('which-key')
        wk.register({
          K = { vim.lsp.buf.hover, "LSP hover info"},
          gd = { vim.lsp.buf.definition, "LSP go to definition"},
          gD = { vim.lsp.buf.declaration, "LSP go to declaration"},
          gi = { vim.lsp.buf.implementation, "LSP go to implementation"},
          gr = { vim.lsp.buf.references, "LSP list references"},
          gs = { vim.lsp.buf.signature_help, "LSP signature help"},
          gn = { vim.lsp.buf.rename, "LSP rename"},
          ["[g"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic"},
          ["g]"] = { vim.diagnostic.goto_next, "Go to next diagnostic"},
        }, {
          mode = 'n',
          silent = true,
        })
      end,
    })
    end
  }
}
