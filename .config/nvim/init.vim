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
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()

" ======================
"  VIM BUILDIN SETTINGS
" ======================

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

" Language server
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls']}
"    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
"    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
"    \ 'python': ['/usr/local/bin/pyls'],
"    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_rename()<CR>

" =================
"  PLUGIN SETTINGS
" =================

" CtrlP
" -----
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_root_markers = ['*.code-workspace']
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

