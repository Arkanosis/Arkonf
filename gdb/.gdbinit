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
source ~/Arkonf/gdb/plugins/gdb-dashboard

define nsf
  handle SIGSEGV nostop
end

define npf
  handle SIGPIPE nostop
end

dashboard -layout source stack expressions
