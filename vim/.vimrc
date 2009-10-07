set nocompatible

" Options

set autoindent
set history=50
set hlsearch
set is
set mouse=a
set ruler
set showcmd

syntax on

" Commandes personnalisées

command Q q!
command Df vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
