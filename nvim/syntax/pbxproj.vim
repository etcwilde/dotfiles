" Vim Xcode project file syntax file
" Language: pbxproj
" Maintainer: Evan Wilde
" Last Change: 2024-09-19
"

if exists("b:current_syntax")
  finish
endif
let s:cpo_save = &cpo
set cpo&vim

" Comment
syn region pbxprojCommentLine  start="//" skip="\\$" end="$" keepend
syn region pbxprojComment      start="/\*" end="\*/" fold

" String
syn region pbxprojString start=/"/ end=/"/ end=/$/ skip=/\\./ contains=pbxprojStringVariableExpansion
syn region pbxprojString start=/'/ end=/'/ end=/$/ skip=/\\./ contains=pbxprojStringVariableExpansion

syn region pbxprojStringVariableExpansion start="$(" end=")" contained

syn match pbxprojID display '\<\x\{24}'

" number
syn match pbxprojNumber display '\<\d\+\>'

" brace folds
syn region pbxprojBlock  start="{" end="};" fold transparent
syn region pbxprojParen  start="(" end=")" fold transparent

" Colors
hi def link pbxprojCommentLine Comment
hi def link pbxprojComment     Comment
hi def link pbxprojID          Identifier
hi def link pbxprojNumber      Number
hi def link pbxprojString      String

let s:cpo_save = &cpo
set cpo&vim

let b:current_syntax = "pbxproj"
