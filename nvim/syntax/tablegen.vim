" Vim syntax file
" Language:     Tablegen
" Maintainer:   Evan Wilde <etceterawilde@gmail.com>
" Last Change:  2019-06-14

" Quit when a (custom) syntax file has already been loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

let s:ft = matchstr(&ft, '^\([^.]\)\+')

" Identifiers
syn match   tgIdentifier display "\<\d*\a[a-zA-Z0-9]*\>"

" TableGen lexical literals
" Numbers
syn match     tgNumber display "\zs[+-]\=\<\d\+\>"
syn match     tgNumber display "\<0x\x\+\>"
syn match     tgNumber display "\<0b[01]\+\>"

" strings
syn region  tgString    start=/"/ skip=/\\"/ end=/"/ oneline contains=@Spell
syn region  tgCode      start="\[{" end="}\]" fold contains=@Spell

" TableGen comments
syn case ignore
syn keyword tgTodo contained todo fixme
syn match   tgLineComment   "\/\/.*$"         contains=tgTodo,@Spell
syn region  tgBlockComment start=+/\*+ end=+\*/+ contains=tgTodo,tgBlockComment,@Spell fold

" TableGen Keywords
syn case match
syn region  tgIncluded   display contained start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@NoSpell
syn match   tgInclude   "include\s*" contains=tgIncluded
syn keyword tgStruct class def
syn keyword tgKeyword multiclass dag foreach defm field in let
syn keyword tgType bit bits int list multiclass string code

syn region  tgBlock     start="{" end="}" transparent fold

hi def link tgStruct        Structure
hi def link tgKeyword       Statement
hi def link tgType          Type
hi def link tgNumber        Number
hi def link tgTodo          Todo
hi def link tgString        String
hi def link tgCode          tgString
hi def link tgLineComment   Comment
hi def link tgBlockComment  Comment
hi def link tgInclude       Include

let b:current_syntax = "tablegen"

unlet s:ft

let s:cpo_save = &cpo
set cpo&vim
