" Swift Settings
" --------------------------------------
if executable('sourcekit-lsp')
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'sourcekit-lsp',
    \ 'cmd': {server_info->['sourcekit-lsp']},
    \ 'allowlist': ['swift'],
    \ })

  setlocal foldmethod=expr
        \ foldexpr=lsp#ui#vim#folding#foldexpr()
        \ foldtext=lsp#ui#vim#folding#foldtext()
endif
