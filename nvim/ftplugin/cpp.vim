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
let g:ale_cpp_clangtidy_checks= ['-*', 'clang-diagnostic-*', 'llvm-*', 'misc-*', '-misc-unused-parameters', 'readability-Identifier-naming']
let g:ale_cpp_clangtidy_options='-std=c++17'
let g:ale_cpp_clang_options='-std=c++17 -Wall -fsyntax-only -x cpp -S'
let g:ale_cpp_clangcheck_options = '-std=c++17 -Wall'

"" Clang Format
vmap <silent> = :ClangFormat<CR>

let g:clang_format#code_style = 'llvm'
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "PointerAlignment" : "Middle"}
