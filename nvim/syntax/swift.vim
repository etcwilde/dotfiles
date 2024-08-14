" Vim Swift syntax file
" Language:   Swift
" Maintainer: Evan Wilde <etceterawilde@gmail>
" Last Change: 2021-11-09
"
" Some chunks grabbed from the official Swift vim syntax file,
" others are my own.

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
syntax match  swiftNumber "\<\([0-9]\+_\)*[0-9]\+\>"
syntax match  swiftNumber "\<0[Xx][0-9a-fA-F_]\+\>"
syntax match  swiftNumber "\<0[Oo][0-7_]\+\>"
syntax match  swiftNumber "\<0[Bb][01_]\+\>"

syntax match swiftFloat "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"

syntax keyword swiftNil
      \ nil

" Keywords
syntax keyword swiftKeyword
      \ await
      \ break
      \ case
      \ catch
      \ continue
      \ default
      \ defer
      \ do
      \ else
      \ fallthrough
      \ for
      \ guard
      \ if
      \ in
      \ repeat
      \ return
      \ switch
      \ throw
      \ try
      \ where
      \ while

syntax keyword swiftImport skipwhite skipempty nextgroup=swiftImportModule
      \ import

syntax keyword swiftVarDefinition skipwhite skipempty nextgroup=swiftVarName
      \ let
      \ var

syntax keyword swiftDefinitionModifier
      \ convenience
      \ dynamic
      \ fileprivate
      \ final
      \ internal
      \ lazy
      \ nonmutating
      \ mutating
      \ open
      \ override
      \ prefix
      \ private
      \ public
      \ required
      \ rethrows
      \ static
      \ throws
      \ weak

syntax keyword swiftTypeDefinition skipwhite skipempty nextgroup=swiftTypeName
      \ actor
      \ class
      \ enum
      \ extension
      \ operator
      \ precedencegroup
      \ protocol
      \ struct
      \ associatedtype
      \ typealias

syntax keyword swiftFunctionDefinition skipwhite skipempty
      \ func

" Effects
syntax keyword swiftEffect
      \ async
      \ resasync
      \ throws
      \ rethrows

syntax match swiftTypeName contained skipwhite skipempty
      \ /\<[A-Za-z_][A-Za-z_0-9\.]*\>/

syntax match swiftVarName contained skipwhite skipempty
      \ /\<[A-Za-z_][A-Za-z_0-9]*\>/

syntax match swiftImportModule contained nextgroup=swiftImportComponent
      \ /\<[A-Za-z_][A-Za-z_0-9]*\>/
syntax match swiftImportComponent contained nextgroup=swiftImportComponent
      \ /\.\<[A-Za-z_][A-Za-z_0-9]*\>/

" Set highlights
highlight default link swiftTodos Todo
highlight default link swiftShebang Comment
highlight default link swiftComment Comment

highlight default link swiftString String
highlight default link swiftMultilineString String
highlight default link swiftInterpolatedWrapper Delimiter
highlight default link swiftMultilineInterpolatedWrapper Delimiter
highlight default link swiftBoolean Boolean
highlight default link swiftNumber Number
highlight default link swiftFloat Float
highlight default link swiftKeyword Operator
highlight default link swiftNil Constant

highlight default link swiftTypeName Function
highlight default link swiftDefinitionModifier Operator
highlight default link swiftTypeDefinition Define
highlight default link swiftTypeAlias Define
highlight default link swiftFunctionDefinition Define
highlight default link swiftEffect Operator
highlight default link swiftVarDefinition Define
highlight default link swiftVarName Identifier

highlight default link swiftImport Include
highlight default link swiftImportModule String
highlight default link swiftImportComponent String

let b:current_syntax = "swift"

let &cpo = s:cpo_save
unlet s:cpo_save
