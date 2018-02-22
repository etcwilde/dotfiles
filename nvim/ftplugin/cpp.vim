" C++ Settings
" --------------------------------------
set sw=4
set ts=4
set sts=4
set et

"" Alignment
vmap a= :Tabluarize /=<CR>

"" Syntax Checker
let g:ale_cpp_clangtidy_checks= ['*', '-google-runtime-references', '-fuchsia-*']
let g:ale_cpp_clangtidy_options='-std=c++17'
let g:ale_cpp_clang_options='-std=c++17 -Wall'
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
