# .bashrc
# Source system definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

##
# Global settings
EDITOR="vim"; export EDITOR;

PS1="\[\033[01;39m\]\W\[\033[0m\] $ "

export VAGRANT_DEFAULT_PROVIDER=virtualbox

if [ ! -d $HOME/.local/bin ]; then mkdir $HOME/.local/bin; fi
export PATH=$HOME/.local/bin:$PATH
