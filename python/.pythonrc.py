import atexit
import os
import readline
import rlcompleter

_history = os.path.expanduser('~/.zcache/python_history')

readline.parse_and_bind('set show-all-if-ambiguous on')
readline.parse_and_bind('tab: complete')

if os.path.exists(_history):
        readline.read_history_file(_history)

readline.set_history_length(-1)

def clean_and_save_history(history):
        import readline
        commands = set()
        for commandId in xrange(readline.get_current_history_length(), 0, -1):
                command = readline.get_history_item(commandId)
                if command in commands:
                        readline.remove_history_item(commandId - 1)
                else:
                        commands.add(command)
	readline.write_history_file(history)

atexit.register(clean_and_save_history, _history)

del atexit
del os
del readline
del rlcompleter
