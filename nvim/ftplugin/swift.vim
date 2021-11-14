" Swift Settings
" --------------------------------------
if executable('sourcekit-lsp')
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'sourcekit-lsp',
    \ 'cmd': {server_info->['sourcekit-lsp']},
    \ 'allowlist': ['swift'],
    \ })
endif
