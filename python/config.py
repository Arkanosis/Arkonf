__all__ = (
    'configure',
)

def configure(repl):
    repl.show_signature = True
    repl.show_docstring = True
    repl.show_line_numbers = True
    repl.highlight_matching_parenthesis = True
    repl.confirm_exit = False
