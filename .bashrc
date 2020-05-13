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
alias vi="nvim";
alias vim="nvim";
export EDITOR="nvim";

PS1="\[\033[01;39m\]\W\[\033[0m\] $ "

export VAGRANT_DEFAULT_PROVIDER=virtualbox

if [ ! -d $HOME/.local/bin ]; then mkdir $HOME/.local/bin; fi
export PATH=$HOME/.local/bin:$PATH
