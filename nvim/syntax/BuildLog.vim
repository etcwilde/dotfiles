" Description: A brittle best-effort highlighter for log files

if exists("b:current_syntax")
  finish
endif
let s:cpo_save = &cpo
set cpo&vim

syn match logSymbol   display  '[!@#$%^&*;:?]'

" strings
syn region logString      start=/"/ end=/"/ end=/$/ skip=/\\./
syn region logString      start=/`/ end=/`/ end=/$/ skip=/\\./
syn region logString      start=/'/ end=/'/ end=/$/ skip=/\\./

" numbers
syn match  logNumber         display  '\<\d\+\>'
syn match  logNumberFloat    display  '\<\d\+\.\d\+\([eE][+-]\?\d\+\)\?\>'
syn match  logNumberBinary   display  '\<0[bB][01]\+\>'

syn match logNinjaLogLine    display "^\[\d\+/\d\+\]\[ \{0,2}\d\{1,3}%\]\[" contains=logNinjaProgress
syn match logNinjaProgress   display "\d\+/\d\+" contained

syn keyword gitCmd
      \ git

" Dates and times
syn match logDate       display     '\<\d\{4}[-\/]\(\d\d\|\a\{3}\)[-\/]\d\d\|\d\d[-\/]\(\d\d\|\a\{3}\)[-\/]\d\{4}'  contains=logDateMonth
" RFC3339 e.g. 2023-01-01T
syn match logDate       display     '\<\d\{4}-\d\d-\d\dT'
" YYYYMMDD starting with '20' e.g. 20230101
syn match logDate       display     '\<20\d{6}'
" Day 01-31
syn match logDateDay    display     '0[1-9]\|[1-2]\d\|3[0-1]\>'  contained

" 12:34:56 or 12:34:56.700000Z or 12:34:56.700000+08:00
syn match logTime       display     '\d\d:\d\d:\d\d\(\.\d\{2,6}\)\?'  skipwhite  nextgroup=logTimeZone,logTimeAMPM,logSysColumns
" AM / PM
syn match logTimeAMPM   display     '\cAM\|\cPM\>'  contained  skipwhite  nextgroup=logSysColumns
" Time zones, e.g. PST, CST etc.
syn match logTimeZone   display     'Z\|[+-]\d\d:\d\d\|\a\{3}\>'  contained  skipwhite  nextgroup=logSysColumns

syn keyword logDateMonth    Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec  nextgroup=logDateDay  skipwhite
syn keyword logDateWeekDay  Mon Tue Wed Thu Fri Sat Sun

" Links and paths
syn match   logURL      display   '\<https\?:\/\/\S\+'
syn match   logPath     display   '\(^\|\s\)\(\.\{0,2}\|\~\)\/[[:alnum:]\/\.:_-]\+'

syn match logSHA        display   '\<\(\x\{40}\|\x\{56}\|\x\{64}\|\x\{96}\|\x\{128}\)\>'
" File path starting with '/' , './', '../' and '~/'.
" Must be start-of-line or prefixed with space

" Constants
syn keyword logBool   TRUE True true FALSE False false
syn keyword logNull   NULL Null null

syn keyword logFatal      fatal
syn keyword logError      error


" Highlighting links

hi def link logNinjaLogLine  Type
hi def link logNinjaProgress Number
hi def link logNumber        Number
hi def link logNumberFloat   Float
hi def link logNumberBin     Number

hi def link logBool          Boolean
hi def link logNull          Constant
hi def link logString       String

hi def link logURL           Underlined
hi def link logPath          Structure

hi def link logSHA           Label

hi def link logDate             Type
hi def link logDateDay          Type
hi def link logDateMonth        Type
hi def link logDateWeekDay      Type
hi def link logTime             Operator
hi def link logTimeAMPM         Operator
hi def link logTimeZone         Operator

hi def link logSymbol       Special


hi link gitCmd    Keyword

hi link logFatal  ErrorMsg
hi link logError  ErrorMsg

let b:current_syntax = "log"

let &cpo = s:cpo_save
unlet s:cpo_save

finish
