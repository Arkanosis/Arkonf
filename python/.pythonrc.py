import atexit
import os
import readline
import rlcompleter
import sys

_history = os.path.expanduser('~/.zcache/python_history')

# History
if os.path.exists(_history):
    readline.read_history_file(_history)

readline.set_history_length(-1)

def clean_and_save_history(history):
    import readline
    commands = set()
    for commandId in range(readline.get_current_history_length(), 0, -1):
        command = readline.get_history_item(commandId)
        if command in commands:
            readline.remove_history_item(commandId - 1)
        else:
            commands.add(command)
    readline.write_history_file(history)

atexit.register(clean_and_save_history, _history)

# Completion
readline.parse_and_bind('set show-all-if-ambiguous on')
readline.parse_and_bind('tab: complete')

# Prompt
sys.ps1 = '\033[36m>>> \033[0m'
sys.ps2 = '\033[36m... \033[0m'

# Pretty printing
def display(value):
    import pprint
    if value is not None:
        try:
            import __builtin__
            __builtin__._ = value
        except ImportError:
            import builtins
            builtins._ = value
    pprint.pprint(value, indent=2)
sys.displayhook = display

del atexit
del os
del readline
del rlcompleter
del sys
