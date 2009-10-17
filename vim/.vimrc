set nocompatible

" Options

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set list
set listchars=tab:⇒ ,trail:¶

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

" Raccourcis clavier
imap <C-t>:tabnew .

" Commandes personnalisées
:nmap <C-S-tab> :tabprevious<CR>
:nmap <C-tab> :tabnext<CR>
:map <C-S-tab> :tabprevious<CR>
:map <C-tab> :tabnext<CR>
:imap <C-S-tab> <Esc>:tabprevious<CR>i
:imap <C-tab> <Esc>:tabnext<CR>i
:nmap <C-t> :tabnew .<CR>
:imap <C-t> <Esc>:tabnew .<CR>
:map <C-w> :tabclose<CR>

com Q q!
com Df vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" TODO
" - Passage au suivant/précédent dans une recherche incrémentale, sans pour autant sortir de la recherche incrémentale (equiv ctrl-s|r emacs / zsh)
" - Passer d'une extrémité de la sélection à l'autre (equiv ctrl-x x emacs)
" - Afficher les espaces en tant que middle-dot UTF-8 (equiv notepad++)
" - Utiliser ZSH comme shell
" - Changement de buffer en tappant un extrait du nom du fichier dans lequel on veut aller (equiv iswitchb emacs)
" - Ouverture de fichier en tappant un extrait du nom du fichier dans lequel on veut aller (equiv ido emacs)
" - Passage du header à la source (equiv alt-o visual-assist-X)
" - Indentation / dé-indentation du texte sélectionné (equiv tab notepad++)
" - Inversion de deux lettres/mots/lignes (equiv ctrl-t/alt-t emacs / zsh)
" - Redimensionner split
" - Afficher révision VCS
" - Explorateur de classes / fonctions (equiv visual / eclipse)
" - Code crawler : goto definition, goto included file, show usages (equiv visual / eclipse)
" - Search in files (equiv eclipse)
" - Commenter sélection (equiv tous les autres)

