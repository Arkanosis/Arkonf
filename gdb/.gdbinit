set prompt \033[36m(gdb) \033[0m

# C++
set print pretty
set print object
set print vtbl

set pagination off

set history save on
set history filename ~/.zcache/gdb
set history size 10000

source /ng/sdk/tools/devenv/gdb/gdbinit

define nsf
  handle SIGSEGV nostop
end
