" Haskell Settings
" --------------------------------------
let g:haddock_browser                    = "/usr/bin/google-chrome"
let g:ghc                                = "/usr/bin/ghc"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 0
let g:syntastic_check_on_open            = 0
let g:syntastic_check_on_wq              = 0
let g:haskellmode_completion_ghc         = 1
let g:haskell_tabular                    = 1

if has('nvim')
  let g:haskell_enable_quantification   = 1
  let g:haskell_enable_recursivedo      = 1
  let g:haskell_enable_arrowsyntax      = 1
  let g:haskell_enable_pattern_synonyms = 1
  let g:haskell_enable_static_potiners  = 1
  let g:haskell_backpack                = 1
endif

" Alignment
" --------------------------------------
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

