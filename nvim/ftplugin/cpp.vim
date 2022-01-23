" C++ Settings
" --------------------------------------
set sw=2
set ts=2
set sts=2
set et      " expand tabs
set nowrap  " Don't wrap lines

"" Alignment
vmap a= :Tabluarize /=<CR>

"" Syntax Checker
let g:ale_cpp_cc_options='-std=c++17 -Wall'
let g:ale_cpp_clangtidy_checks= ['-*', 'clang-diagnostic-*', 'llvm-*', 'misc-*', '-misc-unused-parameters', 'readability-Identifier-naming']
let g:ale_cpp_clangtidy_options='-std=c++17 -Wall'
let g:ale_cpp_clang_options='-fsyntax-only -x cpp -S'
let g:ale_cpp_clangcheck_options = '-std=c++17 -Wall'
