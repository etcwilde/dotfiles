" Vim Swift syntax file
" Language:   Swift
" Maintainer: Evan Wilde <etceterawilde@gmail>
" Last Change: 2020-08-15

" Quit when a custom syntax file has already been loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Comments
"
" Shebang
syntax match swiftShebang "\v#!.*$"

syntax match swiftComment "\v\/\/.*$" contains=swiftTodos,@Spell oneline
syntax region swiftComment start="/\*" end="\*/" contains=swiftTodos,@Spell fold


" Comment keywords

syntax keyword swiftTodos contained TODO FIXME NOTE

" Literals
"
" Strings
syntax region swiftString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=swiftInterpolatedWrapper,@Spell oneline
syntax region swiftInterpolatedWrapper start='\v\zs\\\(\s*' end='\v\s*\)' contained containedin=swiftString contains=swiftInterpolatedString,swiftString oneline
syntax match swiftInterpolatedString "\v\w+(\(\))?" contained containedin=swiftInterpolatedWrapper,swiftMultilineInterpolatedWrapper

syntax region swiftMultilineString start=/"""/ end=/"""/ contains=swiftMultilineInterpolatedWrapper,@Spell
syntax region swiftMultilineInterpolatedWrapper start='\v\zs\\\(\s*' end='\v\s*\)' contained containedin=swiftMultilineString contains=swiftInterpolatedString oneline

" Booleans
syntax keyword swiftBoolean
  \ true
  \ false

" Numbers


" syntax match swiftNumber "\v<\d+>"
" syntax match swiftNumber "\v<((\d+_+)\d+)+>"
" TODO: Add hex, octal, and binary numbers

syntax match swiftFloat "\v<\d+>"
" syntax match swiftFloat


" syntax match swiftFloat "\v<(\d+_+)+\d+(\.\d+(_+\d+)*)>"
" syntax
" syntax match swiftFloat "\v<\d+\.\d+>"
" syntax match swiftFloat "\v<\d*\.?\d+([Ee]-?)\d+>"

syn match swiftIdentifier display "\<\d*\a[a-zA-Z0-9]*\>"


" Set highlights

highlight default link swiftTodos Todo
highlight default link swiftShebang Comment
highlight default link swiftComment Comment

highlight default link swiftString String
highlight default link swiftMultilineString String
highlight default link swiftInterpolatedWrapper Delimiter
highlight default link swiftMultilineInterpolatedWrapper Delimiter
highlight default link swiftBoolean Boolean
" highlight default link swiftNumber Number
highlight default link swiftFloat String

let s:cpo_save = &cpo
set cpo&vim
