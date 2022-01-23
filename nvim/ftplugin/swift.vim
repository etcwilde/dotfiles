" Swift Settings
" --------------------------------------

autocmd FileType swift setlocal omnifunc=lsp#complete
    autocmd FileType swift setlocal foldmethod=expr
          \ foldexpr=lsp#ui#vim#folding#foldexpr()
          \ foldtext=lsp#ui#vim#folding#foldtext()
