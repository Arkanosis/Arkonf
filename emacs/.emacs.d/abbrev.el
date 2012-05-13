;;-*-coding: emacs-mule;-*-

(define-skeleton if-skel "" nil
  >    "if (" _ ") {\n"
  >    "\n"
  > -2 "}"
)
(define-skeleton elif-skel "" nil
  >    " else if (" _ ") {"
  >    "\n"
  > -2 "}"
)
(define-skeleton else-skel "" nil
  >    " else {"
  >    _ "\n"
  > -2 "}"
)
(define-skeleton for-skel "" nil
  >    "for (" _ "; ; ) {\n"
  >    "\n"
  > -2 "}"
)
(define-skeleton while-skel "" nil
  >    "while (" _ ") {\n"
  >    "\n"
  > -2 "}"
)

(define-skeleton include-skel "" nil
  "#include \"" _ "\""
)
(define-skeleton system-include-skel "" nil
  "#include <" _ ">"
)
(define-skeleton define-skel "" nil
  "#define "
)

(define-skeleton assert-skel "" nil
  "assert(" _ ");"
)
(define-skeleton andstring-skel "" nil
  "&& \"" _ "\""
)

(define-skeleton cassert-skel "" nil
  "#include <cassert>"
)
(define-skeleton iostream-skel "" nil
  "#include <iostream>"
)

(define-skeleton cout-skel "" nil
  >    "std::cout << " _ " << std::endl;"
)
(define-skeleton cerr-skel "" nil
  >    "std::cerr << " _ " << std::endl;"
)
(define-skeleton clog-skel "" nil
  >    "std::clog << " _ " << std::endl;"
)
(define-skeleton clog-display-skel "" nil
  >    "std::clog << \" :\\\"\" << " _ " << \"\\\"\" << std::endl;"
)

(define-skeleton dbg-skel "" nil
  >    "DBG(\"" _ "\")"
)
(define-skeleton dbgv-skel "" nil
  >    "DBG(\"" _ "\" <<  << \"\")"
)

(define-skeleton val-skel "" nil
  >    "<< " _ " << "
)

(define-skeleton vector-skel "" nil
  >    "std::vector<" _ ">"
)
(define-skeleton map-skel "" nil
  >    "std::map<" _ ", >"
)
(define-skeleton str-skel "" nil
  >    "std::string"
)

(define-skeleton main-skel "" nil
  >    "int main() {\n"
  >    _ "\n"
  > -2 "}"
)
(define-skeleton main-args-skel "" nil
  >    "int main(int argc, char* argv[]) {\n"
  >    _ "\n"
  > -2 "}"
)

;; Pour Exalead
(define-skeleton stdout-skel "" nil
  >    "stdout.writeln(" _ ");"
)
(define-skeleton stderr-skel "" nil
  >    "stderr.writeln(" _ ");"
)
(define-skeleton arrayelts-skel "" nil
  "ArrayElts(" _ ")"
)
(define-skeleton arraylength-skel "" nil
  "ArrayLength(" _ ")"
)
(define-skeleton xmlformat-skel "" nil
  >    "for (AnnotatedToken token in " _ ") {\n"
  >    "stdout.writeln(token, XmlFormat(prettyPrint = true));\n"
  >    "stdout.writeln();\n"
  > -2 "}\n"
)
(define-skeleton sso-skel "" nil
  >    "System.out.println(" _ ");"
)
(define-skeleton sse-skel "" nil
  >    "System.err.println(" _ ");"
)

(define-abbrev-table 'c++-mode-abbrev-table '(
  ("vva" "\" <<  << \"" nil 0)

  ("iif" "" if-skel 0)
  ("eei" "" elif-skel 0)
  ("eel" "" else-skel 0)
  ("ffo" "" for-skel 0)
  ("wwh" "" while-skel 0)

  ("iin" "" include-skel 0)
  ("ssn" "" system-include-skel 0)
  ("dde" "" define-skel 0)

  ("aas" "" assert-skel 0)
  ("aaa" "" andstring-skel 0)

  ("iia" "" cassert-skel 0)
  ("iii" "" iostream-skel 0)

  ("cco" "" cout-skel 0)
  ("cce" "" cerr-skel 0)
  ("ccl" "" clog-skel 0)
  ("cdl" "" clog-display-skel 0)

  ("ddd" "" dbg-skel 0)
  ("vvv" "" dbgv-skel 0)

  ("lll" "" val-skel 0)

  ("vve" "" vector-skel 0)
  ("mma" "" map-skel 0)
  ("sst" "" str-skel 0)

  ("mmain" "" main-skel 0)
  ("mmaina" "" main-args-skel 0)

  ;; Pour Exalead
  ("aae" "" arrayelts-skel 0)
  ("aal" "" arraylength-skel 0)
  ("xmlf" "" xmlformat-skel 0)
))

(define-abbrev-table 'exa-mode-abbrev-table '(
  ("xmlf" "" xmlformat-skel 0)
  ("cco" "" stdout-skel 0)
  ("cce" "" stderr-skel 0)
  ("ccl" "" stdout-skel 0)
))

(define-abbrev-table 'java-mode-abbrev-table '(
  ("cco" "" sso-skel 0)
  ("cce" "" sse-skel 0)
  ("ccl" "" sso-skel 0)
))

(define-abbrev-table 'shell-mode-abbrev-table '(
  (";fu" "function ()\n{\n\n}" nil 0)
))

(define-abbrev-table 'global-abbrev-table '(
))
