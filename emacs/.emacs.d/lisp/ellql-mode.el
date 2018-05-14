;;; ellql_mode.el --- Provide syntaxical highlight on ELLQL queries

;; Copyright (C) 2011  Guillaume Sadegh

;; Author: Guillaume Sadegh <gsadegh@exalead.com>
;; Keywords: internal

;;; Code:

(defconst ellql-font-lock-keywords
  (list
   ;; '(";.*" . font-lock-comment-face)
   '("\\(%23\\|#\\)\\w+" . font-lock-keyword-face)
   '("\\([a-zA-Z0-9.]+\\)=" (1 font-lock-variable-name-face))
   '("\\<\\(BM25F?\\|NOSCORE\\|RANK\\|RANK_TFIDF\\|TFIDF\\)\\_>" . font-lock-constant-face)
   '("(\\([a-zA-Z0-9_]+\\)," (1 font-lock-function-name-face))
   )
  "Highlighting expressions for ELLQL mode")


(defun ellql-mode ()
  "Major mode for editing ELLQL queries."
  (interactive)

  (kill-all-local-variables)

  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(ellql-font-lock-keywords))

  (setq major-mode 'ellql-mode)
  (setq mode-name "ELLQL")

  (run-hooks 'ellql-mode-hook))

(provide 'ellql-mode)
;;; ellql_mode.el ends here
