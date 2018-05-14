;;; pyjab.el --- control purple-powered IM clients from emacs using pyjab

;; Copyright (C) 2011 - Jérémie Roquet

;; Author: Jérémie Roquet <jroquet@arkanosis.net>
;; Maintainer: Jérémie Roquet <jroquet@arkanosis.net>
;; Version: 0.1
;; Keywords: purple jabber client chat
;; URL: http://github.com/Arkanosis/pyjab

(defun pyjab_send()
  (interactive)
  (let (recipients)
    (mapc
      (lambda (recipient)
	(push recipient recipients))
      (split-string
        (shell-command-to-string "pyjab \\*")
	","))
    (princ
      (shell-command-to-string
        (format
 	  "pyjab %s \"%s\""
	  (ido-completing-read "recipient: " recipients)
	  (if
	    mark-active
	    (buffer-substring
	      (region-beginning)
	      (region-end))
	    (read-string "message: " "" nil "" nil)))))))

(provide 'pyjab)

;;; pyjab.el ends here
