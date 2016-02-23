import sys

def excepthook(type, value, tb):
   if issubclass(type, SyntaxError) or hasattr(sys, 'ps1') or \
      not (sys.stdin.isatty() and sys.stdout.isatty() and sys.stderr.isatty()) :
      sys.__excepthook__(type, value, tb)
   else:
      import traceback, pdb
      traceback.print_exception(type, value, tb)
      print()
      pdb.pm()

if __debug__:
   sys.excepthook = excepthook
