;;; svn-commit-hooks.el --- Check SVN commits

;; Copyright (C) 2017 Jérémie Roquet

;; Author: Jérémie Roquet <jroquet@exalead.com>
;; Keywords: internal

; Usage: add this to your .emacs:
; (require 'svn-commit-hooks)
; (add-hook 'write-file-hooks 'exa-check-svn-commit-msg)
; (add-hook 'write-file-hooks 'exa-check-svn-commit-branch)

;;; Code:

(defun svn-commit-hooks ()
  (interactive)

  (defun exa-check-svn-commit-msg ()
    (not
      (or
        (not
          (string-match ".*/svn-commit\\(\\.[0-9]+\\)?\\.tmp"
            (buffer-file-name)))
        (string-match "\\([Mm]ercury\\|[Aa]pollo\\|[Aa]pps\\)\\([Cc]lose\\(d\\|s\\)?\\|[Ff][ei]x\\(ed\\|es\\)?\\|[Aa]ddresses\\|[Rr]e\\(ferences\\|fs\\)?\\|[Ss]ee\\).?\\(#\\|\\([Tt]icket\\|[Ii]ssue\\|[Bb]ug\\)[: ]?\\)?\\([0-9]+\\)"
          (buffer-string))
        (y-or-n-p "Missing Mercury(Ref|Close)s. Commit anyway? "))))

  (defun exa-check-svn-commit-branch ()
    (not
      (or
        (not
          (string-match ".*/svn-commit\\(\\.[0-9]+\\)?\\.tmp"
            (buffer-file-name)))
        (not
          (string-match "branches"
            (buffer-file-name)))
        (y-or-n-p "Direct commit to branch (not trunk). Commit anyway? "))))

)

(provide 'svn-commit-hooks)
;;; svn-commit-hooks.el ends here
