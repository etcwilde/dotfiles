" --------------------------------------
" nvim rc
" Evan Wilde

" Table of contents
" --------------------------------------
"  Functions
"  Options and Variables
"  Plugins
"  Autocommands
"  Key-Remaps
"       F2 : Toggles syntax checking and indentation, (toggles pastemode)
"       F3 : Strips trailing whitespace
"       F4 : Toggles spell check
"       F5 : Fixes indentation over entire file
"       F6 : Toggles relative and global line numbers
"

" Functions
" --------------------------------------

" ToggleNumbers()
" ----------------------
" Toggles between strict line number and relative line numbers

function ToggleNumbers()
        if &number == 1
                set nonumber rnu
        else
                set number nornu
        endif
endfunction

" Options and Variables
" --------------------------------------
set exrc          " Execute local vimrc
set secure        " Restrict some commands
set autoread      " Automatically re-read file
set backspace=start,indent,eol " Backspace works on everything
set cmdheight=2   " More space for the command bar
set confirm       " Save files on exit
set cursorline    " Show current cursor line
set foldmethod=syntax "Use syntax definitions for folding
set hidden        " Don't have to save when changing buffers
set hlsearch      " Highlights search
set infercase     " Adjust case of match for keyword completion
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
set tw=72         " Text Width
set ts=4          " Tab Stop
set sts=4         " Soft Tab Stop
set wildmode=list:longest,list:full " how completion behaves
set wildmenu      " Auto completion in commandline
set expandtab     " Expands the tabs to spaces
set scrolloff=5
set background=dark
set encoding=utf-8
set nojoinspaces  " Don't add two spaces between sentences
colorscheme zenburn
let &colorcolumn=join(range(&tw+1,&tw+1), ",")
syntax on
filetype plugin indent on

" [n]Vim Plugins
" --------------------------------------

if has('nvim')
        let s:editor_root=expand("~/.config/nvim")
else
        let s:editor_root=expand("~/.vim")
endif

" Download vundle if not installed
let vundle_installed=1
let vundle_readme=s:editor_root . '/bundle/vundle/README.md'
if !filereadable(vundle_readme)
        echo "Installing Vundle"
        echo ""
        silent call mkdir(s:editor_root . '/bundle', "p")
        silent execute "!git clone https://github.com/VundleVim/Vundle.vim " . s:editor_root . "/bundle/vundle"
        let vundle_installed=0
endif
let &rtp = &rtp . ',' . s:editor_root . '/bundle/vundle/'
call vundle#rc(s:editor_root.'/bundle')

" Plugin List
" -----------
" Plugin managment
Bundle 'VundleVim/Vundle.vim'

" Language Support

"" C++
Bundle 'rhysd/vim-clang-format'
Bundle 'roxma/nvim-completion-manager'
Bundle 'roxma/ncm-clang'

"" Python
Bundle 'tmhedberg/SimpylFold'
Bundle 'davidhalter/jedi-vim'

"" Rust
Bundle 'rust-lang/rust.vim'

"" LaTeX
Bundle 'LaTeX-Box-Team/LaTeX-Box'

"" Antlr/llvm
Bundle 'dylon/vim-antlr'
Bundle 'Superbil/llvm.vim'

"" glsl
Bundle 'tikhomirov/vim-glsl'

"" Org
Bundle 'jceb/vim-orgmode'
Bundle 'dhruvasagar/vim-table-mode'

"" Haskell
Bundle 'eagletmt/ghcmod-vim'
Bundle 'eagletmt/neco-ghc'
Bundle 'lukerandall/haskellmode-vim'
if has('nvim')
  Bundle 'neovimhaskell/haskell-vim'
endif

" Environment
Bundle 'jlanzarotta/bufexplorer'
Bundle 'tpope/vim-commentary'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-speeddating'
Bundle 'Konfekt/FastFold'
Bundle 'etcwilde/ultisnips'
Bundle 'etcwilde/vim-snippets'
Bundle 'Raimondi/delimitMate'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'w0rp/ale'
Bundle 'Shougo/vimproc'
Bundle 'chr4/sslsecure.vim'

" Git Support
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'Xuyuanp/nerdtree-git-plugin'
if vundle_installed == 0
        echo "Installing Bundles (Ignore map errors)"
        echo ""
        :BundleInstall
endif

" Autocommands
" --------------------------------------
autocmd Filetype cpp setlocal
autocmd Filetype c setlocal
autocmd Filetype html setlocal nolist ts=4 sts=4 sw=4
autocmd Filetype htmldjango setlocal nolist ts=4 sts=4 sw=4
autocmd Filetype xml setlocal
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4 nolist
autocmd Filetype css setlocal ts=4 noet sw=4
autocmd Filetype rust setlocal ts=4 sw=4
autocmd Filetype make setlocal nolist noexpandtab
autocmd Filetype haskell setlocal et tw=9 sts=4 sw=4 sr omnifunc=necoghc#omnifunc
autocmd bufread,bufnewfile *.md set ft=markdown
autocmd bufread,bufnewfile *.tex set ft=tex
autocmd bufread,bufnewfile *.rs set ft=rust
autocmd bufread,bufnewfile *.glsl set ft=glsl
autocmd bufread,bufnewfile *.soy set ft=soy
autocmd bufread,bufnewfile *.cpp,*.hpp,*.CC,*.c++ set ft=cpp
autocmd bufread,bufnewfile *.service set ft=systemd
autocmd bufread,bufnewfile Cargo.toml,Cargo.lock,*.rs compiler cargo
autocmd bufread,bufnewfile *.hs compiler ghc
autocmd InsertEnter * silent! set nornu number
autocmd bufenter,insertleave * syntax sync fromstart
autocmd InsertLeave,BufNewFile,VimEnter * silent! set rnu nonumber
autocmd bufread,bufnewfile *.g4 set filetype=antlr4
autocmd bufread,bufnewfile *.g3 set filetype=antlr3
autocmd bufread,bufnewfile *.ll set filetype=llvm
autocmd bufread,bufnewfile *.org set filetype=org
autocmd bufread,bufnewfile *.csv set filetype=csv syntax=csv
autocmd VimResized * wincmd =
autocmd bufread,bufnewfile *.py setlocal ts=4 sts=4 sw=4 tw=79 expandtab ai

" Gist Setup
" --------------------------------------
let g:gist_get_multiplefile = 1

" Ale Setup
" --------------------------------------
let g:ale_linters = {
\   'cpp': ['clangtidy', 'clang'],
\}

" Clang_complete Setup
" --------------------------------------
let g:clang_complete_auto=1
let g:clang_use_library=1
let g:clang_debug=1
let g:clang_library_path='/usr/lib/libclang.so'


" FZF Configuration
" --------------------------------------
let g:fzf_action = {
  \'ctrl-t': 'tab-split',
  \'ctrl-x': 'v-split'}

let g:fzf_layout = {'window': 'enew'}
let g:fzf_layout = {'window': '-tabnew'}

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" Ignore build directory
set wildignore+=*/build/**

" Key-Remaps
" --------------------------------------
nnoremap <F2>   :set invpaste paste?<CR>
imap <F2> <C-O> :set invpaste paste?<CR>
set pastetoggle=<F2>
nnoremap <F3>   :StripWhitespace<CR>
imap <F3> <C-O> :StripWhitespace<CR>
nnoremap <F4>   :setlocal spell! spelllang=en<CR>
imap <F4> <C-O> :setlocal spell! spelllang=en<CR>
map <F5>        mzgg=G'z
nnoremap <silent> <C-w>+ :exec "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <C-w>- :exec "resize " . (winheight(0) * 2/3)<CR>

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

nnoremap <C-n>  :call ToggleNumbers()<CR>

" Tab Navigation
nnoremap tj :tabfirst<CR>
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tk :tablast<CR>
nnoremap tn :tabnew<CR>
nnoremap tml :tabmove +<CR>
nnoremap tmh :tabmove -<CR>
nnoremap tc :tabclose<CR>

" leader
let mapleader = "-"

" Tabularize
vmap as :Tabularize / <CR>
