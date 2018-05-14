;;; longlines.el --- automatically wrap long lines

;; Copyright (C) 2000, 2001, 2004, 2005 Free Software Foundation, Inc.

;; Authors:    Kai Grossjohann <Kai.Grossjohann@CS.Uni-Dortmund.DE>
;;             Alex Schroeder <alex@gnu.org>
;;             Chong Yidong <cyd@stupidchicken.com>
;; Maintainer: Chong Yidong <cyd@stupidchicken.com>
;; Version: 2.3.4
;; Keywords: convenience, wp

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Some text editors save text files with long lines, and they
;; automatically break these lines at whitespace, without actually
;; inserting any newline characters.  When doing `M-q' in Emacs, you
;; are inserting newline characters.  Longlines mode provides a file
;; format which wraps the long lines when reading a file and unwraps
;; the lines when saving the file.  It can also wrap and unwrap
;; automatically as editing takes place.

;; Special thanks to Rod Smith for many useful bug reports.

;;; Installation:

;; Save longlines.el in a convenient directory, preferably in
;; your `load-path'. Add the following to your `user-init-file':
;;
;;   (autoload 'longlines-mode
;;     "longlines.el"
;;     "Minor mode for automatically wrapping long lines." t)

;;; Todo:

;; Investigate ^M characters showing up in relation to auto-save-file,
;; at least for NTEmacs.

;;; Code:

(require 'easy-mmode)

(if (featurep 'xemacs)
    (eval-and-compile
      (require 'overlay)
      (defvar fill-nobreak-predicate nil)
      (defvar undo-in-progress nil)
      (defvar longlines-mode-hook nil)
      (defvar longlines-mode-on-hook nil)
      (defvar longlines-mode-off-hook nil)
      (unless (functionp 'line-end-position)
	(defun line-end-position ()
	  (save-excursion (end-of-line) (point))))
      (unless (functionp 'line-beginning-position)
	(defun line-beginning-position (&optional n)
	  (save-excursion
	    (if n (forward-line n))
	    (beginning-of-line)
	    (point))))))

(defgroup longlines nil
  "Automatic wrapping of long lines when loading files."
  :group 'fill)

(defcustom longlines-auto-wrap t
  "*Non-nil means long lines are automatically wrapped after each command.
Otherwise, you can perform filling using `fill-paragraph' or
`auto-fill-mode'.  In any case, the soft newlines will be removed
when the file is saved to disk."
  :group 'longlines
  :type 'boolean)

(defcustom longlines-wrap-follows-window-size nil
  "*Non-nil means wrapping and filling happen at the edge of the window.
Otherwise, `fill-column' is used, regardless of the window size.  This
does not work well when the buffer is displayed in multiple windows
with differing widths."
  :group 'longlines
  :type 'boolean)

(defcustom longlines-show-hard-newlines nil
  "*Non-nil means each hard newline is marked on the screen.
\(The variable `longlines-show-effect' controls what they look like.)
You can also enable the display temporarily, using the command
`longlines-show-hard-newlines'"
  :group 'longlines
  :type 'boolean)

(defface longlines-visible-face
  '((t (:foreground "cyan")))
  "Face used to make hard newlines visible in `longlines-mode'.")

(defcustom longlines-show-effect (propertize "|" 'face 'longlines-visible-face)
  "*A string to display when showing hard newlines.
This is used when `longlines-show-hard-newlines' is on."
  :group 'longlines
  :type 'string)

;; Internal variables

(defvar longlines-wrap-beg nil)
(defvar longlines-wrap-end nil)
(defvar longlines-wrap-point nil)
(defvar longlines-showing nil)

(make-variable-buffer-local 'longlines-wrap-beg)
(make-variable-buffer-local 'longlines-wrap-end)
(make-variable-buffer-local 'longlines-wrap-point)
(make-variable-buffer-local 'longlines-showing)

;; Mode

;;;###autoload
(define-minor-mode longlines-mode
  "Toggle Long Lines mode.
In Long Lines mode, long lines are wrapped if they extend beyond
`fill-column'.  The soft newlines used for line wrapping will not
show up when the text is yanked or saved to disk.

If the variable `longlines-auto-wrap' is non-nil, lines are automatically
wrapped whenever the buffer is changed.  You can always call
`fill-paragraph' to fill individual paragraphs.

If the variable `longlines-show-hard-newlines' is non-nil, hard newlines
are indicated with a symbol."
  :group 'longlines :lighter " ll"
  (if longlines-mode
      ;; Turn on longlines mode
      (progn
        (use-hard-newlines 1 'never)
        (add-to-list 'buffer-file-format 'longlines)
        (add-hook 'change-major-mode-hook 'longlines-mode-off nil t)
	(add-hook 'before-revert-hook 'longlines-before-revert-hook nil t)
        (when longlines-wrap-follows-window-size
          (set (make-local-variable 'fill-column)
               (- (window-width) window-min-width))
          (add-hook 'window-configuration-change-hook
                    'longlines-window-change-function nil t))
        (let ((buffer-undo-list t)
              (inhibit-read-only t)
	      (after-change-functions nil)
              (mod (buffer-modified-p)))
          ;; Turning off undo is OK since (spaces + newlines) is
          ;; conserved, except for a corner case in
          ;; longlines-wrap-lines that we'll never encounter from here
	  (save-restriction
	    (widen)
	    (longlines-decode-buffer)
	    (longlines-wrap-region (point-min) (point-max)))
          (set-buffer-modified-p mod))
        (when (and longlines-show-hard-newlines
                   (not longlines-showing))
          (longlines-show-hard-newlines))
        (when longlines-auto-wrap
          (auto-fill-mode 0)
          (add-hook 'after-change-functions
                    'longlines-after-change-function nil t)
          (add-hook 'post-command-hook
                    'longlines-post-command-function nil t)))
    ;; Turn off longlines mode
    (setq buffer-file-format (delete 'longlines buffer-file-format))
    (if longlines-showing
        (longlines-unshow-hard-newlines))
    (let ((buffer-undo-list t)
	  (after-change-functions nil)
          (inhibit-read-only t))
      (save-restriction
	(widen)
	(longlines-encode-region (point-min) (point-max))))
    (remove-hook 'change-major-mode-hook 'longlines-mode-off t)
    (remove-hook 'after-change-functions 'longlines-after-change-function t)
    (remove-hook 'post-command-hook 'longlines-post-command-function t)
    (remove-hook 'before-revert-hook 'longlines-before-revert-hook t)
    (remove-hook 'window-configuration-change-hook
                 'longlines-window-change-function t)
    (when longlines-wrap-follows-window-size
      (kill-local-variable 'fill-column))
    (kill-local-variable 'use-hard-newlines)))

(defun longlines-mode-off ()
  "Turn off longlines mode.
This function exists to be called by `change-major-mode-hook' when the
major mode changes."
  (longlines-mode 0))

;; Showing the effect of hard newlines in the buffer

(defun longlines-show-hard-newlines (&optional arg)
  "Make hard newlines visible by adding a face.
With optional argument ARG, make the hard newlines invisible again
by calling `longlines-unshow-hard-newlines'."
  (interactive "P")
  (if arg
      (longlines-unshow-hard-newlines)
    (save-excursion
      (setq longlines-showing t)
      ;; We want to show every single newline.  Therefore every single
      ;; newline must get its own overlay.  No spanning of multiple
      ;; newlines with one overlay.
      (let ((pos (text-property-any (point-min) (point-max) 'hard t)))
	(while pos
	  (longlines-show-region pos (1+ pos))
	  (setq pos (text-property-any (1+ pos) (point-max) 'hard t)))))))

(defun longlines-show-region (start end)
  "Make region between START and END visible."
  (unless (let ((os (overlays-in start end))
		o exists)
	    (while (and os (not exists))
	      (setq o (car os)
		    os (cdr os))
	      (when (overlay-get o 'longlines)
		(setq exists t)))
	    exists)
    (let ((o (make-overlay start end nil t)))
      (if (consp longlines-show-effect)
	  (overlay-put o (car longlines-show-effect) (cdr longlines-show-effect))
	(overlay-put o 'before-string longlines-show-effect))
      (overlay-put o 'longlines t)
      (overlay-put o 'evaporate t))))

(defun longlines-unshow-hard-newlines ()
  "Make hard newlines invisible again."
  (interactive)
  (setq longlines-showing nil)
  (let ((os (overlays-in (point-min) (point-max)))
	o)
    (while os
      (setq o (car os)
	    os (cdr os))
      (when (overlay-get o 'longlines)
	(delete-overlay o)))))

;; Wrapping the paragraphs.

(defun longlines-wrap-region (beg end)
  "Wrap each successive line, starting with the line before BEG.
Stop when we reach lines after END that don't need wrapping, or the
end of the buffer."
  (setq longlines-wrap-point (point))
  (goto-char beg)
  (forward-line -1)
  ;; Two successful longlines-wrap-line's in a row mean successive
  ;; lines don't need wrapping.
  (while (null (and (longlines-wrap-line)
                    (or (eobp)
                        (and (>= (point) end)
                             (longlines-wrap-line))))))
  (goto-char longlines-wrap-point))

(defun longlines-wrap-line ()
  "If the current line needs to be wrapped, wrap it and return nil.
If wrapping is performed, point remains on the line.  If the line does
not need to be wrapped, move point to the next line and return t."
  (if (longlines-set-breakpoint)
      (progn (insert-before-markers ?\n)
	     (backward-char 1)
             (delete-char -1)
	     (forward-char 1)
             nil)
    (if (longlines-merge-lines-p)
        (progn (end-of-line)
     ;; After certain commands (e.g. kill-line), there may be two
     ;; successive soft newlines in the buffer.  In this case, we
     ;; replace these two newlines by a single space.  Unfortunately,
     ;; this breaks the conservation of (spaces + newlines), so we
     ;; have to fiddle with longlines-wrap-point.
	       (if (or (prog1 (bolp) (forward-char 1)) (eolp))
		   (progn
		     (delete-char -1)
		     (if (> longlines-wrap-point (point))
			 (setq longlines-wrap-point
			       (1- longlines-wrap-point))))
		 (insert-before-markers-and-inherit ?\ )
		 (backward-char 1)
		 (delete-char -1)
		 (forward-char 1))
               nil)
      (forward-line 1)
      t)))

(defun longlines-set-breakpoint ()
  "Place point where we should break the current line, and return t.
If the line should not be broken, return nil; point remains on the
line."
  (move-to-column fill-column)
  (if (and (re-search-forward "[^ ]" (line-end-position) 1)
           (> (current-column) fill-column))
      ;; This line is too long.  Can we break it?
      (or (longlines-find-break-backward)
          (progn (move-to-column fill-column)
                 (longlines-find-break-forward)))))

(defun longlines-find-break-backward ()
  "Move point backward to the first available breakpoint and return t.
If no breakpoint is found, return nil."
  (and (search-backward " " (line-beginning-position) 1)
       (save-excursion
         (skip-chars-backward " " (line-beginning-position))
         (null (bolp)))
       (progn (forward-char 1)
              (if (and fill-nobreak-predicate
                       (run-hook-with-args-until-success
                        'fill-nobreak-predicate))
                  (progn (skip-chars-backward " " (line-beginning-position))
                         (longlines-find-break-backward))
                t))))

(defun longlines-find-break-forward ()
  "Move point forward to the first available breakpoint and return t.
If no break point is found, return nil."
  (and (search-forward " " (line-end-position) 1)
       (progn (skip-chars-forward " " (line-end-position))
              (null (eolp)))
       (if (and fill-nobreak-predicate
                (run-hook-with-args-until-success
                 'fill-nobreak-predicate))
           (longlines-find-break-forward)
         t)))

(defun longlines-merge-lines-p ()
  "Return t if part of the next line can fit onto the current line.
Otherwise, return nil.  Text cannot be moved across hard newlines."
  (save-excursion
    (end-of-line)
    (and (null (eobp))
         (null (get-text-property (point) 'hard))
         (let ((space (- fill-column (current-column))))
           (forward-line 1)
           (if (eq (char-after) ? )
               t ; We can always merge some spaces
             (<= (if (search-forward " " (line-end-position) 1)
                     (current-column)
                   (1+ (current-column)))
                 space))))))

(defun longlines-decode-region (&optional beg end)
  "Turn all newlines between BEG and END into hard newlines.
If BEG and END are nil, the point and mark are used."
  (if (null beg) (setq beg (point)))
  (if (null end) (setq end (mark t)))
  (save-excursion
    (let ((reg-max (max beg end)))
      (goto-char (min beg end))
      (while (search-forward "\n" reg-max t)
	(set-hard-newline-properties
	 (match-beginning 0) (match-end 0))))))

(defun longlines-decode-buffer ()
  "Turn all newlines in the buffer into hard newlines."
  (longlines-decode-region (point-min) (point-max)))

(defun longlines-encode-region (beg end &optional buffer)
  "Replace each soft newline between BEG and END with exactly one space.
Hard newlines are left intact.  The optional argument BUFFER exists for
compatibility with `format-alist', and is ignored."
  (save-excursion
    (let ((reg-max (max beg end))
	  (mod (buffer-modified-p)))
      (goto-char (min beg end))
      (while (search-forward "\n" reg-max t)
        (unless (get-text-property (match-beginning 0) 'hard)
          (replace-match " ")))
      (set-buffer-modified-p mod)
      end)))

;; Auto wrap

(defun longlines-auto-wrap (&optional arg)
  "Turn on automatic line wrapping, and wrap the entire buffer.
With optional argument ARG, turn off line wrapping."
  (interactive "P")
  (remove-hook 'after-change-functions 'longlines-after-change-function t)
  (remove-hook 'post-command-hook 'longlines-post-command-function t)
  (if arg
      (progn (setq longlines-auto-wrap nil)
             (message "Auto wrap disabled."))
    (setq longlines-auto-wrap t)
    (add-hook 'after-change-functions
              'longlines-after-change-function nil t)
    (add-hook 'post-command-hook
              'longlines-post-command-function nil t)
    (let ((mod (buffer-modified-p)))
      (longlines-wrap-region (point-min) (point-max))
      (set-buffer-modified-p mod))
    (message "Auto wrap enabled.")))

(defun longlines-after-change-function (beg end len)
  "Update `longlines-wrap-beg' and `longlines-wrap-end'.
This is called by `after-change-functions' to keep track of the region
that has changed."
  (unless undo-in-progress
    (setq longlines-wrap-beg
          (if longlines-wrap-beg (min longlines-wrap-beg beg) beg))
    (setq longlines-wrap-end
          (if longlines-wrap-end (max longlines-wrap-end end) end))))

(defun longlines-post-command-function ()
  "Perform line wrapping on the parts of the buffer that have changed.
This is called by `post-command-hook' after each command."
  (when longlines-wrap-beg
    (cond ((or (eq this-command 'yank)
               (eq this-command 'yank-pop))
           (longlines-decode-region (point) (mark t))
           (if longlines-showing
               (longlines-show-region (point) (mark t))))
	  (longlines-showing
	   (cond ((eq this-command 'newline)
		  (save-excursion
		    (if (search-backward "\n" nil t)
			(longlines-show-region
			 (match-beginning 0) (match-end 0)))))
		 ((eq this-command 'open-line)
		  (save-excursion
		    (if (search-forward "\n" nil t)
			(longlines-show-region
			 (match-beginning 0) (match-end 0))))))))
    (unless (or (eq this-command 'fill-paragraph)
                (eq this-command 'fill-region))
      (longlines-wrap-region longlines-wrap-beg longlines-wrap-end))
    (setq longlines-wrap-beg nil)
    (setq longlines-wrap-end nil)))

(defun longlines-window-change-function ()
  "Re-wrap the buffer if the window width has changed.
This is called by `window-size-change-functions'."
  (when (/= fill-column (- (window-width) window-min-width))
    (setq fill-column (- (window-width) window-min-width))
    (let ((mod (buffer-modified-p)))
      (longlines-wrap-region (point-min) (point-max))
      (set-buffer-modified-p mod))))

;; Advice for editing functions

(defadvice kill-region (before longlines-encode-kill activate)
  "If the buffer is in `longlines-mode', remove all soft newlines."
  (when longlines-mode
    (longlines-encode-region (ad-get-arg 0) (ad-get-arg 1))))

(defadvice copy-region-as-kill (around longlines-encode-kill activate)
  "If the buffer is in `longlines-mode', remove all soft newlines."
  (if longlines-mode
      (let ((string (buffer-substring beg end)))
        (with-temp-buffer
          (insert string)
          (longlines-encode-region (point-min) (point-max))
          (ad-set-arg 0 (point-min))
          (ad-set-arg 1 (point-max))
          ad-do-it))
    ad-do-it))

;; Loading and saving

(defun longlines-before-revert-hook ()
  (add-hook 'after-revert-hook 'longlines-after-revert-hook nil t)
  (longlines-mode 0))

(defun longlines-after-revert-hook ()
  (remove-hook 'after-revert-hook 'longlines-after-revert-hook t)
  (longlines-mode 1))

(add-to-list
 'format-alist
 (list 'longlines "Automatically wrap long lines." nil nil
       'longlines-encode-region t nil))

(provide 'longlines)

;;; longlines.el ends here
