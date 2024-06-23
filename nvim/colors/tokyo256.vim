" Name:         Tokyonight256
" Description:  A reworking of folke/tokyonight with ANSI16/256 colors
" Author:       Evan Wilde <ewilde@.apple.com>
" Origin:       https://github.com/folke/tokyonight.nvim/tree/main

set background=dark
hi clear

if exists('syntax_on')
  syntax reset
endif

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2

let colors_name = "Tokyo256"

if s:t_Co > 16
  " UI Elements
  hi ColorColumn ctermbg=8
  hi Conceal ctermbg=Black
  hi Cursor cterm=reverse
  hi lCursor cterm=reverse
  hi CursorIM cterm=reverse
  hi CursorColumn cterm=None
  hi CursorLine cterm=None ctermbg=Black

  hi DiffAdd ctermbg=28 ctermfg=8
  hi DiffDelete ctermbg=160 ctermfg=8
  hi DiffChange ctermbg=8
  hi DiffText ctermfg=8 ctermbg=32 cterm=Bold,Italic

  hi Folded ctermfg=15 ctermbg=8
  hi FoldColumn ctermfg=111 ctermbg=8 cterm=Bold
  hi SignColumn ctermfg=111 ctermbg=None

  hi ErrorMsg ctermfg=DarkRed ctermbg=None
  hi WarningMsg ctermfg=Yellow ctermbg=None
  hi VertSplit cterm=None
  hi WinSeparator ctermfg=Black cterm=Bold

  hi FloatBorder ctermfg=White
  hi NormalFloat ctermbg=Black

  hi LineNr ctermfg=8
  hi CursorLineNr ctermfg=8 cterm=Bold
  hi MatchParen ctermfg=Yellow ctermbg=None cterm=Bold

  hi ModeMsg ctermfg=8 cterm=Bold
  hi ModeArea ctermfg=8

  hi Pmenu ctermbg=Black ctermfg=White

  hi StatusLine ctermfg=DarkBlue
  hi StatusLineNC ctermfg=8
  hi TabLine ctermbg=8
  hi TabLineSel ctermfg=Black ctermbg=DarkBlue
  hi TablineFill ctermfg=Black ctermbg=Black

  hi Visual ctermbg=8

  hi Search ctermbg=8 ctermfg=Black
  hi WildMenu ctermbg=Blue ctermfg=Black cterm=Bold

  hi SpellBad ctermfg=203 ctermbg=None
  hi SpellCap ctermfg=DarkBlue ctermbg=None

  " Standard Syntax Groups
  hi Normal ctermfg=White ctermbg=None cterm=None

  hi Comment ctermfg=DarkGray cterm=italic

  hi Constant ctermfg=DarkYellow
  hi String ctermfg=Green
  hi Character ctermfg=Green

  hi Identifier ctermfg=White cterm=None
  hi Function ctermfg=magenta cterm=Bold

  hi Statement ctermfg=Magenta
  hi Conditional ctermfg=Magenta cterm=Bold
  hi link Repeat Conditional
  hi Operator ctermfg=Blue
  hi Keyword ctermfg=cyan cterm=italic

  hi PreProc ctermfg=cyan

  hi Type ctermfg=Blue

  hi Special ctermfg=Blue

  hi Underlined cterm=Underline
  hi Bold cterm=Bold
  hi Italic cterm=italic


  " Language specific syntax overrides
  "
  " Swift
  hi link swiftKeyword Conditional
endif
