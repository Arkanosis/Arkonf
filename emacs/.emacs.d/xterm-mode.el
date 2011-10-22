(setq myKeywords
 '(("Sin\\|Cos\\|Sum" . font-lock-function-name-face)
   ("Pi\\|Infinity" . font-lock-constant-face)
  )
)

(define-derived-mode math-lang-mode fundamental-mode
  (setq font-lock-defaults '(myKeywords))
  (setq mode-name "math lang")
)
