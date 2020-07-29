;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Arkonf for Emacs                                                    ;
;  (C) 2006-2020 - Jérémie Roquet                                      ;
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

(package-initialize)

(setq gc-cons-threshold 100000000)

(setq standard-indent 2)
(setq tab-width 2)
(set-variable 'c-argdecl-indent 0)
(setq c-basic-offset 2)

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

;; Open links in Firefox (includes org-mode)
(setq browse-url-browser-function 'browse-url-firefox
  browse-url-new-window-flag  t
  browse-url-firefox-new-window-is-tab t)

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

(setq org-agenda-files '("~/Documents/Org" "~/Documents/Org/Notes" "~/Documents/Org/Exalead"))

(setq org-agenda-start-day "-2d")
(setq org-agenda-span 15)
(setq org-agenda-start-on-weekday nil)
(setq calendar-week-start-day 1)
(add-hook 'org-archive-hook #'org-save-all-org-buffers)

(setq org-todo-keywords
  '((sequence "TODO(t)" "STRT(s)" "|" "DONE(d)")
    (sequence "|" "ABRT(a)")))

(setq org-todo-keyword-faces
  '(("TODO" . org-todo)
    ("STRT" . "yellow")
    ("DONE" . org-done)
    ("ABRT" . "grey")))

(defun org-thunderlink-open (path)
  "Opens a specified email in Thunderbird with the help of the add-on ThunderLink."
  (start-process "myname" nil "thunderbird" "-thunderlink" (concat "thunderlink:" path)))
(add-hook 'org-mode-hook
  (lambda ()
    (org-add-link-type "thunderlink" 'org-thunderlink-open)))

(setq org-file-apps '(
  ("\\.pdf\\'" . "xdg-open \"%s\"")
  (auto-mode . emacs)))

(defun org-revert-buffers ()
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      (when (and filename
		 (string-match "\\.org" filename)
                 (not (buffer-modified-p buf)))
        (with-current-buffer buf
          (revert-buffer :ignore-auto :noconfirm :preserve-modes))))))

(defun org-show-agenda ()
  (interactive)
  (org-revert-buffers)
  (org-agenda))

(defun org-agenda-refresh ()
  (interactive)
  (org-revert-buffers)
  (org-agenda-redo))

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

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")))

(require 'use-package)

(use-package diminish)

(defun highlight-indent-guides-custom-highlight (level responsive display)
  (if (> 1 level)
      nil
    (highlight-indent-guides--highlighter-default level responsive display)))
(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (set-face-foreground 'highlight-indent-guides-character-face "#101010")
  (set-face-foreground 'highlight-indent-guides-stack-character-face "#303030")
  (set-face-foreground 'highlight-indent-guides-top-character-face "dim gray")
  (setq highlight-indent-guides-auto-enabled nil)
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-responsive 'stack)
  (setq highlight-indent-guides-highlighter-function 'highlight-indent-guides-custom-highlight))

(use-package xsel-mode
  :config
  (xsel-mode))

(use-package temove-mode)

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode t))

(use-package urlencode)

(use-package yasnippet
  :config
  (yas-global-mode t))

(use-package mo-git-blame)

(use-package git-gutter
  :config
  (global-git-gutter-mode t))

(use-package markdown-mode
  :mode "\\.md$")
(use-package js2-mode
  :config
  (use-package js2-imenu-extras)
  :mode "\\.jsm?$")
(use-package typescript-mode
  :mode "\\.tsx?$")
(use-package seq)
(setq tide-tsserver-executable
 (seq-find #'file-exists-p
  '("~/.local/opt/tsserver/tsserver.js"              ; Manual install (eg. Exalead)
    "/usr/lib/node_modules/typescript/bin/tsserver" ; ArchLinux
    "/usr/lib/nodejs/typescript/lib/tsserver.js"    ; Debian / Ubuntu (Bionic)
    "/usr/lib/nodejs/typescript/tsserver.js")))     ; Debian / Ubuntu (Xenial)
(use-package tide
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
	 (typescript-mode . tide-hl-identifier-mode)
	 (before-save . tide-format-before-save)))
(use-package python
  :config
  (add-hook 'python-mode-hook #'abbrev-mode)
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'python-mode-hook (lambda ()
    (local-set-key (kbd "M-RET") 'lsp-find-definition)))
  (require 'dap-python)
  (setq dap-auto-configure-features '(sessions locals tooltip))
  :mode ("\\(\\(SConscript\\|SConstruct\\)\\'\\|\\.\\(py\\|def\\|esdl\\|flea\\|gexo\\|json\\)$\\)" . python-mode))
(use-package php-mode
  :mode "\\.php[0-9]?$")
(use-package lua-mode
  :mode "\\.lua$")
(use-package java-mode
  :init
  (use-package company)
  (add-hook 'java-mode-hook (lambda ()
    (company-mode t)))
  (add-hook 'java-mode-hook #'lsp)
  (add-hook 'java-mode-hook (lambda ()
    (local-set-key (kbd "M-RET") 'lsp-find-definition)))
  (require 'dap-java)
  (setq dap-auto-configure-features '(sessions locals tooltip))
  (require 'compile)
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
  (add-hook 'rust-mode-hook #'abbrev-mode)
  (add-hook 'rust-mode-hook #'lsp)
  (add-hook 'rust-mode-hook (lambda ()
    (local-set-key (kbd "M-RET") 'lsp-find-definition)))
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t)
  :mode "\\.rs$")
(use-package go-mode
  :config
  (add-hook 'before-save-hook #'gofmt-before-save)
  :mode "\\.go$")
(use-package kotlin-mode
  :config
  (require 'compile)
  (add-to-list 'compilation-error-regexp-alist 'kotlin)
  (add-to-list
   'compilation-error-regexp-alist-alist
   '(kotlin
     ".*: \\(.+?\\.kt\\): (\\([0-9]+\\), \\([0-9]+\\)): .*" 1 2 3))
  :mode "\\.kt$")
(use-package csharp-mode
  :mode "\\.cs$")
(use-package csv-mode
  :config
  (global-set-key (kbd "M-F") 'csv-forward-field)
  (global-set-key (kbd "M-B") 'csv-backward-field)
  :mode "\\.\\(csv\\|tsv\\|vcf\\)$")
(use-package xml-mode
  :mode "\\.\\(xsd\\|xul\\)$")
(use-package yaml-mode
  :mode "\\.\\(sls\\|yml\\|yaml\\)$")
(use-package toml-mode
  :mode "\\.\\(toml\\|tml\\)$")
(use-package hexl-mode
  :mode "\\.bin$")
(use-package ob-sparql
  :init
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sparql . t))))
(use-package sparql-mode
  :mode "\\.sparql$")
(use-package ellql-mode
  :mode "\\.ellql$")
(use-package svn-commit-hooks
  :config
  (svn-commit-hooks)
  (add-hook 'write-file-hooks 'exa-check-svn-commit-msg)
  (add-hook 'write-file-hooks 'exa-check-svn-commit-branch)
  :mode "\\.tmp$")
(use-package two-mode-mode)
(use-package dockerfile-mode
  :mode "Dockerfile$")

(use-package auto-complete-config
  :diminish auto-complete-mode
  :config
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  (ac-config-default))

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
  (add-to-list 'auto-mode-alist '("\\.log$" . xterm-mode))
  (defun colorize-compilation-buffer ()
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max))))
  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer))

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

(use-package dtrt-indent
  :diminish dtrt-indent-mode
  :config
  (add-hook 'c-mode-common-hook 'dtrt-indent-mode))

(add-hook 'prog-mode-hook (lambda ()
  (highlight-regexp "\\(TODO\\|FIXME\\|HACK\\)" 'hi-red-b)))

(add-hook 'c-mode-common-hook 'subword-mode)
(add-hook 'c-mode-common-hook 'cwarn-mode)

(add-to-list 'auto-mode-alist '("/PKGBUILD$" . sh-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun enable-mouse-mode (&optional frame)
  (when (eq window-system nil)
    (if (not frame)
	(xterm-mouse-mode t)
      (if xterm-mouse-mode
          (xterm-mouse-mode t)))))
(enable-mouse-mode)
(add-hook 'after-make-frame-functions 'enable-mouse-mode)

(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))

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
(global-set-key "[19;5~" 'kill-compilation)
(global-set-key "[19;2~" 'kill-compilation)

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

(global-set-key (kbd "C-x f") 'recentf-open-files)
(global-set-key [(meta \\)] 'switch-to-last-buffer)

(global-set-key [(meta g)] 'goto-line)

(global-set-key [(control space)] 'dabbrev-expand)
(global-set-key [(meta \;)] 'expand-abbrev)

(global-set-key [(meta r)] 'replace-string)

(global-set-key [(meta |)] 'split-window-horizontally)
(global-set-key [(meta -)] 'split-window-vertically)

(global-set-key [(control tab)] 'other-window)
(global-set-key (kbd "M-<left>") 'temove-left)
(global-set-key (kbd "M-<right>") 'temove-right)
(global-set-key (kbd "M-<up>") 'temove-up)
(global-set-key (kbd "M-<down>") 'temove-down)
(global-set-key (kbd "ESC <left>") 'temove-left)
(global-set-key (kbd "ESC <right>") 'temove-right)
(global-set-key (kbd "ESC <up>") 'temove-up)
(global-set-key (kbd "ESC <down>") 'temove-down)
(global-set-key (kbd "\e[1;3D") 'temove-left)
(global-set-key (kbd "\e[1;3C") 'temove-right)
(global-set-key (kbd "\e[1;3A") 'temove-up)
(global-set-key (kbd "\e[1;3B") 'temove-down)
(global-set-key (kbd "C-x v") 'workspace-goto)

(global-set-key [(meta h)] 'switch-or-open-header)
(global-set-key [(meta i)] 'switch-or-open-inline)
(global-set-key [(meta o)] 'switch-or-open-source)

(global-set-key [(control f9)] 'highlight-symbol-at-point)
(global-set-key [(control f11)] 'highlight-symbol-prev)
(global-set-key [(control f12)] 'highlight-symbol-next)

(global-set-key (kbd "C-x g a") 'git-gutter:stage-hunk)
(global-set-key (kbd "C-x g m") 'git-gutter:mark-hunk)
(global-set-key (kbd "C-x g n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-x g p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x g r") 'git-gutter:revert-hunk)
(global-set-key (kbd "C-x g s") 'magit-status)

;; Deal with org-mode conflicts
(setq org-replace-disputed-keys t)

(add-hook 'org-mode-hook
  (lambda ()
    (local-set-key (kbd "C-c a") 'org-show-agenda)
    (local-set-key "[1;5D" 'org-promote-subtree)
    (local-set-key "[1;5C" 'org-demote-subtree)
    (local-set-key "[1;5A" 'org-move-subtree-up)
    (local-set-key "[1;5B" 'org-move-subtree-down)))

(add-hook 'org-agenda-mode-hook
  (lambda ()
    (local-set-key "r" 'org-agenda-refresh)))

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

(recentf-mode)

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
   (defun ido-kill-emacs-hook ()
     (lambda ()
       (if (file-writable-p ido-save-directory-list-file)
	   (ido-save-history)
 	   nil)))
   (setq ido-ignore-buffers '("\\` " "^\*"))
 )
)

(menu-bar-mode -1)
(normal-erase-is-backspace-mode 0)
(show-paren-mode t)
(tool-bar-mode nil)
(transient-mark-mode t)

(which-func-mode t)

(global-display-line-numbers-mode t)
(set-face-attribute 'line-number-current-line nil :background "#222" :foreground "goldenrod" :weight 'bold)
(set-face-attribute 'line-number nil :background "#222")

(global-hl-line-mode t)
(set-face-attribute 'hl-line nil :background "#222")

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

(setq global-magit-file-mode nil)

(custom-set-variables
 '(lsp-rust-server (quote rust-analyzer))
 '(package-selected-packages
   (quote
    (magit use-package dash dash-functional lsp-java dap-mode company flycheck lsp-mode))))

(c-set-offset 'case-label '+)
;(c-set-offset 'inclass '++)
(c-set-offset 'inclass '+)
(c-set-offset 'brace-list-open '0)
(c-set-offset 'statement-case-open '0)
(c-set-offset 'substatement-open '0)
(c-set-offset 'block-open '0)
(c-set-offset 'catch-clause '0)

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
(define-key global-map "\C-cjm" 'make-class)

;; Macros
;; (C) 2007 - Arkanosis

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

;; Réactivation du gc après le chargement de la conf
(setq gc-cons-threshold 800000)
