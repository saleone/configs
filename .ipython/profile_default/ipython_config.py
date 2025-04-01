# Configuration file for ipython.
c = get_config()  #noqa

## Shortcut style to use at the prompt. 'vi' or 'emacs'.
#  Default: 'emacs'
c.TerminalInteractiveShell.editing_mode = 'vi'

## Set the editor used by IPython (default to $EDITOR/vi/notepad).
#  Default: 'nvim'
c.TerminalInteractiveShell.editor = 'nvim'
