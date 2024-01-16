set nocompatible

" Options

set wildmode=longest,list,full

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4

set backspace=indent,eol,start

set list
set listchars=tab:⇒ ,space:·
"set listchars=tab:⇒ ,trail:¶

set history=50

set hlsearch
set ignorecase
set smartcase
set incsearch

set mouse=a

set number
set ruler
set showcmd

set showmatch

set formatoptions=l
set lbr
set wrap

set guioptions-=T

set cursorline
highlight CursorLine cterm=NONE ctermbg=Black

set encoding=utf8
set fileencoding=utf8

syntax on

if &diff
    colorscheme industry
endif

" Raccourcis clavier
map <C-_> :undo<CR>
imap <C-_> <Esc>:undo<CR>i
map <A-_> :redo<CR>
imap <A-_> <Esc>:redo<CR>i
map <C-t> :tabnew .<CR>
imap <C-t> <Esc>:tabnew .<CR>i
map <C-S-tab> :tabprevious<CR>
imap <C-S-tab> <Esc>:tabprevious<CR>i
map <C-tab> :tabnext<CR>
imap <C-tab> <Esc>:tabnext<CR>i
map <C-w> :tabclose<CR>

map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>i
map <C-S-s> :wa<CR>
imap <C-S-s> <Esc>:wa<CR>i

map <A-o> :e %:p:s/.hpp$/.XX-XX/:s/.cpp$/.hpp/:s/.hxx$/.YY-YY/:s/.XX-XX$/.hxx/:s/.YY-YY$/.cpp/<CR>

map <A-]> :pop<CR>
map <C-\> :tab sp<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-\> :tab vs<CR>:exec("tag ".expand("<cword>"))<CR>

" Commandes personnalisées

com Q q!
com QQ qa
com QQQ qa!
com Df vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Commandes automatiques

autocmd BufWritePre * :%g!/^-- $/ s/\s\+$//e

" TODO
" - Corriger les problèmes de texte non visible sur la ligne courante (comme : TODO)
" - Corriger le delete trailing whitespaces qui envoie en fin de fichier à chaque enregistrement
" - Raccourcis clavier pour
"   - Enregistrer
"   - Passer en mode commande
"   - Se déplacer
"   - Changer de split (haut, bas, gauche, droite)
"   - Changer d'extrémité de la sélection
" - Déplacement avec jkl; alt+jkl; pour du mot par mot ou du bloc par bloc, ctrl+jkl; pour du caractère par caractère ou ligne par ligne en mode insertion ctrl+alt+jkl; pour changer de buffer...
" - Début / fin de ligne / bloc / fichier facilement accessible
" - Faire en sorte que les raccourcis avec alt fonctionnent
" - Raccourcis séparés pour aller vers le header, les inlines, la source...
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

" NOTES
" - cscope -Rb pour générer la base de tags
" - CFLAGS="-O3" ./configure --prefix=/udir/jroquet/.local_Linux-x86_64/ --enable-pythoninterp --disable-gtktest --with-modified-by=Arkanosis --with-compiledby=Arkanosis --with-features=huge
