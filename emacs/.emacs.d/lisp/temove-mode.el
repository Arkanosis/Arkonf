;;; temove-mode.el --- Move in Tmux while in Emacs

;; Copyright (C) 2020 Jérémie Roquet

;; Author: Jérémie Roquet <jroquet@arkanosis.net>
;; Keywords: temove tmux

; Usage: add this to your .emacs:
; (require 'temove-mode)

;;; Code:

(defun temove-left ()
  (interactive)
  (if (ignore-errors (windmove-left))
    nil
    (shell-command "tmux select-pane -L")))
(defun temove-right ()
  (interactive)
  (if (ignore-errors (windmove-right))
    nil
    (shell-command "tmux select-pane -R")))
(defun temove-up ()
  (interactive)
  (if (ignore-errors (windmove-up))
    nil
    (shell-command "tmux select-pane -U")))
(defun temove-down ()
  (interactive)
  (if (ignore-errors (windmove-down))
    nil
    (shell-command "tmux select-pane -D")))

(provide 'temove-mode)
;;; temove-mode.el ends here
