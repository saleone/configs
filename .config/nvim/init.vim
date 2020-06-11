" Globals that need to activate
" Install plugins with 'junegunn/vim-plug'
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.config/nvim/plugged")
Plug 'tpope/vim-sensible'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" ======================
"  VIM BUILDIN SETTINGS
" ======================

" Space as leaders
let mapleader = " "

" Regular copy and paste
set pastetoggle=<F2>
set clipboard=unnamedplus

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Mouse support
set mouse=a

" Enable line numbers
set number

" No background
hi Normal guibg=NONE ctermbg=NONE

" =================
"  PLUGIN SETTINGS
" =================

source $HOME/.config/nvim/plugconf/ctrlp.vim
source $HOME/.config/nvim/plugconf/coc.vim

