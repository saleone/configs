# .bashrc
# Source system definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

##
# Global settings
EDITOR="vim"; export EDITOR;

PS1="\[\033[01;39m\]\W\[\033[0m\] $ "

export VAGRANT_DEFAULT_PROVIDER=virtualbox

if [ ! -d $HOME/.local/bin ]; then mkdir $HOME/.local/bin; fi
export PATH=$HOME/.local/bin:$PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
