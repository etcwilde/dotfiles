" --------------------------------------
" [n]vim rc
" Evan Wilde (c) 2018
" vim:set et sw=2 ts=2 tw=72:

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

" StripTrainlingWhitespace()
" ----------------------
"  Removes whitespaces that are not followed by non-whitespace
"  characters in a line.
function StripTrainlingWhitespace()
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
set tw=72         " Text Width
set ts=4          " Tab Stop
set sts=4         " Soft Tab Stop
set sw=4          " Shift width
set wildmode=list:longest,list:full " how completion behaves
set wildmenu      " Auto completion in commandline
set expandtab     " Expands the tabs to spaces
set scrolloff=5
set background=dark
set encoding=utf-8
set nojoinspaces  " Don't add two spaces between sentences
set colorcolumn=+1 " Fix colour column to the textwidth

syntax on
filetype plugin indent on
colorscheme zenburn

" Autocommands
" --------------------------------------

" Buffer Types
autocmd bufread,bufnewfile *.h,*.cpp,*.hpp,*.CC,*.c++ setlocal ft=cpp
autocmd bufread,bufnewfile *.ll setlocal ft=llvm tw=0
autocmd bufread,bufnewfile *.csv setlocal ft=csv syntax=csv
autocmd bufread,bufnewfile *.sh setlocal ft=sh
autocmd bufread,bufnewfile *.snippets setlocal ft=snippets
autocmd bufread,bufnewfile *.td setlocal ft=tablegen

" Window Control
autocmd VimResized * wincmd =

" Buffer Behaviour
autocmd InsertEnter * silent! set nornu number
autocmd InsertLeave,BufNewFile,VimEnter * silent! set rnu nonumber
autocmd bufEnter,InsertLeave * syntax sync fromstart
autocmd FileType cmake setlocal commentstring=#\ %s

" Onsave
autocmd BufWritePre * call StripTrainlingWhitespace() " Delete trailing ws


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
  execute "!git clone https://github.com/VundleVim/Vundle.vim " . s:editor_root . "/bundle/Vundle.vim"
  echo "Got Vundle"
  let vundle_installed=0
endif
let &rtp = &rtp . ',' . s:editor_root . '/bundle/Vundle.vim/'
call vundle#rc(s:editor_root.'/bundle')

" Plugin List
" -----------

" Plugin Manager
Bundle 'etcwilde/Vundle.vim'

" Environment
Bundle 'W0rp/ale'
Bundle 'sirver/ultisnips'
Bundle 'godlygeek/tabular'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-surround'

" Auto Completion
if has('nvim')
   Bundle 'ncm2/ncm2'
   Bundle 'roxma/nvim-yarp'

   autocmd BufEnter * call ncm2#enable_for_buffer()
   set completeopt=noinsert,menuone,noselect

   Bundle 'ncm2/ncm2-bufword'
   Bundle 'ncm2/ncm2-tmux'
   Bundle 'ncm2/ncm2-path'
   Bundle 'ncm2/ncm2-ultisnips'
   Bundle 'ncm2/ncm2-jedi'

endif

" Git Support
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'Xuyuanp/nerdtree-git-plugin'
if vundle_installed == 0
  :BundleInstall
endif

" Language Support

"" C++
Bundle 'rhysd/vim-clang-format'
if has('nvim')
  Bundle 'ncm2/ncm2-pyclang'
endif

"" Python
Bundle 'tmhedberg/SimpylFold'
Bundle 'davidhalter/jedi-vim'
if has('nvim')
endif

"" Rust
Bundle 'rust-lang/rust.vim'

"" LaTeX
Bundle 'LaTeX-Box-Team/LaTeX-Box'

"" glsl
Bundle 'tikhomirov/vim-glsl'


" Keymaps
" --------------------------------------

nnoremap <silent> <C-n> :call ToggleNumbers()<CR>

" Tabs
nnoremap <leader>tj :tabfirst<CR>
nnoremap <leader>th :tabprev<CR>
nnoremap <leader>tl :tabnext<CR>
nnoremap <leader>tk :tablast<CR>
nnoremap <leader>tc :tabnew<CR>
nnoremap <leader>tml :tabmove +<CR>
nnoremap <leader>tmh :tabmove -<CR>
nnoremap <C-d> :tabclose<CR>

" Windows
nnoremap <silent> <C-w>+ :exec "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <C-w>- :exec "resize " . (winheight(0) * 2/3)<CR>

" Spelling
nnoremap <C-s>   :setlocal spell! spelllang=en<CR>

" Ale Setup
" --------------------------------------
let g:ale_linters = {
      \   'cpp': ['clangtidy', 'clang'],
      \}

" Clang_complete Setup
" --------------------------------------
let g:ncm2_pyclang#library_path='/usr/lib/libclang.so'
let g:ncm2_pyclang#clang_path='/usr/bin/clang'

" Tabularize
" --------------------------------------
vmap as :Tabularize / <CR>

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
