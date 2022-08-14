" --------------------------------------
" [n]vim rc
" Evan Wilde (c) 2018
" vim:set et sw=2 ts=2 tw=80:

" Functions
" --------------------------------------

" ToggleNumbers()
" ----------------------
" Toggles between strict line number and relative line numbers

function! ToggleNumbers()
  if &number == 1
    set nonumber rnu
  else
    set number nornu
  endif
endfunction

" StripTrailingWhitespace()
" ----------------------
"  Removes whitespaces that are not followed by non-whitespace
"  characters in a line.
function StripTrailingWhitespace()
        let l:savepos = winsaveview()
        %s/\s\+$//e
        call winrestview(l:savepos)
endfunction

" Options and Variables
" --------------------------------------
set exrc          " Execute local vimrc
set secure        " Restrict some commands
set autoread      " Automatically re-read file
set backspace=start,indent,eol " Backspace works on everything
set confirm       " Save files on exit
set cursorline    " Show current cursor line
set foldmethod=syntax "Use syntax definitions for folding
set hidden        " Don't have to save when changing buffers
set hlsearch      " Highlights search
set infercase     " Adjust case of match for keyword completion
set ignorecase    " search is case-insensitive
set laststatus=2  " Always show status bar
set lazyredraw    " Only redraws what is necessary, when necessary :redraw to force
set list listchars=tab:»·,trail:·,nbsp:· " Show tabs and trailing whitespace
set modeline      " Enable top-of-file modelines NOTE: security concerns with these
set mouse=a       " Enable Mouse Clicks
set mousefocus    " Focus follows mouse
set mousehide     " Hides pointer while typing
set nostartofline " Don't move cusor on line jumps
set number        " Enable Line numbers
set ruler         " Show column and character in file
set spell         " Spelling
set tw=80         " Text Width
set ts=2          " Tab Stop
set sts=2         " Soft Tab Stop
set sw=2          " Shift width
set wildmode=list:longest,list:full " how completion behaves
set wildmenu      " Auto completion in commandline
set expandtab     " Expands the tabs to spaces
set scrolloff=5
set noshowmode
set background=dark
set encoding=utf-8
set nojoinspaces  " Don't add two spaces between sentences
set colorcolumn=+1 " Fix colour column to the textwidth

syntax on
filetype plugin indent on
colorscheme zenburn

" Autocommands
" --------------------------------------

augroup etc
  autocmd!

  " Buffer Types
  autocmd bufread,bufnewfile *.h,*.cpp,*.hpp,*.CC,*.c++,*.def setlocal ft=cpp
  autocmd bufread,bufnewfile *.ll setlocal ft=llvm tw=0
  autocmd bufread,bufnewfile *.csv setlocal ft=csv syntax=csv
  autocmd bufread,bufnewfile *.sh setlocal ft=sh
  autocmd bufread,bufnewfile *.snippets setlocal ft=snippets
  autocmd bufread,bufnewfile *.td setlocal ft=tablegen
  autocmd bufread,bufnewfile *.mm setlocal ft=objcpp
  autocmd bufread,bufnewfile *.swift setlocal ft=swift
  autocmd bufread,bufnewfile *.sil setlocal ft=sil

  " Window Control
  autocmd VimResized * wincmd =

  " Buffer Behaviour
  autocmd InsertEnter * silent! set nornu number
  autocmd InsertLeave,BufNewFile,VimEnter * silent! set rnu nonumber
  autocmd bufEnter,InsertLeave * syntax sync fromstart
  autocmd FileType cmake setlocal commentstring=#\ %s

augroup end

" [n]Vim Plugins
" --------------------------------------

if has('nvim')
  let s:editor_root=expand("~/.config/nvim")
else
  let s:editor_root=expand("~/.vim")
endif
let vundle_installed=1
let vundle_readme=s:editor_root . '/bundle/Vundle.vim/README.md'
if !filereadable(vundle_readme)
  echo "Installing Vundle"
  echo ""
  if !isdirectory(s:editor_root . '/bundle')
    call mkdir(s:editor_root . '/bundle', "p")
  endif
  echo "Getting Vundle"
  execute "!git clone https://github.com/etcwilde/Vundle.vim " . s:editor_root . "/bundle/Vundle.vim"
  echo "Got Vundle"
  let vundle_installed=0
endif
let &rtp = &rtp . ',' . s:editor_root . '/bundle/Vundle.vim/' . ',' . s:editor_root . "/lua"
call vundle#rc(s:editor_root.'/bundle')

" Plugin List
" -----------

" Plugin Manager
Bundle 'etcwilde/Vundle.vim'

" Environment
Bundle 'dense-analysis/ale'
Bundle 'godlygeek/tabular'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-surround'

if has('python3')
  Bundle 'sirver/ultisnips'
  Bundle 'prabirshrestha/asyncomplete.vim'
  Bundle 'prabirshrestha/asyncomplete-ultisnips.vim'
  Bundle 'andreypopp/asyncomplete-ale.vim'
  Bundle 'prabirshrestha/asyncomplete-lsp.vim'
endif

" Git Support
Bundle 'tpope/vim-fugitive'
Bundle 'mhinz/vim-signify'
Bundle 'Xuyuanp/nerdtree-git-plugin'

" Language Support
Bundle 'prabirshrestha/vim-lsp'

"" Python
Bundle 'tmhedberg/SimpylFold'

"" Rust
Bundle 'rust-lang/rust.vim'

"" LaTeX
Bundle 'LaTeX-Box-Team/LaTeX-Box'

"" glsl
Bundle 'tikhomirov/vim-glsl'

"" fzf
Bundle 'junegunn/fzf'
Bundle 'junegunn/fzf.vim'

if vundle_installed == 0
  :BundleInstall
endif

" LSP setup
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implmentation)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> g] <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)

  let g:lsp_format_sync_timeout = 1000
endfunction

" Swift-LSP
if executable('sourcekit-lsp')
  augroup lsp_sourcekit_lsp
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'sourcekit-lsp',
          \ 'cmd': {server_info->['sourcekit-lsp']},
          \ 'allowlist': ['swift', 'c', 'cpp', 'objc', 'objcpp', 'h'],
          \ 'blocklist': ['def'],
          \ })
  augroup end
endif

" C++-LSP
if executable('clangd')
  augroup lsp_clang
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'clangd',
          \ 'cmd': {server_info->['clangd']},
          \ 'allowlist': ['h', 'c', 'cpp', 'objc', 'objcpp'],
          \ 'blocklist': ['def'],
          \ })
  augroup end
endif

if has('python3')
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Autocomplete
" --------------------------------------
let g:asyncomplete_auto_popup = 0

" Keymaps
" --------------------------------------

lua require("ewilde.keymaps")

" Status Line
" --------------------------------------

lua require("ewilde.status")

" Tabularize
" --------------------------------------
vmap as :Tabularize / <CR>

" Clang Format
" --------------------------------------
" Format a range of lines with clang format

let g:clang_format_path = exepath('clang-format')
if has('python') || has('python3')
  let s:clang_fmt_path = s:editor_root . '/accessories/clang-format.py'
  if  has('python3')
    execute "xnoremap <silent> = :py3f " . s:clang_fmt_path . "<cr><cr>"
  else
    execute "xnoremap <silent> = :pyf " . s:clang_fmt_path . "<cr><cr>"
  endif
endif

" Ale Setup
" --------------------------------------
let g:ale_linters = {
      \   'cpp': ['clangtidy', 'clang'],
      \}

" Snippets
" --------------------------------------

" UltiSnip info:
" snippet options:
" - !: overwrite previously defined snippets
" - b: beginning of a line
" - i: InWord expansion (does not require whitespace before expansion)
" - w: Word boundary
" - r: regular expression
" - t: Don't expand tabs

if has("nvim")
  let g:UltiSnipsSnippetsDir=$HOME.'/.config/nvim/ulti-snippets'
  let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ulti-snippets']
else
  let g:UltiSnipsSnippetsDir=$HOME.'/.vim/ulti-snippets'
  let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/ulti-snippets']
endif

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Fzf Setup
" --------------------------------------
let g:fzf_layout = {'window': { 'width': 0.9, 'height': 0.6 }, 'down': '40%' }
nnoremap <tab> :FZF<CR>
nnoremap <C-R> :Rg<CR>
nnoremap <leader>buf :Buffers<CR>
