set nocompatible

" Options

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4

set virtualedit=all

set history=50

set hlsearch
set ignorecase " TODO : binder une autre touche sur la recherche case-sensitive
set incsearch

set mouse=a

set number
set ruler
set showcmd

set showmatch

set guioptions-=T

syntax on

" Commandes personnalisées

command Q q!
command Df vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
