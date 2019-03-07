" Globals that need to activate
" Install plugins with 'junegunn/vim-plug'
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'jimsei/winresizer'
Plug 'terryma/vim-expand-region'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fxn/vim-monochrome'
call plug#end()

" ======================
"  VIM BUILDIN SETTINGS
" ======================

" Regular copy and paste
set pastetoggle=<F2>
set clipboard=unnamedplus

" Automatic reloading of .vimrc file
autocmd! bufwritepost .vimrc source %

" Show line numbers
set number

" Show current position
set ruler

" Make backspace work as it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Height of the command bar
set cmdheight=1

" Ignore case when doing searches
set ignorecase

" When I type upper letter in search disable ignorecase
set smartcase

" Highlight search results
set hlsearch

" Show search results as I type
set incsearch

" Don't redraw screen when executing macros
set lazyredraw

" Blink to matching bracket when it can be seen on screen
set showmatch
set mat=2

" Disable error sounds
set noerrorbells

" Enable syntax highlighting
syntax enable

" Set UTF-8 encoding
set encoding=utf8

" Use Unix file type
set ffs=unix,dos,mac

" Disable backup and autosave files
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab
set smarttab

" Disable use of spaces in make files
autocmd FileType make setlocal noexpandtab

" Set four spaces as one tab
set shiftwidth=4
set tabstop=4

" Set autoindent, smart indent and wrap lines
set ai
set si
set wrap

" Reselect code after indentation
vnoremap < <gv
vnoremap > >gv

" It looks strange when skipping broken lines so treat them as regular lines
map j gj
map k gk

" Remap 0 to first non-blank character
map 0 ^

" Enable mouse
set mouse=a

" Bind window movement keys to save some keystrokes
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Rebind the leader key
let mapleader = "\<Space>"

" Visual line mode
nmap <Leader>v V

" No highlights of searches
nnoremap <Leader>n :noh<CR>

" Better tab navigation
map <Leader>h :tabprevious<CR>
map <Leader>l :tabnext<CR>
map <Leader>j :tabclose<CR>
map <Leader>k :tabnew<CR>

" Quit with <Leader>q
map <Leader>q :q!<CR>
map <Leader>Q :qall!<CR>

" Save with <Leader>w
map <Leader>w :w<CR>

" Shows preview window on the bottom
set splitbelow

" Them
colorscheme monochrome
let g:airline_theme='monochrome'

" =============
"  CUSTOM CODE
" =============

" Delete trailing white space on save.
func! DeleteTrailingWhiteSpace()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWhiteSpace()


" =================
"  PLUGIN SETTINGS
" =================

"  Region expand binds
" ---------------------
map <Leader>e <Plug>(expand_region_expand)
map <Leader>s <Plug>(expand_region_shrink)

" YouCompleteMe
" ---------------------
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0

" Winresizer
" -----------
"
"  Nice way to resize windows by pressing C-e and using hjkl.

" CtrlP
" -----
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_root_markers = ['*.code-workspace']
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

