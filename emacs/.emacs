;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Arkonf for Emacs                                                    ;
;  (C) 2006-2018 - Jérémie Roquet                                      ;
;  jroquet@arkanosis.net                                               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO
;; dans ido-mode, répertoires nommées (ex: ~edkt/, ~i612/…)
;; c-cc avec du texte sélectionné commente oldskool (ex: foo(int [bar]) ⇒ fo(int /* bar */[]))
;; emacs + firefox (notamment pour Wikipédia) :
;;  - emacs (+ mediawiki-mode, etc.)
;;  - flyspell
;;  - itsalltext
;;  - mod pour itsalltext qui lance les aperçus mediawiki
;;  => Objectif : dans Firefox, un clic sur « modifier »
;;    - passe la page en mode « aperçu »
;;    - ouvre emacs en mode mediawiki
;;   Chaque ctrl+x+s sauvegarde un brouillon et met à jour l'aperçu (nickel pour le bi-écrans)
;;   Le ctrl+x+w publie (en demandant le résumé de modif)
;;   + : support de emacs-server / emacs-client (un seul emacs pour tous les articles modifiés)
;;   Conf:
;;
;;
;;    |---------------------------|---------------------------|
;;    |				  |			      |
;;    |				  \	    Firefox	      |
;;    |	     Emacs, édition    	   |   	Lecture, aperçu…      |
;;    |	  (wiki-texte, javascript) |			      |
;;    |			   	   |	Plusieurs onglets     |
;;    |			   	   /     dont un commandé     |
;;    |	(besoin de copier-coller  |        par LiveRC         |
;;    |  depuis et vers IRSSI)	  /			      |
;;    |+------------------------------------------------------|
;;    |       IRSSI, chat  	 \	     LiveRC	      |
;;    |                            \(avec contrôle au clavier)|
;;    -----------------------------\--------------------------|
;;
;;    L'édition en local de javascript modifie un fichier servi sur localhost
;;    qui permet, lors de la sauvegarde, d'avoir l'aperçu en temps réel dans
;;    Firefox
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; - Commande pour copier intégralement la ligne courante
; - Commande pour copier le token / le morceau de ligne qui suit / qui précède
; - Suppression du mot qui suit / précède *sans copier*
; - Support du open-file-at-point

;; Désactiver le gc le temps du chargement de la configuration
(setq gc-cons-threshold 100000000)

;; Pour Exalead
(setq standard-indent 2)
(setq tab-width 2)
(set-variable 'c-argdecl-indent   0)
(setq c-basic-offset 2)
(setq c-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2))))
(setq c++-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2))))
(setq java-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-basic-offset 4))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fonctions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Emacs named server
;; (C) 2010 - Arkanosis

(defun srv()
  (interactive)
  (setq
   server-name
   (read-string "server-name " "" nil "" nil))
  (server-start))

;; Emacs web-search
;; (C) 2009 - Arkanosis

(defun web-search(browser engine url)
  (setq
   term
   (read-string
    (concat engine " ")
    "" nil "" nil))
  (shell-command-to-string
   (format
    (concat browser " \"" url "\"")
    term)))
(defun firefox-search(engine url)
  (web-search "firefox" engine url)
)
(defun google-search()
  (interactive)
  (firefox-search "google" "http://www.google.fr/search?q=%s"))
(defun frwiki-search()
  (interactive)
  (firefox-search "frwiki" "http://fr.wikipedia.org/wiki/%s"))
(defun frwiki-template-search()
  (interactive)
  (firefox-search "frwiki" "http://fr.wikipedia.org/wiki/Modèle:%s"))
(defun enwiki-search()
  (interactive)
  (firefox-search "enwiki" "http://en.wikipedia.org/wiki/%s"))
(defun enwiki-template-search()
  (interactive)
  (firefox-search "enwiki" "http://en.wikipedia.org/wiki/Template:%s"))

(defun web-search-region(browser engine url begin end)
  (shell-command-to-string
   (format
    (concat browser " \"" url "\"")
    (buffer-substring begin end))))
(defun firefox-search-region(engine url begin end)
  (web-search-region "firefox" engine url begin end)
)
(defun google-search-region(begin end)
  (interactive "r")
  (firefox-search-region "google" "http://www.google.fr/search?q=%s" begin end))
(defun frwiki-search-region(begin end)
  (interactive "r")
  (firefox-search-region "frwiki" "http://fr.wikipedia.org/wiki/%s" begin end))
(defun frwiki-template-search-region(begin end)
  (interactive "r")
  (firefox-search-region "frwiki" "http://fr.wikipedia.org/wiki/Modèle:%s" begin end))
(defun enwiki-search-region(begin end)
  (interactive "r")
  (firefox-search-region "enwiki" "http://en.wikipedia.org/wiki/%s" begin end))
(defun enwiki-template-search-region(begin end)
  (interactive "r")
  (firefox-search-region "enwiki" "http://en.wikipedia.org/wiki/Template:%s" begin end))

;; Highlight WikiLinks
;; (C) 2009 - Arkanosis

(defun highlight-wikilinks()
  (interactive)
  (highlight-regexp "\\[\\[[^]]+]]" 'hi-green-b))
(defun unhighlight-wikilinks()
  (interactive)
  (unhighlight-regexp "\\[\\[[^]]+]]"))

;; Switch between headers and sources
;; (C) 2009 - Arkanosis

(defun switch-or-open(filename)
  (let ((buff (get-file-buffer filename)))
    (if buff
	(switch-to-buffer buff)
        (if (file-exists-p filename)
	    (find-file filename)
	    nil))))
(defun switch-or-open-corresponding(ext)
  (switch-or-open
    (concat
     (file-name-sans-extension
      (buffer-file-name))
     ext)))
(defun switch-or-open-header()
  (interactive)
  (switch-or-open-corresponding ".h")
  (switch-or-open-corresponding ".hpp"))
(defun switch-or-open-inline()
  (interactive)
  (switch-or-open-corresponding ".hxx"))
(defun switch-or-open-source()
  (interactive)
  (switch-or-open-corresponding ".c")
  (switch-or-open-corresponding ".cpp"))

;; Duplicate line
;; Non-custom function

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

;; Shuffle lines
;; Non-custom function

(defun shuffle-lines (beg end)
  "Scramble all the lines in region defined by BEG END
If region contains less than 2 lines, lines are left untouched."
  (interactive "*r")
  (catch 'cancel
    (save-restriction
      (narrow-to-region beg end)
      ;;   Exit when there is not enough lines in region
      (if (< (- (point-max) (point-min)) 3)
	  (throw 'cancel t))

      ;;    Prefix lines with a random number and a space
      (goto-char (point-min))
      (while (not (eobp))
        (insert (int-to-string (random 32000)) " ")
        (forward-line 1))

      ;;  Sort lines according to first field (random number)
      (sort-numeric-fields 1 (point-min) (point-max))

      (goto-char (point-min))		;Remove the prefix fields
      (while (not (eobp))
        (delete-region (point) (progn (forward-word 1) (+ (point) 1)))
        (forward-line 1))
      )))

;; Reverse string
;; Non-custom function

(defun reverse-string (beg end)
  (interactive "r")
  (let ((string (buffer-substring beg end)))
    (delete-region beg end)
    (insert (apply 'string (reverse (string-to-list string))))))

;; Directory bookmarks
;; (C) 2011 - Arkanosis

(defconst *svn* "/ng/src/jroquet/svn/")

(defun svnpath (path)
  (concat *svn* path))

(defconst *bookmarks*
  (list (cons "edk" (svnpath "edk/edk/trunk"))
        (cons "index6" (svnpath "platform/index6/trunk"))
        (cons "semantic" (svnpath "platform/semantic/trunk"))))

(setq org-agenda-files '("~/Documents/Org"))

(setq org-agenda-start-day "-2d")
(setq org-agenda-span 15)
(setq org-agenda-start-on-weekday nil)

;; Archive whole org-mode file at once
(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'file))

(defun org-archive-all-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   t 'file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'use-package)

(use-package diminish)

(use-package fiplr
  :config
  (setq fiplr-root-markers '(".git" ".svn"))
  (setq fiplr-ignored-globs '(
    (directories (".git" ".svn" "bin" "generated" "python-cache" "scripts"))
    (files ("*.class" "*.bak" "*.pyc" "*.log"))))
  (global-set-key (kbd "C-x f") 'fiplr-find-file))

(use-package linum
  :config
  (global-linum-mode t)
  (use-package linum-highlight-current-line-number)
  (setq linum-format 'linum-highlight-current-line-number)
  (add-hook 'prog-mode-hook
    (lambda ()
      (if
        (or
          (> (buffer-size) (* 5000 80))
          (> (line-number-at-pos (point-max)) 5000))
        (linum-mode -1)))))

(use-package xsel-mode
  :config
  (xsel-mode))

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode t))

(use-package urlencode)

(use-package yasnippet
  :config
  (yas-global-mode t))

(use-package mo-git-blame)

(use-package markdown-mode
  :mode "\\.md$")
(use-package js2-mode
  :config
  (use-package js2-imenu-extras)
  :mode "\\.jsm?$")
(use-package python
  :config
  (add-hook 'python-mode-hook #'abbrev-mode)
  :mode ("\\(\\(SConscript\\|SConstruct\\)\\'\\|\\.\\(py\\|def\\|esdl\\|flea\\|gexo\\|json\\)$\\)" . python-mode))
(use-package php-mode
  :mode "\\.php[0-9]?$")
(use-package lua-mode
  :mode "\\.lua$")
(use-package java-mode
  :init
  (custom-set-variables
   '(eclim-eclipse-dirs '("~/local/opt/eclipse"))
   '(eclim-executable "~/local/opt/eclipse/eclim"))
  (use-package eclim)
  (use-package company)
  (use-package company-emacs-eclim)
  (add-hook 'java-mode-hook (lambda ()
    (company-emacs-eclim-setup)
    (eclim-mode t)
    (company-mode t)
    (define-key java-mode-map (kbd "M-.") #'eclim-java-find-declaration)))
  (add-to-list 'compilation-error-regexp-alist 'maven)
  (add-to-list
   'compilation-error-regexp-alist-alist
   '(maven
     "\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].\*" 1 2 3))
  :mode "\\.\\(java\\|jj\\)$")
(use-package rust-mode
  :config
  (use-package company)
  (use-package s)
  (use-package f)
  (use-package dash)
  (use-package racer)
  (add-hook 'rust-mode-hook #'abbrev-mode)
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t)
  :mode "\\.rs$")
(use-package csharp-mode
  :config
  (use-package flymake)
  :mode "\\.cs$")
(use-package xml-mode
  :mode "\\.\\(xsd\\|xul\\)$")
(use-package yaml-mode
  :mode "\\.\\(sls\\|yml\\|yaml\\)$")
(use-package toml-mode
  :mode "\\.\\(toml\\|tml\\)$")
(use-package hexl-mode
  :mode "\\.bin$")
(use-package ellql-mode
  :mode "\\.ellql$")
(use-package svn-commit-hooks
  :config
  (svn-commit-hooks)
  (add-hook 'write-file-hooks 'exa-check-svn-commit-msg)
  (add-hook 'write-file-hooks 'exa-check-svn-commit-branch)
  :mode "\\.tmp$")
(use-package two-mode-mode)

(use-package auto-complete-config
  :diminish auto-complete-mode
  :config
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  (ac-config-default))

(use-package rtags
  :config
  (global-set-key  [(meta v)] 'rtags-find-symbol-at-point)
  (global-set-key  [(meta V)] 'rtags-location-stack-back))

(use-package mediawiki
  :config
  (custom-set-variables
    '(mediawiki-site-alist
      (quote
        (("ACU" "http://arkanosis.fr/acu/" "Jérémie Roquet" "" "Blog commun")
         ("ACU-wip" "http://arkanosis.fr/acu/" "Jérémie Roquet" "" "Rtfb/Lesser known C++ constructs")
	 ("Wikipedia-Arkanosis" "http://fr.wikipedia.org/w/" "Arkanosis" "" "Wikipédia:Accueil principal")
	 ("Wikipedia-Arktest" "http://fr.wikipedia.org/w/" "Arktest" "" "Wikipédia:Accueil principal")
	 ("Wikipedia-Arkbot" "http://fr.wikipedia.org/w/" "Arkbot" "" "Wikipédia:Accueil principal")))))
  (defun mw()
    (interactive)
    (mediawiki-site))
  :mode ("\\(\\.wiki\\|itsalltext.*\\.txt\\)$" . mediawiki-mode))

(use-package exa-mode
  :config
  (defun my-exa-hook ()
    (setq indent-tabs-mode nil)
    (setq compilation-error-regexp-alist
      (append
        compilation-error-regexp-alist
	(list (list "\"\\([^\"]*\\)\":\\([0-9]+\\)" 1 2))))
    (setq compilation-error-regexp-alist
      (append
        compilation-error-regexp-alist
	(list '("[a-z0-9/]+: \\([eE]rror\\|[wW]arning\\|Info\\): \\([^,\" \n\t]+\\)[,:] \\(line \\)?\\([0-9]+\\):" 2 4)))))
  (add-hook 'exa-mode-hook 'my-exa-hook)
  :mode "\\.exa$")

(use-package pyjab
  :config
  (define-key global-map "\C-cns" 'pyjab_send))

(use-package ansi-color
  :config
  (ansi-color-for-comint-mode-on)
  (defun xterm-mode()
    (interactive)
    (ansi-color-apply-on-region (point-min) (point-max)))
  :mode ("\\.log$" . xterm-mode))

(use-package workspaces)
(use-package scroll-all)
(use-package longlines)
(use-package highlight-symbol
  :diminish highlight-symbol-mode
  :config
  (add-hook 'prog-mode-hook 'highlight-symbol-mode)
  (setq highlight-symbol-idle-delay 0.5))

(use-package ws-butler
  :diminish ws-butler-mode
  :config
  (ws-butler-global-mode t))

(add-hook 'prog-mode-hook (lambda ()
  (highlight-regexp "\\(TODO\\|FIXME\\|HACK\\)" 'hi-red-b)))

(add-hook 'c-mode-common-hook 'subword-mode)
(add-hook 'c-mode-common-hook 'cwarn-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-key function-key-map "\eOA" [up])
(define-key function-key-map "\e[A" [up])
(define-key function-key-map "\eOB" [down])
(define-key function-key-map "\e[B" [down])
(define-key function-key-map "\eOC" [right])
(define-key function-key-map "\e[C" [right])
(define-key function-key-map "\eOD" [left])
(define-key function-key-map "\e[D" [left])

(global-set-key "[1;2S"  'execute-extended-command)

(global-set-key [f2]  'scroll-all-mode)
(global-set-key [f3]  'find-file-at-point)
(global-set-key [f4]  'hs-toggle-hiding)

(global-set-key [f5]  'shrink-window)
(global-set-key [f6]  'enlarge-window)
(global-set-key [f7]  'shrink-window-horizontally)
(global-set-key [f8]  'enlarge-window-horizontally)

(global-set-key [f9]  'compile)
(global-set-key [f10] 'recompile)
(global-set-key [f11] 'previous-error)
(global-set-key [f12] 'next-error)

(global-set-key [(control f10)] 'kill-compilation)
(global-set-key [(control f12)] 'previous-error)

(global-set-key "[34~" 'kill-compilation)

(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\C-c\C-v" 'uncomment-region)
(global-set-key "\M- " 'hippie-expand)

(global-set-key "" 'backward-delete-char)
(global-set-key "" 'goto-line)
(global-set-key "[7~" 'beginning-of-line)
(global-set-key "[8~" 'end-of-line)

(global-set-key (kbd "C-c d") 'duplicate-line)
(global-set-key (kbd "C-c b") 'kill-whole-line)

(global-set-key (kbd "C-x c") 'revert-buffer)

(global-set-key [(meta g)] 'goto-line)

(global-set-key [(control space)] 'dabbrev-expand)
(global-set-key [(meta \;)] 'expand-abbrev)

(global-set-key [(meta r)] 'replace-string)

(global-set-key [(control tab)] 'other-window)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "ESC <left>") 'windmove-left)
(global-set-key (kbd "ESC <right>") 'windmove-right)
(global-set-key (kbd "ESC <up>") 'windmove-up)
(global-set-key (kbd "ESC <down>") 'windmove-down)
(global-set-key (kbd "\e[1;3D") 'windmove-left)
(global-set-key (kbd "\e[1;3C") 'windmove-right)
(global-set-key (kbd "\e[1;3A") 'windmove-up)
(global-set-key (kbd "\e[1;3B") 'windmove-down)
(global-set-key (kbd "C-x v") 'workspace-goto)

(global-set-key [(meta h)] 'switch-or-open-header)
(global-set-key [(meta i)] 'switch-or-open-inline)
(global-set-key [(meta o)] 'switch-or-open-source)

(global-set-key [(control f9)] 'highlight-symbol-at-point)
(global-set-key [(control f11)] 'highlight-symbol-prev)
(global-set-key [(control f12)] 'highlight-symbol-next)

;; Deal with org-mode conflicts
(setq org-replace-disputed-keys t)

(add-hook 'org-mode-hook
  (lambda ()
    (local-set-key "[1;5D" 'org-promote-subtree)
    (local-set-key "[1;5C" 'org-demote-subtree)
    (local-set-key "[1;5A" 'org-move-subtree-up)
    (local-set-key "[1;5B" 'org-move-subtree-down)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Abbrev
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'expand-abbrev-hook "expand")
(setq abbrev-file-name "~/.emacs.d/lisp/abbrev.el")
(read-abbrev-file abbrev-file-name t)
(setq dabbrev-case-replace nil)
(setq abbrev-mode t)
(diminish 'abbrev-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hooks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'emacs-startup-hook 'delete-other-windows) ;; Ras le bol de cet écran splitté au démarrage

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun terminal-init-screen-256color ()
  (load "term/xterm")
  (if (version< emacs-version "25")
    (xterm-register-default-colors)
    (xterm-register-default-colors xterm-standard-colors))
  (tty-set-up-initial-frame-faces))

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*"))

(setq confirm-nonexistent-file-or-buffer nil)

(setq split-width-threshold nil)

(setq undo-limit 200000)
(setq undo-strong-limit 300000)

;(setq compile-command "g++ -Wall -Wextra -std=c++98 -pedantic -Wabi *.cc *.cpp *.cxx")
(setq compile-command "engscons -d -t benchmark")

(winner-mode t)

(blink-cursor-mode t)
(delete-selection-mode t) ;; Efface la selection a la saisie
(global-font-lock-mode t)
(icomplete-mode t) ;; Auto completion des commandes

(defun host-name ()
  "Returns the name of the current host minus the domain."
  (let ((hostname (downcase (system-name))))
    (save-match-data
      (substring hostname (string-match "^[^.]+" hostname) (match-end 0)))))

(if
 (string-equal (host-name) "reddev014")
 nil
 (progn
   (ido-mode t)
   (setq ido-auto-merge-work-directories-length nil)
   (setq ido-save-directory-list-file "~/.zcache/ido-last")
   (add-hook 'ido-setup-hook
   	     (lambda ()
   	       (define-key ido-completion-map
   		 (kbd "C-c e")
   		 "data")))
 )
)

(setq-default message-log-max nil)
(kill-buffer "*Messages*")

(defun kill-useless-buffers ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'kill-useless-buffers)

(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Ido Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

(menu-bar-mode -1)
(normal-erase-is-backspace-mode 0)
(show-paren-mode t)
(tool-bar-mode nil)
(transient-mark-mode t)

(which-func-mode t)

(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(fset 'yes-or-no-p 'y-or-n-p)

(setq column-number-mode t)
(setq compilation-scroll-output t)
(setq compilation-window-height 10)
(setq font-lock-maximum-decoration t)
(setq frame-title-format "%b") ;; Nom du buffer
(setq inhibit-startup-message t)
(setq line-number-mode t)
(setq locale-coding-system 'utf-8)
(setq make-backup-files nil)
(setq next-line-add-newlines nil)
(setq scroll-step 1) ;; Ne descend que d'une ligne lorsau'on arrive en bas de l'ecran
(setq visible-bell t)
(setq-default gdb-many-windows t)
(setq-default vc-follow-symlinks t)

(custom-set-variables '(fill-column 78))

(c-set-offset 'case-label '+)
;(c-set-offset 'inclass '++)
(c-set-offset 'inclass '+)
(c-set-offset 'brace-list-open '0)
(c-set-offset 'statement-case-open '0)
(c-set-offset 'substatement-open '0)
(c-set-offset 'block-open '0)
(c-set-offset 'catch-clause '0)

;(server-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exalead specifics
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ht()
  (interactive)
  (highlight-regexp "VlHMM: Next: token is '.+', [0-9]+ path(es) left" 'hi-red-b)
  (highlight-regexp "VlHMM: Order: >> switching to order [0-9+]" 'hi-green-b)
  (highlight-regexp "nextProbability of [01]\\(\\.[0-9]+\\)? was [01]\\(\\.[0-9]+\\)? \\* [01]\\(\\.[0-9]+\\)? \\* [01]\\(\\.[0-9]+\\)?" 'hi-blue-b)
  (highlight-regexp "fetching for state [0-9]+" 'linum)
  (highlight-regexp "looking for [a-z]+ in context '.+" 'font-lock-keyword-face)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MediaWiki specifics
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst mw-style
  '((c-offsets-alist . ((case-label . +)
                        (arglist-close . 0)
                        (cpp-macro . (lambda(x) (cdr x)))
                        (comment-intro . 0)))
    (c-hanging-braces-alist
      (defun-open after)
       (block-open after)
        (defun-close))))

(c-add-style "MediaWiki" mw-style)

(define-minor-mode mw-mode
  "tweak style for mediawiki"
  nil " MW" nil
  (if mw-mode
      (progn
        (setq indent-tabs-mode t)
        (setq tab-width 4 c-basic-offset 4)
        (c-set-style "MediaWiki"))
    (kill-local-variable 'tab-width)
    (kill-local-variable 'c-basic-offset)))

(add-hook 'php-mode-hook (lambda () (mw-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Couleurs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; TODO use variables

(custom-set-faces
 ; Comments
; '(font-lock-comment-face ((t (:foreground "Firebrick"))))
)

(defun my-change-window-divider ()
  (let ((display-table
    (or
      buffer-display-table
      standard-display-table
      (setq standard-display-table (make-display-table)))))
    (set-display-table-slot display-table 5 ?│)
    (set-window-display-table (selected-window) display-table)))

(add-hook 'window-configuration-change-hook 'my-change-window-divider)

(set-face-background 'vertical-border "black")
(set-face-foreground 'vertical-border "dim gray")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Old stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(global-set-key "\C-i" 'self-insert-command)

(fset 'auto_arrayelts
   "\C-a\C-[f\C-[bstd::string((const char*(\C-?) ArrayElts(\C-@\C-e\C-[w), ArrayLength(\C-y(\C-?0\C-?))")
(global-set-key "\C-cjo" 'auto_arrayelts)

(fset 'auto_brac
   " {\C-m}\C-i\C-[OA\C-e")
(global-set-key "\M-p" 'auto_brac)

(fset 'auto_par
   "()\C-[OD")
(global-set-key "\M-]" 'auto_par)

(fset 'auto_quo
   "\"\"\C-[OD")
(global-set-key "\M-'" 'auto_quo)

(fset 'auto_brac_colon
   " {\C-mpublic:\C-j\C-jprivate:\C-j};\C-i\C-[OA\C-[OA\C-i")
;;(global-set-key "\M-o" 'auto_brac_colon)

(fset 'auto_std
   "std::")
(global-set-key "\M-s" 'auto_std)

(fset 'auto_cc
   " << ")
(global-set-key "\M-q" 'auto_cc)

;; ns_who
;; (C) 2007 - Arkanosis

(defun ns_who()
  (interactive)
  (setq
   login
   (read-string "ns_who " "" nil "" nil))
  (princ
   (shell-command-to-string
    (format
     "ns_who | grep %s | sed 's/@/  @ /' | sed 's/ *$//'"
     login
     login))))

;; ns_send
;; (C) 2007 - Arkanosis

(defun ns_send()
  (interactive)
  (setq
   login
   (read-string "ns_send " "" nil "" nil))
  (princ
   (shell-command-to-string
    (format
     "ns_send_msg %s %s"
     login
     (buffer-substring
      (point)
      (point+2))))))

;; Auto-class
;; (C) 2007 - Arkanosis

(defun make-class()
  (interactive)
  (forward-char 7)
  (unless (word-search-backward "class " nil t)
    (backward-char 7)
    (error "Not in a class"))
  (forward-word 1)
  (forward-char 1)

  ;;  (backward-word 1)
;;    (search-forward "class ")
  (when buffer-file-name
    (save-excursion
      (let ((fname (file-name-nondirectory buffer-file-name)))
	(while (string-match "\\.hh" fname)
	  (setq fname (replace-match ".cc" nil nil fname)))
	(if (y-or-n-p "Implement the class? ")
	    (with-temp-file fname


	      (princ "Done")
	      )
	  (error "Aborted"))
	)))
)

; (defun put-header()
;   (interactive)
;   (when buffer-file-name
;     (save-excursion
;       (goto-char (point-min))
;       (while (looking-at "[/*][/*]")
;        (forward-line 1))
;       (unless (looking-at "#ifndef")
;        (let ((fname (upcase (file-name-nondirectory buffer-file-name))))
;          (while (string-match "\\." fname)
;            (setq fname (replace-match "_" nil nil fname)))
;          (insert "#ifndef " fname "_
;"
;                  "# define " fname "_
;
;")
;          (goto-char (point-max))
;          (insert "
;#endif /* !" fname "_ */
;"))))))

;;(define-key global-map "\C-cjjh" 'put-header)
;(global-set-key [f10] 'put-header)


;   (when buffer-file-name
;     (save-excursion
;
;       (unless (looking-at "#include")
;        (let ((fname (file-name-nondirectory buffer-file-name)))
;          (while (string-match "\\.c" fname)
;            (setq fname (replace-match ".h" nil nil fname)))
;          (insert "\n#include \"" fname "\"
;")))))

;(define-key global-map "\C-cjji" 'put-include)
;(global-set-key [f9] 'put-include)


;(defun rec-lines (count)
;  (forward-line count)
;  (when (not (= (char-after) (if (= count 1) ?} ?{)))
;    (rec-lines count)
;    )
;  (point)
;  )
;(defun lines ()
;  "Count number of lines of a C function"
;  (interactive)
;  (let ((old-pt (point))
;        (pt1 (rec-lines 1))
;        (pt2 (rec-lines -1)))
;    (goto-char old-pt)
;    (message (format "Lines : %d" (1- (count-lines pt1 pt2))))
;    )
;  )
;;  (when buffer-file-name
;;    (save-excursion
;;      (goto-char (point-min))
;;      (while (looking-at "[/*][/*]")
;;        (forward-line 1))
;;      (unless (looking-at "#ifndef")
;;        (let ((fname (upcase (file-name-nondirectory buffer-file-name))))
;;          (while (string-match "\\." fname)
;;            (setq fname (replace-match "_" nil nil fname)))
;;  ;        (insert "#ifndef " fname "_
;;"
;;                  "# define " fname "_
;;
;;")
;;          (goto-char (point-max))
;;          (insert "
;;#endif /* !" fname "_ */
;;"))))))

(define-key global-map "\C-cjm" 'make-class)

;; Macros
;; (C) 2007 - Arkanosis

(fset 'auto_location
   "\C-[w</ENAMEX>\C-x\C-x\C-[w</\C-?ENAMEX TYPE=\"LOCATION\">")
(define-key global-map "\C-xrel" 'auto_location)
(fset 'auto_organization
   "\C-[w</ENAMEX>\C-x\C-x\C-[w</\C-?ENAMEX TYPE=\"ORGANIZATION\">")
(define-key global-map "\C-xreo" 'auto_organization)
(fset 'auto_person
   "\C-[w</ENAMEX>\C-x\C-x\C-[w</\C-?ENAMEX TYPE=\"PERSON\">")
(define-key global-map "\C-xrep" 'auto_person)

(fset 'auto_ife
   "if ()\C-m{\C-m\C-m}\C-melse\C-m{\C-m\C-m}\C-[OA\C-[OA\C-[OA\C-[OA\C-[OA\C-[OA\C-[OA\C-[OF\C-[OD")
(define-key global-map "\C-cje" 'auto_ife)

(fset 'auto_if
   "\C-iif () {\C-m\C-m}\C-[OA\C-[OA\C-[OC\C-[OC\C-[OC")

;; (fset 'auto_if
;;    "if ()\C-m{\C-m\C-m}\C-[OA\C-[OA\C-[OA\C-[OF\C-[OD")
(define-key global-map "\C-cji" 'auto_if)

(fset 'auto_ife
   "if ()\C-m{\C-m\C-m}\C-melse\C-m{\C-m\C-m}\C-[OA\C-[OA\C-[OA\C-[OA\C-[OA\C-[OA\C-[OA\C-[OF\C-[OD")
(define-key global-map "\C-cje" 'auto_ife)

(fset 'auto_for
   "for (; ; )\C-m{\C-m\C-m}\C-[OA\C-[OA\C-[OA\C-[OC\C-[OC\C-[OC\C-[OC")
(define-key global-map "\C-cjf" 'auto_for)

(fset 'auto_fi
   "\C-ifor (int i = 0; i < ; ++i)\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD")
(define-key global-map "\C-cjgi" 'auto_fi)

(fset 'auto_fj
   "\C-ifor (int j = 0; j < ; ++j)\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD")
(define-key global-map "\C-cjgj" 'auto_fj)

(fset 'auto_fk
   "\C-ifor (int k = 0; k < ; ++k)\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD")
(define-key global-map "\C-cjgk" 'auto_fk)

(fset 'auto_fl
   "\C-ifor (int l = 0; l < ; ++l)\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD")
(define-key global-map "\C-cjgl" 'auto_fl)

(fset 'auto_fori
   "for (int i = 0; i < ; ++i)\C-m{\C-m\C-m}\C-[OA\C-[OA\C-[OA\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OD\C-[OD")
(define-key global-map "\C-cjri" 'auto_fori)

(fset 'auto_forj
   "for (int j = 0; j < ; ++j)\C-m{\C-m\C-m}\C-[OA\C-[OA\C-[OA\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OD\C-[OD")
(define-key global-map "\C-cjrj" 'auto_forj)

(fset 'auto_fork
   "for (int k = 0; k < ; ++k)\C-m{\C-m\C-m}\C-[OA\C-[OA\C-[OA\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OD\C-[OD")
(define-key global-map "\C-cjrk" 'auto_fork)

(fset 'auto_forl
   "for (int l = 0; l < ; ++l)\C-m{\C-m\C-m}\C-[OA\C-[OA\C-[OA\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OD\C-[OD")
(define-key global-map "\C-cjrl" 'auto_forl)

(fset 'auto_forri
   "\C-ifor (register int i = 0; i < ; ++i)\C-m{\C-m\C-m}\C-[OA\C-[OA\C-[OA\C-[OF\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD")
(define-key global-map "\C-cjrri" 'auto_forri)

(fset 'auto_hack
   "/* HACK */\C-[OH\C-i\C-[OF\C-m\C-i")
(define-key global-map "\C-cjh" 'auto_hack)

(fset 'auto_todo "\C-i// TODO ")
;; (fset 'auto_todo "/* TODO */\C-[OH\C-i\C-[OF")
(define-key global-map "\C-cjt" 'auto_todo)

(fset 'auto_include
   "#include \".hh\"\C-[OD\C-[OD\C-[OD\C-[OD")
(define-key global-map "\C-cju" 'auto_include)

(fset 'auto_std_hdr
   "#include <>\C-[OD")
(define-key global-map "\C-cjs" 'auto_std_hdr)

(fset 'auto_null
   "return NULL;")
(define-key global-map "\C-cjn" 'auto_null)

(fset 'auto_class
   "class \C-m{\C-mpublic:\C-m\C-mprivate:\C-m\C-m};\C-[OA\C-[OA\C-[OA\C-[OA\C-[OA\C-[OA\C-[OF")
(define-key global-map "\C-cjc" 'auto_class)

(fset 'auto_class2
   "\C-@\C-[OH\C-wclass \C-y\C-m{\C-mpublic:\C-m\C-y ();\C-m~\C-y ();\C-m\C-mprotected:\C-m\C-mprivate:\C-m\C-m};\C-[OA\C-[OA\C-[OA\C-[OA\C-[OA\C-m\C-m\C-[OA\C-i")
(define-key global-map "\C-cjp" 'auto_class2)

(fset 'auto_src1
   "\C-y\C-?\C-?\C-x\C-x\C-@\C-[OF\C-@::\C-[OH\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-@\C-[OF\C-w\C-[OH\C-@\C-[OB\C-[OB\C-[OF\C-[[3~\C-[[3~\C-[[3~\C-[[3~\C-[[3~\C-[[3~\C-y\C-[OB\C-[OH\C-[[3~\C-[[3~\C-[[3~\C-[[3~\C-y\C-[OB\C-[OH\C-[OB\C-[[3~\C-[[3~\C-[[3~\C-[[3~\C-[OB\C-[[3~\C-[[3~\C-[[3~\C-[[3~\C-[OB\C-[[3~\C-[[3~\C-[[3~\C-[[3~\C-[OB\C-[[3~\C-[[3~\C-[[3~\C-[[3~\C-[OB\C-[[3~\C-[[3~\C-[[3~\C-[[3~")
(define-key global-map "\C-cja" 'auto_src1)

(fset 'auto_expand
   "\C-[OH\C-[[3~\C-[[3~\C-[[3~\C-[[3~\C-[\C-f\C-[OC\C-m\C-y\C-[[3~\C-[\C-f\C-[OF\C-?\C-m{\C-m\C-m}\C-m")
(define-key global-map "\C-cjx" 'auto_expand)

;; End of (C)


 (defun put-header()
   (interactive)
   (when buffer-file-name
     (save-excursion
       (goto-char (point-min))
       (while (looking-at "[/*][/*]")
        (forward-line 1))
       (unless (looking-at "#ifndef")
        (let ((fname (upcase (file-name-nondirectory buffer-file-name))))
          (while (string-match "\\." fname)
            (setq fname (replace-match "_" nil nil fname)))
          (while (string-match "-" fname)
            (setq fname (replace-match "_" nil nil fname)))
          (insert "#ifndef " fname "_
"
                  "# define " fname "_

")
          (goto-char (point-max))
          (insert "
#endif /* !" fname "_ */
"))))))

(define-key global-map "\C-cjjh" 'put-header)
;(global-set-key [f10] 'put-header)

 (defun put-include()
   (interactive)
   (when buffer-file-name
     (save-excursion
       (goto-char (point-min))
       (while (looking-at "[/*][/*]")
        (forward-line 1))
       (unless (looking-at "#include")
        (let ((fname (file-name-nondirectory buffer-file-name)))
          (while (string-match "\\.c" fname)
            (setq fname (replace-match ".h" nil nil fname)))
          (insert "\n#include \"" fname "\"
"))))))

(define-key global-map "\C-cjji" 'put-include)
;(global-set-key [f9] 'put-include)


(defun rec-lines (count)
  (forward-line count)
  (when (not (= (char-after) (if (= count 1) ?} ?{)))
    (rec-lines count)
    )
  (point)
  )
(defun lines ()
  "Count number of lines of a C function"
  (interactive)
  (let ((old-pt (point))
        (pt1 (rec-lines 1))
        (pt2 (rec-lines -1)))
    (goto-char old-pt)
    (message (format "Lines : %d" (1- (count-lines pt1 pt2))))
    )
  )
(global-set-key "\C-ccc" 'lines)

;; Retour apres ";", "{" ou "}"
;;(setq c-auto-newline t)

;; TODO super, mais ajouter d'abord delete traling whitespaces a la sauvegarde
;;(global-set-key [kp-enter] 'newline-and-indent)

;; (speedbar t)

;; (c-set-offset 'access-label '+)

;;(auto-save-mode nil)


;(setq load-path (nconc '( "~/scame_gifnoc/") load-path))

;; (require 'doxymacs)
;; (add-hook 'c-mode-common-hook 'doxymacs-mode)
;; (setq doxymacs-doxygen-style "JavaDoc")
;; (defun my-doxymacs-font-lock-hook ()
;;      (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;;          (doxymacs-font-lock)))
;;    (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

; Better compile-command
; TODO Customize this :

;; (require 'compile)
;; (add-hook 'c-mode-hook
;; 	  (lambda ()
;; 	    (unless (file-exists-p "Makefile")
;; 	      (set (make-local-variable 'compile-command)
;; 		   (let ((file (file-name-nondirectory buffer-file-name)))
;; 		     (format "%s -c -o %s.o %s %s %s"
;; 			     (or (getenv "CC") "gcc")
;; 			     (file-name-sans-extension file)
;; 			     (or (getenv "CPPFLAGS") "-DDEBUG=9")
;; 			     (or (getenv "CFLAGS") "-ansi -pedantic -Wall -g")
;; 			     file))))))


(defun oa()
  (interactive)
  (highlight-regexp "CrossChecker" 'hi-red-b)
  (highlight-regexp "orange" 'hi-green-b)
  (highlight-regexp "HMMBuilder" 'hi-blue-b))












;;     (setq-default tab-width 1) ; or any other preferred value
;;     (defvaralias 'c-basic-offset 'tab-width)
;;     (setq-default indent-tabs-mode nil)

;; (defadvice c-indent-region (around intelligent-tabs (start end) activate)
;;   (let ((indent-region-function nil))
;;     (indent-region start end)))

;; (defadvice c-indent-line (before intelligent-tabs activate)
;;   (save-excursion
;;     (beginning-of-line)
;;     (when (looking-at "\t*[ ]+\t*")
;;       (just-one-space 0))))

;; (defadvice c-shift-line-indentation (around intelligent-tabs activate)
;;   (let ((indent-tabs-mode t))
;;     ad-do-it))

;; (defun c-reindent-intelligently ()
;;   (let* ((indentation (current-indentation))
;;          (context (car c-syntactic-context))
;;          (type (car context))
;;          (base (c-langelem-pos context))
;;          (old-column (current-column)))
;;     (and (memq type c-continuation-contexts-list)
;;          (setq base (save-excursion
;;                       (goto-char base)
;;                       (buffer-substring
;;                        (progn (beginning-of-line) (point))
;;                        (progn (back-to-indentation) (point)))))
;;          (let ((indent-tabs-mode nil))
;;            (beginning-of-line)
;;            (just-one-space 0)
;;            (insert base)
;;            (indent-to indentation)
;;            (move-to-column old-column)))))

;; (defvar c-continuation-contexts-list
;;   '(arglist-close
;;     arglist-cont
;;     arglist-cont-nonempty
;;     brace-entry-open
;;     brace-list-entry
;;     c
;;     comment-intro
;;     func-decl-cont
;;     inher-cont
;;     member-init-cont
;;     objc-method-args-cont
;;     objc-method-call-cont
;;     statement
;;     statement-cont
;;     stream-op
;;     string
;;     template-args-cont
;;     topmost-intro-cont)
;;   "List of syntactic contexts of continuation lines.")

;; (setq-default c-syntactic-indentation t)
;; (add-hook 'c-special-indent-hook 'c-reindent-intelligently)

(put 'narrow-to-region 'disabled nil)

;; Réactivation du gc après le chargement de la conf
(setq gc-cons-threshold 800000)


(defun nxml-where ()
  "Display the hierarchy of XML elements the point is on as a path."
  (interactive)
  (let ((path nil))
    (save-excursion
      (save-restriction
	(widen)
	(while (and (< (point-min) (point)) ;; Doesn't error if point is at beginning of buffer
		    (condition-case nil
			(progn
			  (nxml-backward-up-element) ; always returns nil
			  t)
		      (error nil)))
	  (setq path (cons (xmltok-start-tag-local-name) path)))
	(if (called-interactively-p t)
	    (message "/%s" (mapconcat 'identity path "/"))
	  (format "/%s" (mapconcat 'identity path "/")))))))

(add-hook 'which-func-functions 'nxml-where)
