;;; xsel-mode.el --- Copy to and paste from the OS clipboard

;; Copyright (C) 2018 Jérémie Roquet

;; Author: Jérémie Roquet <jroquet@arkanosis.net>
;; Keywords: xsel clipboard copy paste

; Usage: add this to your .emacs:
; (require 'xsel-mode)

;;; Code:

(defun text-to-clipboard (text)
  (let ((process-connection-type nil))
    (let ((xsel (start-process "xsel" nil "xsel" "-i" "-b")))
      (process-send-string xsel text)
      (process-send-eof xsel))))
(defun text-from-clipboard ()
  (shell-command-to-string "xsel -o -b"))

(defun xsel-mode ()
  (interactive)
  (when (getenv "DISPLAY")
    (setq interprogram-cut-function 'text-to-clipboard)
    (setq interprogram-paste-function 'text-from-clipboard))
)

(provide 'xsel-mode)
;;; xsel-mode.el ends here
