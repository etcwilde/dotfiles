" Vim ModuleMap syntax file
" Language: ModuleMap
" Maintainer: Evan Wilde <etceterawilde@gmail.com>
" Last Change: 2023-08-11
"
" Super minimal modulemap syntax support

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

let s:ft = matchstr(&ft, '^\([^.]\)\+')

" Comments
syn region modulemapCommentL start="//" skip="\\$" end="$" keepend contains=@Spell

" Strings
syn region modulemapString start=+\%(L\|U\|u8\)\="+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell extend
syn region modulemapHeaderString start=+\%(L\|U\|u8\)\="+ skip=+\\\\\|\\"+ end=+"+ extend contained

" Keywords
syn keyword modulemapKeyword
      \ config_macros
      \ conflict
      \ exclude
      \ explicit
      \ extern
      \ export
      \ export_as
      \ framework
      \ link
      \ private
      \ requires
      \ textual
      \ umbrella
      \ use

syn keyword modulemapKeywordHeader header nextGroup=modulemapHeaderString skipwhite
syn keyword modulemapKeywordModule module nextGroup=modulemapName skipwhite

syn match modulemapName '\i\+' contained

" Fold
syn region modulemapBlock start="{" end="}" transparent fold

" Colors
hi def link modulemapCommentL Comment
hi def link modulemapHeaderString String
hi def link modulemapKeyword Statement
hi def link modulemapKeywordHeader modulemapKeyword
hi def link modulemapKeywordModule Define
hi def link modulemapName Identifier
hi def link modulemapString String

unlet s:ft

let s:cpo_save = &cpo
set cpo&vim
