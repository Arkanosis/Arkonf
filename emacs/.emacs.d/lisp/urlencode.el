;;; urlencode.el --- URL percent-encoding / decoding in Emacs

;; Copyright (C) 2014-2015 Xah Lee
;; Copyright (C) 2018 Jérémie Roquet

;; Author: Jérémie Roquet <jroquet@arkanosis.net>
;; Keywords: url percent encoding

; Usage: add this to your .emacs:
; (require 'urlencode)

;;; Code:

; Original version used the long xah-html-encode-percent-encoded-url name
(defun urlencode ()
    "Percent encode URL under cursor or selection.

Example:
    http://en.wikipedia.org/wiki/Saint_Jerome_in_His_Study_(Dürer)
becomes
    http://en.wikipedia.org/wiki/Saint_Jerome_in_His_Study_(D%C3%BCrer)

Example:
    http://zh.wikipedia.org/wiki/文本编辑器
becomes
    http://zh.wikipedia.org/wiki/%E6%96%87%E6%9C%AC%E7%BC%96%E8%BE%91%E5%99%A8

URL `http://ergoemacs.org/emacs/elisp_decode_uri_percent_encoding.html'
Version 2015-09-14."
    (interactive)
    (let ($boundaries $p1 $p2 $input-str)
      (if (use-region-p)
	  (progn
	    (setq $p1 (region-beginning))
	    (setq $p2 (region-end)))
	(progn
	  (setq $boundaries (bounds-of-thing-at-point 'url))
	  (setq $p1 (car $boundaries))
	  (setq $p2 (cdr $boundaries))))
      (setq $input-str (buffer-substring-no-properties $p1 $p2))
      (require 'url-util)
      (delete-region $p1 $p2)
          (insert (url-encode-url $input-str))))

; Original version used the long xah-html-decode-percent-encoded-url name
(defun urldecode ()
    "Decode percent encoded URI of URI under cursor or selection.

Example:
    http://en.wikipedia.org/wiki/Saint_Jerome_in_His_Study_%28D%C3%BCrer%29
becomes
    http://en.wikipedia.org/wiki/Saint_Jerome_in_His_Study_(Dürer)

Example:
    http://zh.wikipedia.org/wiki/%E6%96%87%E6%9C%AC%E7%BC%96%E8%BE%91%E5%99%A8
becomes
    http://zh.wikipedia.org/wiki/文本编辑器

For string version, see `xah-html-url-percent-decode-string'.
To encode, see `xah-html-encode-percent-encoded-url'.
URL `http://ergoemacs.org/emacs/elisp_decode_uri_percent_encoding.html'
Version 2015-09-14."
    (interactive)
    (let ($boundaries $p1 $p2 $input-str)
      (if (use-region-p)
	  (progn
	    (setq $p1 (region-beginning))
	    (setq $p2 (region-end)))
	(progn
	  (setq $boundaries (bounds-of-thing-at-point 'url))
	  (setq $p1 (car $boundaries))
	  (setq $p2 (cdr $boundaries))))
      (setq $input-str (buffer-substring-no-properties $p1 $p2))
      (require 'url-util)
      (delete-region $p1 $p2)
      (insert (decode-coding-string (url-unhex-string $input-str) 'utf-8))))

(provide 'urlencode)
(provide 'urldecode)
;;; urlencode.el ends here
