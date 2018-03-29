;;; linum-highlight-current-line-number.el --- highlight the current line number
;;
;; Copyright (C) 2014-2017 Emanuele Tomasi <targzeta@gmail.com>
;;
;; Author: Emanuele Tomasi <targzeta@gmail.com>
;; URL: https://github.com/targzeta/linum-highlight-current-line-number
;; Maintainer: Emanuele Tomasi <targzeta@gmail.com>
;; Keywords: convenience
;; Version: 1.0
;;
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;; A function for the `linum-format' variable to highlight the current line
;; number with a custom face.
;;
;;; Usage:
;;
;; Copy this file in a directory which is in the  Emacs `load-path'. Then,
;; execute the following code either directly or in your .emacs file:
;;
;;   (require 'linum-highlight-current-line-number)
;;   (setq linum-format 'linum-highlight-current-line-number)
;;
;; Customization:
;;
;; You can change the face for the current line number with:
;;
;; M-x customize-group and then "linum". Finally, "Linum Current Line Number Face"
;;
;;; Code:

(require 'linum)

;; Customization
(defface linum-current-line-number-face
  `((t :inherit linum
       :foreground "goldenrod"
       :weight bold))
  "Face for displaying the current line number."
  :group 'linum)

(defvar linum-current-line 1 "Current line number.")
(defvar linum-border-width 1 "Border width for linum.")

;; Functions
(defadvice linum-update (before advice-linum-update activate)
  "Set the current line."
  (setq linum-current-line (line-number-at-pos)
        ;; It's the same algorithm that linum dynamic. I only had added one
        ;; space in front of the first digit.
        linum-border-width (number-to-string
                            (+ 1 (length
                                  (number-to-string
                                   (count-lines (point-min) (point-max))))))))

(defun linum-highlight-current-line-number (line-number)
  "Highlight the current line number using `linum-current-line-number-face' face."
  (let ((face (if (= line-number linum-current-line)
                  'linum-current-line-number-face
                'linum)))
    (propertize (format (concat "%" linum-border-width "d\u2502 ") line-number)
                'face face)))

(provide 'linum-highlight-current-line-number)

;;; linum-highlight-current-line-number.el ends here
