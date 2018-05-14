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

;; Pour Python
(define-skeleton pmain-skel "" nil
  "#! /usr/bin/env python3\n"
  "\n"
  "import os\n"
  "import sys\n"
  "\n"
  "if __name__ == '__main__':\n"
  "    if len(sys.argv) != 2:\n"
  "        print('Usage: {}'.format(sys.argv[0].rsplit(os.sep, 1)[-1]), file=sys.stderr)\n"
  "        sys.exit(1)\n"
  "\n"
  "    with open(sys.argv[1], 'r') as input_file:\n"
  "        pass\n"
)

(define-skeleton pdef-skel "" nil
  >    "def " _ "():\n"
  >    "pass"
  )

(define-skeleton pclass-skel "" nil
  >    "class " _ ":\n"
  >    "def __init__(self):\n"
  >    "pass"
)

(define-skeleton rif-skel "" nil
  >    "if " _ " {\n"
  >    "\n"
  > -4 "}"
)
(define-skeleton relif-skel "" nil
  >    " else if " _ " {"
  >    "\n"
  > -4 "}"
)
(define-skeleton rfor-skel "" nil
  >    "for " _ " in {\n"
  >    "\n"
  > -4 "}"
)
(define-skeleton rwhile-skel "" nil
  >    "while " _ " {\n"
  >    "\n"
  > -4 "}"
)
(define-skeleton rloop-skel "" nil
  >    "loop {\n"
  >    "\n"
  > -4 "}"
)

(define-skeleton rcout-skel "" nil
  >    "println!(" _ ");"
)
(define-skeleton rcerr-skel "" nil
  >    "eprintln!(" _ ");"
)

(define-skeleton rmain-skel "" nil
  >    "fn main() {\n"
  >    _ "\n"
  > -4 "}"
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

(define-abbrev-table 'python-mode-abbrev-table '(
  ("mmain" "" pmain-skel 0)
  ("ddef" "" pdef-skel 0)
  ("cclass" "" pclass-skel 0)
))

(define-abbrev-table 'rust-mode-abbrev-table '(
  ("iif" "" rif-skel 0)
  ("eei" "" relif-skel 0)
  ("eel" "" else-skel 0)
  ("ffo" "" rfor-skel 0)
  ("wwh" "" rwhile-skel 0)
  ("wwh" "" rloop-skel 0)

  ("cco" "" rcout-skel 0)
  ("cce" "" rcerr-skel 0)

  ("mmain" "" rmain-skel 0)
))

(define-abbrev-table 'global-abbrev-table '(
))
