
" download and install Plug if it if not already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'nightsense/snow'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Airline config
let g:airline#extensions#tabline#enabled = 1

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

set enc=utf-8
set encoding=utf-8
set fileencoding=utf-8

set background=dark
colorscheme snow
syntax on
